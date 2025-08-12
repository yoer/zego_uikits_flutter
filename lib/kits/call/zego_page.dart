// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:zego_uikit_beauty_plugin/zego_uikit_beauty_plugin.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

// Project imports:
import 'package:zego_uikits_demo/kits/cache.dart';
import 'package:zego_uikits_demo/kits/call/utils.dart';

class ZegoCallPage extends StatefulWidget {
  const ZegoCallPage({
    super.key,
    required this.appID,
    required this.appSign,
    required this.token,
    required this.userID,
    required this.userName,
    required this.roomID,
    required this.isGroup,
    required this.isVideo,
  });

  final int appID;
  final String appSign;
  final String token;
  final String userID;
  final String userName;
  final String roomID;
  final bool isVideo;
  final bool isGroup;

  @override
  State<ZegoCallPage> createState() {
    return _ZegoCallPageState();
  }
}

class _ZegoCallPageState extends State<ZegoCallPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltCall(
        appID: widget.appID,
        appSign: widget.appSign,
        userID: widget.userID,
        userName: widget.userName,
        callID: widget.roomID,
        config: config,
        plugins: [
          ...(KitCommonCache().supportAdvanceBeauty
              ? [ZegoUIKitBeautyPlugin()]
              : []),
        ],
      ),
    );
  }

  ZegoUIKitPrebuiltCallConfig get config {
    var config = callConfig(
      context: context,
      isGroup: widget.isGroup,
      isVideo: widget.isVideo,
    );

    if (KitCommonCache().supportAdvanceBeauty) {
      config.bottomMenuBar.buttons.add(
        ZegoCallMenuBarButtonName.beautyEffectButton,
      );
    }

    return config;
  }
}
