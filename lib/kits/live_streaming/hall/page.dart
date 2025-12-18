// Flutter imports:

// Package imports:
import 'package:easy_localization/easy_localization.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:zego_uikit/zego_uikit.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';
// Project imports:
import 'package:zego_uikits_demo/data/settings.dart';
import 'package:zego_uikits_demo/data/user.dart';
import 'package:zego_uikits_demo/kits/live_streaming/cache.dart';

import '../template.configs.dart';
import '../template.events.dart';

class LiveStreamingLiveHallPage extends StatefulWidget {
  const LiveStreamingLiveHallPage({
    super.key,
  });

  @override
  State<LiveStreamingLiveHallPage> createState() {
    return _LiveStreamingLiveHallPageState();
  }
}

class _LiveStreamingLiveHallPageState extends State<LiveStreamingLiveHallPage> {
  final liveStateNotifier = ValueNotifier<ZegoLiveStreamingState>(
    ZegoLiveStreamingState.idle,
  );

  @override
  Widget build(BuildContext context) {
    return hallList(
        context.locale,
        ZegoUIKitHallRoomListModel.fromActiveStreamUsers(
          activeStreamUsers: LiveStreamingCache()
              .liveListMap
              .value
              .entries
              .map((entry) => ZegoLiveStreamingHallHost(
                    user: ZegoUIKitUser(
                      id: entry.key,
                      name: 'user_${entry.key}',
                      isAnotherRoomUser: true,
                    ),
                    roomID: 'live_${entry.value}',
                  ))
              .toList(),
        ),
        null);
  }

  Widget hallList(
    Locale locale,
    ZegoLiveStreamingHallListModel? hallListModel,
    ZegoLiveStreamingHallListModelDelegate? hallListModelDelegate,
  ) {
    final user = UserService().loginUserNotifier.value!;

    return ZegoUIKitLiveStreamingHallList(
      appID: int.parse(SettingsCache().appID),
      appSign: SettingsCache().appSign,
      token: SettingsCache().appToken,
      userID: user.id,
      userName: user.name,
      configsQuery: (String liveID) {
        return getConfigs(
          false,
          user.id,
          liveID,
          liveStateNotifier,
          locale,
        );
      },
      eventsQuery: (String liveID) {
        return getHallEvents(
          false,
          liveStateNotifier,
        );
      },
      hallModel: hallListModel,
      hallModelDelegate: hallListModelDelegate,
      hallConfig: ZegoLiveStreamingHallListConfig(
        video: ZegoVideoConfigExtension.preset180P(),
        streamMode: LiveStreamingCache().streamMode,
        audioVideoResourceMode: ZegoUIKitStreamResourceMode.OnlyRTC,
      ),
    );
  }

  ZegoUIKitPrebuiltLiveStreamingEvents getHallEvents(
    bool isHost,
    ValueNotifier<ZegoLiveStreamingState> liveStateNotifier,
  ) {
    final events = getEvents(
      false,
      liveStateNotifier,
    );

    events.hall = ZegoLiveStreamingHallEvents(
      onPagePushReplace: (
        BuildContext context,
        String fromLiveID,
        ZegoLiveStreamingHallListModel? hallListModel,
        ZegoLiveStreamingHallListModelDelegate? hallListModelDelegate,
      ) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => hallList(
              context.locale,
              hallListModel,
              hallListModelDelegate,
            ),
          ),
        );
      },
    );

    return events;
  }
}
