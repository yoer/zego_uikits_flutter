// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zego_uikit/zego_uikit.dart';

// Project imports:
import 'package:zego_uikits_demo/kits/express_event_handler.dart';
import 'package:zego_uikits_demo/pages//utils/style.dart';

class KitsPage extends StatefulWidget {
  const KitsPage({
    super.key,
    required this.backgroundURL,
    required this.title,
    required this.child,
    this.onSettingsClicked,
  });

  final String backgroundURL;
  final String title;
  final Widget child;
  final VoidCallback? onSettingsClicked;

  @override
  State<KitsPage> createState() {
    return _KitsPageState();
  }
}

class _KitsPageState extends State<KitsPage> {
  final expressEventHandler = ExpressEventHandler();

  @override
  void initState() {
    super.initState();

    ZegoUIKit().registerExpressEvent(expressEventHandler);
  }

  @override
  void dispose() {
    super.dispose();

    ZegoUIKit().unregisterExpressEvent(expressEventHandler);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (
      context,
      constraints,
    ) {
      final logoHeight = constraints.maxHeight * 0.25;

      return SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue[900]!,
                    Colors.black,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: logo(logoHeight),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: title(),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: settings(),
                  ),
                ],
              ),
            ),
            Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight -
                  logoHeight -
                  PageStyle.navigatorBarHeight(),
              margin: EdgeInsets.all(10.r),
              child: widget.child,
            ),
          ],
        ),
      );
    });
  }

  Widget settings() {
    return IconButton(
      icon: Icon(
        Icons.settings,
        size: 60.r,
        color: Colors.white,
      ),
      onPressed: () {
        widget.onSettingsClicked?.call();
      },
    );
  }

  Widget title() {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [
          Colors.blue,
          Colors.white,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(bounds),
      child: Text(
        widget.title,
        style: TextStyle(color: Colors.white, fontSize: 35.r),
      ),
    );
  }

  Widget logo(double height) {
    return Container(
      padding: EdgeInsets.only(top: 80.r, bottom: 10.r),
      height: height,
      child: Image.asset(
        widget.backgroundURL,
      ),
    );
  }
}
