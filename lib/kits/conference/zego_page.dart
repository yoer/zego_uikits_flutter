// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';

// Project imports:
import 'package:zego_uikits_demo/kits/cache.dart';
import 'package:zego_uikits_demo/kits/conference/cache.dart';

class ZegoConferencePage extends StatefulWidget {
  const ZegoConferencePage({
    super.key,
    required this.appID,
    required this.appSign,
    required this.token,
    required this.userID,
    required this.userName,
    required this.roomID,
    required this.isHost,
  });

  final int appID;
  final String appSign;
  final String token;
  final String userID;
  final String userName;
  final String roomID;
  final bool isHost;

  @override
  State<ZegoConferencePage> createState() {
    return _ZegoConferencePageState();
  }
}

class _ZegoConferencePageState extends State<ZegoConferencePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltVideoConference(
        appID: widget.appID,
        appSign: widget.appSign,
        userID: widget.userID,
        userName: widget.userName,
        conferenceID: widget.roomID,
        config: config(),
      ),
    );
  }

  ZegoUIKitPrebuiltVideoConferenceConfig config() {
    var config = ZegoUIKitPrebuiltVideoConferenceConfig();
    config.topMenuBarConfig.buttons = [
      ZegoMenuBarButtonName.showMemberListButton,
      ZegoMenuBarButtonName.switchCameraButton,
    ];
    if (KitCommonCache().supportScreenSharing) {
      config.topMenuBarConfig.buttons.add(
        ZegoMenuBarButtonName.toggleScreenSharingButton,
      );
    }
    config.audioVideoViewConfig.useVideoViewAspectFill =
        ConferenceCache().videoAspectFill;

    return config;
  }
}
