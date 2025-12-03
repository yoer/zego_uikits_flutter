// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zego_uikit/zego_uikit.dart';
import 'package:zego_uikit_beauty_plugin/zego_uikit_beauty_plugin.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

// Project imports:
import 'package:zego_uikits_demo/common/avatar.dart';
import 'package:zego_uikits_demo/kits/cache.dart';
import 'package:zego_uikits_demo/kits/live_streaming/cache.dart';
import 'package:zego_uikits_demo/kits/live_streaming/foreground.dart';
import 'package:zego_uikits_demo/kits/live_streaming/gifts/button.dart';
import 'package:zego_uikits_demo/kits/live_streaming/language.dart';

ZegoUIKitPrebuiltLiveStreamingConfig getConfigs(
  bool isHost,
  String localUserID,
  String liveID,
  ValueNotifier<ZegoLiveStreamingState> liveStateNotifier,
  Locale locale,
) {
  final plugins = <IZegoUIKitPlugin>[
    ZegoUIKitSignalingPlugin(),
    ...(KitCommonCache().supportAdvanceBeauty ? [ZegoUIKitBeautyPlugin()] : []),
  ];

  final hostConfig =
      ZegoUIKitPrebuiltLiveStreamingConfig.host(plugins: plugins);
  hostConfig.audioVideoView.foregroundBuilder = (
    BuildContext context,
    Size size,
    ZegoUIKitUser? user,
    Map<String, dynamic> extraInfo,
  ) {
    return hostAudioVideoViewForegroundBuilder(
      context,
      size,
      user,
      extraInfo,
      localUserID,
      liveID,
    );
  };

  final audienceConfig =
      ZegoUIKitPrebuiltLiveStreamingConfig.audience(plugins: plugins);

  var config = (isHost ? hostConfig : audienceConfig)
    ..foreground = LiveStreamingForeground(
      displayGift: true,
      stateNotifier: liveStateNotifier,
    )
    ..audioVideoView.showUserNameOnView =
        LiveStreamingCache().showUserNameOnView
    ..audioVideoView.useVideoViewAspectFill =
        LiveStreamingCache().videoAspectFill
    ..topMenuBar.buttons = [
      ZegoLiveStreamingMenuBarButtonName.minimizingButton,
    ]
    ..memberButton.builder = (int memberCount) {
      return memberButtonBuilder(memberCount, isHost, liveID);
    }

    /// custom avatar
    ..avatarBuilder = (
      BuildContext context,
      Size size,
      ZegoUIKitUser? user,
      Map<String, dynamic> extraInfo,
    ) {
      return avatar(user?.id ?? '');
    }

    /// message attributes example
    ..inRoomMessage.attributes = () {
      return userLevelsAttributes(localUserID);
    }
    ..inRoomMessage.avatarLeadingBuilder = userLevelBuilder;

  config.innerText = LiveStreamingInnerText.current(locale);

  config.signalingPlugin = ZegoLiveStreamingSignalingPluginConfig(
    uninitOnDispose: false,
  );

  if (KitCommonCache().supportScreenSharing) {
    config.topMenuBar.buttons.add(
      ZegoLiveStreamingMenuBarButtonName.toggleScreenSharingButton,
    );
  }

  config.pip.enableWhenBackground = KitCommonCache().supportPIP;
  config.pip.iOS.support = KitCommonCache().supportPIP;
  if (KitCommonCache().supportPIP) {
    config.topMenuBar.buttons.add(
      ZegoLiveStreamingMenuBarButtonName.pipButton,
    );
  }

  if (LiveStreamingCache().supportGift) {
    config.bottomMenuBar.audienceExtendButtons =
        <ZegoLiveStreamingMenuBarExtendButton>[
      ZegoLiveStreamingMenuBarExtendButton(
        child: ValueListenableBuilder<ZegoUIKitUser?>(
          valueListenable:
              ZegoUIKitPrebuiltLiveStreamingController().coHost.hostNotifier,
          builder: (context, host, _) {
            return GiftButton(
              targetReceiver: host,
              liveID: liveID,
            );
          },
        ),
      ),
    ];
  }

  config.audioVideoView.showMicrophoneStateOnView =
      LiveStreamingCache().showMicrophoneStateOnView;

  return config;
}

