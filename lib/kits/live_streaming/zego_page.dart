// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

// Project imports:
import 'package:zego_uikits_demo/data/settings.dart';
import 'package:zego_uikits_demo/data/user.dart';
import 'package:zego_uikits_demo/kits/live_streaming/template.configs.dart';
import 'package:zego_uikits_demo/kits/live_streaming/template.events.dart';

typedef ZegoUIKitPrebuiltLiveStreamingConfigQuery
    = ZegoUIKitPrebuiltLiveStreamingConfig Function(
  ZegoUIKitPrebuiltLiveStreamingConfig config,
);
typedef ZegoUIKitPrebuiltLiveStreamingEventsQuery
    = ZegoUIKitPrebuiltLiveStreamingEvents Function(
  ZegoUIKitPrebuiltLiveStreamingEvents events,
);

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
        liveID: addRoomIDPrefix ? 'live_$liveID' : liveID,
        isHost: isHost,
        configQuery: configQuery,
        eventsQuery: eventsQuery,
      ),
    ),
  );
}

class ZegoLiveStreamingPage extends StatefulWidget {
  const ZegoLiveStreamingPage({
    super.key,
    required this.appID,
    required this.appSign,
    required this.token,
    required this.userID,
    required this.userName,
    required this.liveID,
    required this.isHost,
    this.configQuery,
    this.eventsQuery,
  });

  final int appID;
  final String appSign;
  final String token;
  final String userID;
  final String userName;
  final String liveID;
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
    final configs = getConfigs(
      widget.isHost,
      widget.userID,
      widget.liveID,
      liveStateNotifier,
      context.locale,
    );
    final events = getEvents(
      widget.isHost,
      liveStateNotifier,
    );
    return SafeArea(
      child: ZegoUIKitPrebuiltLiveStreaming(
        appID: widget.appID,
        appSign: widget.appSign,
        userID: widget.userID,
        userName: widget.userName,
        liveID: widget.liveID,
        config: widget.configQuery?.call(configs) ?? configs,
        events: widget.eventsQuery?.call(events) ?? events,
      ),
    );
  }
}
