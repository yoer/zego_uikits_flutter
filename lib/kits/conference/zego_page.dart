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

    // Basic configurations
    config.turnOnCameraWhenJoining = ConferenceCache().turnOnCameraWhenJoining;
    config.useFrontFacingCamera = ConferenceCache().useFrontFacingCamera;
    config.turnOnMicrophoneWhenJoining =
        ConferenceCache().turnOnMicrophoneWhenJoining;
    config.useSpeakerWhenJoining = ConferenceCache().useSpeakerWhenJoining;
    config.rootNavigator = ConferenceCache().rootNavigator;

    // AudioVideoViewConfig configurations
    config.audioVideoViewConfig.muteInvisible = ConferenceCache().muteInvisible;
    config.audioVideoViewConfig.isVideoMirror = ConferenceCache().isVideoMirror;
    config.audioVideoViewConfig.showMicrophoneStateOnView =
        ConferenceCache().showMicrophoneStateOnView;
    config.audioVideoViewConfig.showCameraStateOnView =
        ConferenceCache().showCameraStateOnView;
    config.audioVideoViewConfig.showUserNameOnView =
        ConferenceCache().showUserNameOnView;
    config.audioVideoViewConfig.useVideoViewAspectFill =
        ConferenceCache().videoAspectFill;
    config.audioVideoViewConfig.showAvatarInAudioMode =
        ConferenceCache().showAvatarInAudioMode;
    config.audioVideoViewConfig.showSoundWavesInAudioMode =
        ConferenceCache().showSoundWavesInAudioMode;

    // TopMenuBarConfig configurations
    config.topMenuBarConfig.isVisible = ConferenceCache().topMenuBarIsVisible;
    config.topMenuBarConfig.title = ConferenceCache().topMenuBarTitle;
    config.topMenuBarConfig.hideAutomatically =
        ConferenceCache().topMenuBarHideAutomatically;
    config.topMenuBarConfig.hideByClick =
        ConferenceCache().topMenuBarHideByClick;
    config.topMenuBarConfig.style = ConferenceCache().topMenuBarStyle == 0
        ? ZegoMenuBarStyle.light
        : ZegoMenuBarStyle.dark;
    config.topMenuBarConfig.buttons = [
      ZegoMenuBarButtonName.showMemberListButton,
      ZegoMenuBarButtonName.switchCameraButton,
    ];
    if (KitCommonCache().supportScreenSharing) {
      config.topMenuBarConfig.buttons.add(
        ZegoMenuBarButtonName.toggleScreenSharingButton,
      );
    }

    // BottomMenuBarConfig configurations
    config.bottomMenuBarConfig.hideAutomatically =
        ConferenceCache().bottomMenuBarHideAutomatically;
    config.bottomMenuBarConfig.hideByClick =
        ConferenceCache().bottomMenuBarHideByClick;
    config.bottomMenuBarConfig.maxCount =
        ConferenceCache().bottomMenuBarMaxCount;
    config.bottomMenuBarConfig.style = ConferenceCache().bottomMenuBarStyle == 0
        ? ZegoMenuBarStyle.light
        : ZegoMenuBarStyle.dark;

    // MemberListConfig configurations
    config.memberListConfig.showMicrophoneState =
        ConferenceCache().memberListShowMicrophoneState;
    config.memberListConfig.showCameraState =
        ConferenceCache().memberListShowCameraState;

    // NotificationViewConfig configurations
    config.notificationViewConfig.notifyUserLeave =
        ConferenceCache().notificationViewNotifyUserLeave;

    // DurationConfig configurations
    config.duration.isVisible = ConferenceCache().durationIsVisible;
    config.duration.canSync = ConferenceCache().durationCanSync;

    return config;
  }
}
