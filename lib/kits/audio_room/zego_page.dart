// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zego_uikit_prebuilt_live_audio_room/zego_uikit_prebuilt_live_audio_room.dart';

// Project imports:
import 'package:zego_uikits_demo/common/avatar.dart';
import 'package:zego_uikits_demo/data/assets.dart';
import 'package:zego_uikits_demo/kits/audio_room/language.dart';
import 'cache.dart';

typedef ZegoUIKitPrebuiltLiveAudioRoomConfigQuery
    = ZegoUIKitPrebuiltLiveAudioRoomConfig Function(
  ZegoUIKitPrebuiltLiveAudioRoomConfig config,
);

typedef ZegoUIKitPrebuiltLiveAudioRoomEventsQuery
    = ZegoUIKitPrebuiltLiveAudioRoomEvents Function(
  ZegoUIKitPrebuiltLiveAudioRoomEvents events,
);

class ZegoAudioRoomPage extends StatefulWidget {
  const ZegoAudioRoomPage({
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

  final ZegoUIKitPrebuiltLiveAudioRoomConfigQuery? configQuery;
  final ZegoUIKitPrebuiltLiveAudioRoomEventsQuery? eventsQuery;

  @override
  State<ZegoAudioRoomPage> createState() {
    return _ZegoAudioRoomPageState();
  }
}

class _ZegoAudioRoomPageState extends State<ZegoAudioRoomPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltLiveAudioRoom(
        appID: widget.appID,
        appSign: widget.appSign,
        userID: widget.userID,
        userName: widget.userName,
        roomID: widget.roomID,
        config: config,
        events: events,
      ),
    );
  }

  ZegoUIKitPrebuiltLiveAudioRoomEvents get events {
    final events = ZegoUIKitPrebuiltLiveAudioRoomEvents();
    return widget.eventsQuery?.call(events) ?? events;
  }

  ZegoUIKitPrebuiltLiveAudioRoomConfig get config {
    var config = (widget.isHost
        ? ZegoUIKitPrebuiltLiveAudioRoomConfig.host()
        : ZegoUIKitPrebuiltLiveAudioRoomConfig.audience())
      ..seat = getSeatConfig()
      ..background = background()
      ..topMenuBar.buttons = [
        ZegoLiveAudioRoomMenuBarButtonName.minimizingButton,
        ZegoLiveAudioRoomMenuBarButtonName.leaveButton,
      ]
      ..userAvatarUrl = avatarURL(widget.userID);

    config.pip.enableWhenBackground = true;

    /// call invitation need keep login status
    config.signalingPlugin = ZegoLiveAudioRoomSignalingPluginConfig(
      uninitOnDispose: false,
    );

    /// multi-lingual
    config.innerText = AudioRoomInnerText.current(context.locale);
    config.confirmDialogInfo = AudioRoomInnerText.currentConfirmDialogInfo(
      context.locale,
    );

    return widget.configQuery?.call(config) ?? config;
  }

  Widget background() {
    return Stack(
      children: [
        if (AudioRoomCache().showBackground)
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fitHeight,
                image: AssetImage(AudioRoomAssets.bg),
              ),
            ),
          ),
        if (AudioRoomCache().showHostInfo)
          Positioned(
            top: 10.r,
            left: 10.r,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.all(10.r),
              child: Row(
                children: [
                  SizedBox(
                    width: 50.r,
                    height: 50.r,
                    child: avatar(widget.userID),
                  ),
                  Text(
                    ' ${widget.userName}',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  int hostSeatIndex() {
    var value = 0;

    switch (AudioRoomCache().layoutMode) {
      case AudioRoomLayoutMode.defaultLayout:
      case AudioRoomLayoutMode.full:
      case AudioRoomLayoutMode.horizontal:
      case AudioRoomLayoutMode.vertical:
      case AudioRoomLayoutMode.hostTopCenter:
      case AudioRoomLayoutMode.fourPeoples:
        break;
      case AudioRoomLayoutMode.hostCenter:
        value = 4;
        break;
    }
    return value;
  }

  List<int> lockSeatIndex() {
    var value = [0];

    switch (AudioRoomCache().layoutMode) {
      case AudioRoomLayoutMode.defaultLayout:
      case AudioRoomLayoutMode.full:
      case AudioRoomLayoutMode.horizontal:
      case AudioRoomLayoutMode.vertical:
      case AudioRoomLayoutMode.hostTopCenter:
      case AudioRoomLayoutMode.fourPeoples:
        break;
      case AudioRoomLayoutMode.hostCenter:
        value = [4];
        break;
    }

    return value;
  }

  ZegoLiveAudioRoomSeatConfig getSeatConfig() {
    var config = ZegoLiveAudioRoomSeatConfig(
      takeIndexWhenJoining: widget.isHost ? hostSeatIndex() : -1,

      /// not locked
      closeWhenJoining: false,
      hostIndexes: lockSeatIndex(),
      layout: getLayoutConfig(),
    );

    return config;
  }

  ZegoLiveAudioRoomLayoutConfig getLayoutConfig() {
    final config = ZegoLiveAudioRoomLayoutConfig();
    switch (AudioRoomCache().layoutMode) {
      case AudioRoomLayoutMode.defaultLayout:
        break;
      case AudioRoomLayoutMode.full:
        config.rowSpacing = 5;
        config.rowConfigs = List.generate(
          4,
          (index) => ZegoLiveAudioRoomLayoutRowConfig(
            count: 4,
            alignment: ZegoLiveAudioRoomLayoutAlignment.spaceBetween,
          ),
        );
        break;
      case AudioRoomLayoutMode.horizontal:
        config.rowSpacing = 5;
        config.rowConfigs = [
          ZegoLiveAudioRoomLayoutRowConfig(
            count: 8,
            alignment: ZegoLiveAudioRoomLayoutAlignment.spaceBetween,
          ),
        ];
        break;
      case AudioRoomLayoutMode.vertical:
        config.rowSpacing = 5;
        config.rowConfigs = List.generate(
          8,
          (index) => ZegoLiveAudioRoomLayoutRowConfig(
            count: 1,
            alignment: ZegoLiveAudioRoomLayoutAlignment.spaceBetween,
          ),
        );
        break;
      case AudioRoomLayoutMode.hostTopCenter:
        config.rowConfigs = [
          ZegoLiveAudioRoomLayoutRowConfig(
            count: 1,
            alignment: ZegoLiveAudioRoomLayoutAlignment.center,
          ),
          ZegoLiveAudioRoomLayoutRowConfig(
            count: 4,
            alignment: ZegoLiveAudioRoomLayoutAlignment.spaceBetween,
          ),
          ZegoLiveAudioRoomLayoutRowConfig(
            count: 4,
            alignment: ZegoLiveAudioRoomLayoutAlignment.spaceBetween,
          ),
        ];
        break;
      case AudioRoomLayoutMode.hostCenter:
        config.rowSpacing = 5;
        config.rowConfigs = [
          ZegoLiveAudioRoomLayoutRowConfig(
            count: 3,
            alignment: ZegoLiveAudioRoomLayoutAlignment.spaceBetween,
          ),
          ZegoLiveAudioRoomLayoutRowConfig(
            count: 3,
            alignment: ZegoLiveAudioRoomLayoutAlignment.spaceBetween,
          ),
          ZegoLiveAudioRoomLayoutRowConfig(
            count: 3,
            alignment: ZegoLiveAudioRoomLayoutAlignment.spaceBetween,
          ),
        ];
        break;
      case AudioRoomLayoutMode.fourPeoples:
        config.rowConfigs = [
          ZegoLiveAudioRoomLayoutRowConfig(
            count: 4,
            alignment: ZegoLiveAudioRoomLayoutAlignment.spaceBetween,
          ),
        ];
        break;
    }
    return config;
  }
}
