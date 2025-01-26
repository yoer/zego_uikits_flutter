// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:zego_uikit_beauty_plugin/zego_uikit_beauty_plugin.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

// Project imports:
import 'package:zego_uikits_demo/common/avatar.dart';
import 'package:zego_uikits_demo/data/settings.dart';
import 'package:zego_uikits_demo/data/user.dart';
import 'package:zego_uikits_demo/kits/live_streaming/cache.dart';
import 'package:zego_uikits_demo/kits/live_streaming/gifts/button.dart';
import 'package:zego_uikits_demo/kits/live_streaming/gifts/player.dart';
import 'package:zego_uikits_demo/kits/live_streaming/language.dart';
import 'foreground.dart';
import 'gifts/defines.dart';
import 'gifts/sheet.dart';

void startLiveStreaming({
  required BuildContext context,
  required String liveID,
  required bool isHost,
  bool addRoomIDPrefix = true,
  ZegoUIKitPrebuiltLiveStreamingConfigQuery? configQuery,
  ZegoUIKitPrebuiltLiveStreamingEventsQuery? eventsQuery,
}) {
  final user = UserService().loginUserNotifier.value!;

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ZegoLiveStreamingPage(
        appID: int.parse(SettingsCache().appID),
        appSign: SettingsCache().appSign,
        token: SettingsCache().appToken,
        userID: user.id,
        userName: user.name,
        roomID: addRoomIDPrefix ? 'live_$liveID' : liveID,
        isHost: isHost,
        configQuery: configQuery,
        eventsQuery: eventsQuery,
      ),
    ),
  );
}

typedef ZegoUIKitPrebuiltLiveStreamingConfigQuery
    = ZegoUIKitPrebuiltLiveStreamingConfig Function(
  ZegoUIKitPrebuiltLiveStreamingConfig config,
);

typedef ZegoUIKitPrebuiltLiveStreamingEventsQuery
    = ZegoUIKitPrebuiltLiveStreamingEvents Function(
  ZegoUIKitPrebuiltLiveStreamingEvents events,
);

class ZegoLiveStreamingPage extends StatefulWidget {
  const ZegoLiveStreamingPage({
    super.key,
    required this.appID,
    required this.appSign,
    required this.token,
    required this.userID,
    required this.userName,
    required this.roomID,
    required this.isHost,
    this.configQuery,
    this.eventsQuery,
  });

  final int appID;
  final String appSign;
  final String token;
  final String userID;
  final String userName;
  final String roomID;
  final bool isHost;

  final ZegoUIKitPrebuiltLiveStreamingConfigQuery? configQuery;
  final ZegoUIKitPrebuiltLiveStreamingEventsQuery? eventsQuery;

  @override
  State<ZegoLiveStreamingPage> createState() {
    return _ZegoLiveStreamingPageState();
  }
}