Widget hostAudioVideoViewForegroundBuilder(
  BuildContext context,
  Size size,
  ZegoUIKitUser? user,
  Map<String, dynamic> extraInfo,
  //
  String localUserID,
  String liveID,
) {
  if (user == null || user.id == localUserID) {
    return Container();
  }

  const toolbarCameraNormal = 'assets/icons/toolbar_camera_normal.png';
  const toolbarCameraOff = 'assets/icons/toolbar_camera_off.png';
  const toolbarMicNormal = 'assets/icons/toolbar_mic_normal.png';
  const toolbarMicOff = 'assets/icons/toolbar_mic_off.png';
  return Positioned(
    top: 15,
    right: 0,
    child: Row(
      children: [
        ValueListenableBuilder<bool>(
          valueListenable: ZegoUIKit().getCameraStateNotifier(
            targetRoomID: liveID,
            user.id,
          ),
          builder: (context, isCameraEnabled, _) {
            return GestureDetector(
              onTap: () {
                ZegoUIKit().turnCameraOn(
                  targetRoomID: liveID,
                  !isCameraEnabled,
                  userID: user.id,
                );
              },
              child: SizedBox(
                width: size.width * 0.4,
                height: size.width * 0.4,
                child: prebuiltImage(
                  isCameraEnabled ? toolbarCameraNormal : toolbarCameraOff,
                ),
              ),
            );
          },
        ),
        SizedBox(width: size.width * 0.1),
        ValueListenableBuilder<bool>(
          valueListenable: ZegoUIKit().getMicrophoneStateNotifier(
            targetRoomID: liveID,
            user.id,
          ),
          builder: (context, isMicrophoneEnabled, _) {
            return GestureDetector(
              onTap: () {
                ZegoUIKit().turnMicrophoneOn(
                  targetRoomID: liveID,
                  !isMicrophoneEnabled,
                  userID: user.id,

                  ///  if you don't want to stop co-hosting automatically when both camera and microphone are off,
                  ///  set the [muteMode] parameter to true.
                  ///
                  ///  However, in this case, your [ZegoUIKitPrebuiltLiveStreamingConfig.stopCoHostingWhenMicCameraOff]
                  ///  should also be set to false.
                  muteMode: true,
                );
              },
              child: SizedBox(
                width: size.width * 0.4,
                height: size.width * 0.4,
                child: prebuiltImage(
                  isMicrophoneEnabled ? toolbarMicNormal : toolbarMicOff,
                ),
              ),
            );
          },
        ),
      ],
    ),
  );
}

Widget memberButtonBuilder(
  int memberCount,
  //
  bool isHost,
  String liveID,
) {
  final remoteUsers = (isHost
          ? ZegoUIKit().getRemoteUsers(targetRoomID: liveID)
          : ZegoUIKit().getAllUsers(targetRoomID: liveID))
      .take(3)
      .toList();
  return Row(
    children: [
      ...remoteUsers.map(
        (user) => Container(
          margin: EdgeInsets.symmetric(horizontal: 10.r),
          width: 50.r,
          height: 50.r,
          child: CircleAvatar(child: avatar(user.id)),
        ),
      ),
      ValueListenableBuilder<List<ZegoUIKitUser>>(
        valueListenable: ZegoUIKitPrebuiltLiveStreamingController()
            .coHost
            .requestCoHostUsersNotifier,
        builder: (context, requestCoHostUsers, _) {
          return Container(
            height: 50.r,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(20.0.r),
            ),
            alignment: Alignment.center,
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.r),
                  child: Text(
                    remoteUsers.length.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.r,
                    ),
                  ),
                ),

                /// request co-host notify red point
                if (requestCoHostUsers.isNotEmpty)
                  Positioned(
                    top: 1.r,
                    right: 1.r,
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                      width: 20.zR,
                      height: 20.zR,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    ],
  );
}

Widget userLevelBuilder(
  BuildContext context,
  ZegoInRoomMessage message,
  Map<String, dynamic> extraInfo,
) {
  return Container(
    alignment: Alignment.center,
    height: 15,
    width: 30,
    padding: const EdgeInsets.all(2),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.purple.shade300, Colors.purple.shade400],
      ),
      borderRadius: const BorderRadius.all(Radius.circular(10)),
    ),
    child: Text(
      "LV ${message.attributes['lv']}",
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 10,
      ),
    ),
  );
}

Map<String, String> userLevelsAttributes(String userID) {
  return {
    'lv': Random(userID.hashCode).nextInt(100).toString(),
  };
}

Image prebuiltImage(String name) {
  return Image.asset(name, package: 'zego_uikit_prebuilt_live_streaming');
}
