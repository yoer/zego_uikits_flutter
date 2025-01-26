// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkStatus {
  final valueNotifier = ValueNotifier<bool>(false);

  factory NetworkStatus() => instance;
  static final NetworkStatus instance = NetworkStatus._internal();

  NetworkStatus._internal() {
    initConnectivity();

    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late List<ConnectivityResult> result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      return;
    }

    _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    _connectionStatus = result;

    valueNotifier.value =
        _connectionStatus.contains(ConnectivityResult.mobile) ||
            _connectionStatus.contains(ConnectivityResult.wifi) ||
            _connectionStatus.contains(ConnectivityResult.ethernet);
  }

  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();
}

class NetworkLoading extends StatefulWidget {
  final Widget child;
  final String? tips;

  const NetworkLoading({
    required this.child,
    this.tips,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => NetworkLoadingState();
}

class NetworkLoadingState extends State<NetworkLoading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<bool>(
        valueListenable: NetworkStatus().valueNotifier,
        builder: (context, isConnected, _) {
          return LayoutBuilder(
            builder: (context, constraints) {
              final height = double.infinity == constraints.maxHeight
                  ? 10.0
                  : constraints.maxHeight;
              final fontSize = height > 20.0 ? 20.0 : height;

              return Stack(
                children: [
                  widget.child,
                  if (!isConnected)
                    Container(
                      width: constraints.maxWidth,
                      height: height,
                      color: Colors.black54,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const CircularProgressIndicator(),
                          Text(
                            widget.tips ?? 'Network Loading...',
                            style: TextStyle(
                              fontSize: fontSize,
                              color: Colors.white,
                            ), // White text for contrast
                          ),
                        ],
                      ),
                    ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