class _ZegoLiveStreamingPageState extends State<ZegoLiveStreamingPage> {
  final liveStateNotifier = ValueNotifier<ZegoLiveStreamingState>(
    ZegoLiveStreamingState.idle,
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltLiveStreaming(
        appID: widget.appID,
        appSign: widget.appSign,
        userID: widget.userID,
        userName: widget.userName,
        liveID: widget.roomID,
        config: config(),
        events: event(),
      ),
    );
  }

  ZegoUIKitPrebuiltLiveStreamingEvents event() {
    final audienceEvents = ZegoUIKitPrebuiltLiveStreamingEvents(
      onError: (ZegoUIKitError error) {
        debugPrint('onError:$error');
      },
      audioVideo: ZegoLiveStreamingAudioVideoEvents(
        onCameraTurnOnByOthersConfirmation: (BuildContext context) {
          return onTurnOnAudienceDeviceConfirmation(
            context,
            isCameraOrMicrophone: true,
          );
        },
        onMicrophoneTurnOnByOthersConfirmation: (BuildContext context) {
          return onTurnOnAudienceDeviceConfirmation(
            context,
            isCameraOrMicrophone: false,
          );
        },
      ),
    );

    final events = widget.isHost
        ? ZegoUIKitPrebuiltLiveStreamingEvents(
            onError: (ZegoUIKitError error) {
              debugPrint('onError:$error');
            },
          )
        : audienceEvents;

    events.onStateUpdated = (state) {
      liveStateNotifier.value = state;
    };

    return widget.eventsQuery?.call(events) ?? events;
  }

  ZegoUIKitPrebuiltLiveStreamingConfig config() {
    final plugins = <IZegoUIKitPlugin>[
      ZegoUIKitSignalingPlugin(),
      ...(LiveStreamingCache().supportAdvanceBeauty
          ? [ZegoUIKitBeautyPlugin()]
          : []),
    ];

    final hostConfig =
        ZegoUIKitPrebuiltLiveStreamingConfig.host(plugins: plugins);
    hostConfig.audioVideoView.foregroundBuilder =
        hostAudioVideoViewForegroundBuilder;

    final audienceConfig =
        ZegoUIKitPrebuiltLiveStreamingConfig.audience(plugins: plugins);

    var config = (widget.isHost ? hostConfig : audienceConfig)
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
      ..memberButton.builder = memberButtonBuilder

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
      ..inRoomMessage.attributes = userLevelsAttributes
      ..inRoomMessage.avatarLeadingBuilder = userLevelBuilder;

    config.innerText = LiveStreamingInnerText.current(context.locale);

    config.signalingPlugin = ZegoLiveStreamingSignalingPluginConfig(
      uninitOnDispose: false,
    );

    if (LiveStreamingCache().supportScreenSharing) {
      config.topMenuBar.buttons.add(
        ZegoLiveStreamingMenuBarButtonName.toggleScreenSharingButton,
      );
    }

    /// todo bug
    config.pip.enableWhenBackground = false;
    if (LiveStreamingCache().supportPIP) {
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
              return GiftButton(targetReceiver: host);
            },
          ),
        ),
      ];
    }

    ///  beta config
    config.pip.iOS.support = LiveStreamingCache().supportPIP;
    config.audioVideoView.showMicrophoneStateOnView =
        LiveStreamingCache().showMicrophoneStateOnView;

    return widget.configQuery?.call(config) ?? config;
  }

  Map<String, String> userLevelsAttributes() {
    return {
      'lv': Random(widget.userID.hashCode).nextInt(100).toString(),
    };
  }

  Widget memberButtonBuilder(int memberCount) {
    final remoteUsers = (widget.isHost
            ? ZegoUIKit().getRemoteUsers()
            : ZegoUIKit().getAllUsers())
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
                color: Colors.black.withOpacity(0.3),
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

  Widget hostAudioVideoViewForegroundBuilder(
    BuildContext context,
    Size size,
    ZegoUIKitUser? user,
    Map<String, dynamic> extraInfo,
  ) {
    if (user == null || user.id == widget.userID) {
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
            valueListenable: ZegoUIKit().getCameraStateNotifier(user.id),
            builder: (context, isCameraEnabled, _) {
              return GestureDetector(
                onTap: () {
                  ZegoUIKit().turnCameraOn(!isCameraEnabled, userID: user.id);
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
            valueListenable: ZegoUIKit().getMicrophoneStateNotifier(user.id),
            builder: (context, isMicrophoneEnabled, _) {
              return GestureDetector(
                onTap: () {
                  ZegoUIKit().turnMicrophoneOn(
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

  Future<bool> onTurnOnAudienceDeviceConfirmation(
    BuildContext context, {
    required bool isCameraOrMicrophone,
  }) async {
    const textStyle = TextStyle(
      fontSize: 10,
      color: Colors.white70,
    );
    const buttonTextStyle = TextStyle(
      fontSize: 10,
      color: Colors.black,
    );
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.blue[900]!.withOpacity(0.9),
          title: Text(
              "You have a request to turn on your ${isCameraOrMicrophone ? "camera" : "microphone"}",
              style: textStyle),
          content: Text(
              "Do you agree to turn on the ${isCameraOrMicrophone ? "camera" : "microphone"}?",
              style: textStyle),
          actions: [
            ElevatedButton(
              child: const Text('Cancel', style: buttonTextStyle),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            ElevatedButton(
              child: const Text('OK', style: buttonTextStyle),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  Image prebuiltImage(String name) {
    return Image.asset(name, package: 'zego_uikit_prebuilt_live_streaming');
  }
}
