// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Package imports:
import 'package:permission_handler/permission_handler.dart';

// Project imports:
import 'package:zego_uikits_demo/common/toast.dart';
import 'package:zego_uikits_demo/data/translations.dart';
import 'package:zego_uikits_demo/pages/test/stream_test/room.dart';
import 'package:zego_uikits_demo/pages/test/stream_test/settings.dart';
import 'package:zego_uikits_demo/pages/test/stream_test/defines.dart';

class StreamTestPage extends StatefulWidget {
  const StreamTestPage({super.key});

  @override
  State<StreamTestPage> createState() => _StreamTestPageState();
}

class _StreamTestPageState extends State<StreamTestPage>
    with TickerProviderStateMixin {
  final readyNotifier = ValueNotifier<bool>(false);
  late TabController _tabController;

  final TextEditingController _roomIdController = TextEditingController(
    text: 'test_room_id',
  );

  // 本地推流信息
  final TextEditingController _localUserIdController = TextEditingController(
    text: 'test_user_id',
  );
  final TextEditingController _localUserNameController = TextEditingController(
    text: 'test_user_name',
  );
  final TextEditingController _localStreamIdController = TextEditingController(
    text: 'test_stream_id',
  );

  // 远端拉流信息
  final TextEditingController _remoteUserIdController = TextEditingController(
    text: 'remote_user_id',
  );
  final TextEditingController _remoteUserNameController = TextEditingController(
    text: 'remote_user_name',
  );
  final TextEditingController _remoteStreamIdController = TextEditingController(
    text: 'remote_stream_id',
  );

  bool _turnOnCamera = true;
  bool _turnOnMicrophone = true;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _roomIdController.dispose();

    _localUserIdController.dispose();
    _localUserNameController.dispose();
    _localStreamIdController.dispose();

    _remoteUserIdController.dispose();
    _remoteUserNameController.dispose();
    _remoteStreamIdController.dispose();

    _tabController.dispose();
    readyNotifier.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: readyNotifier,
      builder: (context, tryEnterRoom, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(Translations.streamTest.title),
            centerTitle: true,
            bottom: !tryEnterRoom
                ? TabBar(
                    controller: _tabController,
                    tabs: [
                      Tab(text: Translations.streamTest.localStream),
                      Tab(text: Translations.streamTest.remoteStream),
                    ],
                  )
                : null,
          ),
          body: Stack(
            children: [
              tryEnterRoom
                  ? StreamTestRoomWidget(
                      settings: StreamTestSettings(
                        roomId: _roomIdController.text,
                        userId: _localUserIdController.text,
                        userName: _localUserNameController.text,
                        streamId: _localStreamIdController.text,
                        turnOnCamera: _turnOnCamera,
                        turnOnMicrophone: _turnOnMicrophone,
                        remoteUserId: _remoteUserIdController.text,
                        remoteUserName: _remoteUserNameController.text,
                        remoteStreamId: _remoteStreamIdController.text,
                      ),
                      onLeaveRoom: _leaveRoom,
                    )
                  : Padding(
                      padding: EdgeInsets.all(22.r),
                      child: Column(
                        children: [
                          StreamTestSettingsWidget(
                            roomIdController: _roomIdController,
                            localUserIdController: _localUserIdController,
                            localUserNameController: _localUserNameController,
                            localStreamIdController: _localStreamIdController,
                            remoteUserIdController: _remoteUserIdController,
                            remoteUserNameController: _remoteUserNameController,
                            remoteStreamIdController: _remoteStreamIdController,
                            turnOnCamera: _turnOnCamera,
                            turnOnMicrophone: _turnOnMicrophone,
                            onCameraChanged: (value) {
                              setState(() {
                                _turnOnCamera = value;
                              });
                            },
                            onMicrophoneChanged: (value) {
                              setState(() {
                                _turnOnMicrophone = value;
                              });
                            },
                            tabController: _tabController,
                          ),
                          // Join Room Button
                          SizedBox(
                            width: double.infinity,
                            height: 70.r,
                            child: ElevatedButton(
                              onPressed: _joinRoom,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                              ),
                              child: Text(
                                Translations.streamTest.joinRoom,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40.r,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }

  void _joinRoom() async {
    if (_roomIdController.text.isEmpty ||
        _localUserIdController.text.isEmpty ||
        _localUserNameController.text.isEmpty) {
      showInfoToast(Translations.streamTest.pleaseFillFields);
      return;
    }

    // 请求权限
    await _requestPermissions();

    readyNotifier.value = true;
  }

  Future<void> _requestPermissions() async {
    if (_turnOnCamera) {
      await Permission.camera.request();
    }
    if (_turnOnMicrophone) {
      await Permission.microphone.request();
    }
  }

  void _leaveRoom() {
    readyNotifier.value = false;
  }
}
