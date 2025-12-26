// Flutter imports:
import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';
// Project imports:
import 'package:zego_uikits_demo/data/assets.dart';
import 'package:zego_uikits_demo/data/user.dart';
import 'package:zego_uikits_demo/firestore/defines.dart';
import 'package:zego_uikits_demo/firestore/kits_service.dart';
import 'package:zego_uikits_demo/kits/live_streaming/pk/config.dart';
import 'package:zego_uikits_demo/kits/live_streaming/zego_page.dart';
import 'package:zego_uikits_demo/kits/room_list.dart';

import 'cache.dart';
import 'foreground.dart';

class LiveStreamingPKPage extends StatefulWidget {
  const LiveStreamingPKPage({super.key});

  @override
  State<LiveStreamingPKPage> createState() {
    return _LiveStreamingPKPageState();
  }
}

class _LiveStreamingPKPageState extends State<LiveStreamingPKPage> {
  final liveStateNotifier = ValueNotifier<ZegoLiveStreamingState>(
    ZegoLiveStreamingState.idle,
  );

  @override
  void initState() {
    super.initState();

    liveStateNotifier.value =
        ZegoUIKitPrebuiltLiveStreamingController().liveState;
  }

  @override
  Widget build(BuildContext context) {
    return RoomList(
      cover: Image.asset(
        LiveStreamingAssets.roomCover,
        fit: BoxFit.fitWidth,
      ),
      valueNotifier: LiveStreamingCache().roomIDList,
      showStartButton: true,
      showJoinButton: true,
      onStart: (liveID) {
        startLiveStreamingWithPK(
          context: context,
          liveID: liveID,
          isHost: true,
        );
      },
      onJoin: (liveID) {
        startLiveStreamingWithPK(
          context: context,
          liveID: liveID,
          isHost: false,
        );
      },
    );
  }

  void startLiveStreamingWithPK({
    required BuildContext context,
    required String liveID,
    required bool isHost,
  }) {
    final finalLiveID =
        LiveStreamingCache().useModulePrefix ? 'pk_$liveID' : liveID;
    startLiveStreaming(
      context: context,
      liveID: finalLiveID,
      isHost: isHost,
      configQuery: (config) {
        // config.mediaPlayer.defaultPlayer.support = false;

        config.pkBattle = pkConfig();

        config.foreground = LiveStreamingForeground(
          supportPK: isHost,
          stateNotifier: liveStateNotifier,
        );

        return config;
      },
      eventsQuery: (events) {
        final localUser = UserService().loginUserNotifier.value!;

        events.pk = ZegoLiveStreamingPKEvents(
          onIncomingRequestReceived: (event, defaultAction) {
            defaultAction.call();

            KitsFirebaseService().userTable.updateUserLiveStreamingPKState(
                  localUser.id,
                  LiveStreamingPKState.waiting,
                );
          },
          onIncomingRequestCancelled: (event, defaultAction) {
            defaultAction.call();

            KitsFirebaseService().userTable.updateUserLiveStreamingPKState(
                  localUser.id,
                  LiveStreamingPKState.idle,
                );
          },
          onIncomingRequestTimeout: (event, defaultAction) {
            defaultAction.call();

            KitsFirebaseService().userTable.updateUserLiveStreamingPKState(
                  localUser.id,
                  LiveStreamingPKState.idle,
                );
          },
          onOutgoingRequestAccepted: (event, defaultAction) {
            defaultAction.call();

            KitsFirebaseService().userTable.updateUserLiveStreamingPKState(
                  event.fromHost.id,
                  LiveStreamingPKState.inPK,
                );
          },
          onOutgoingRequestRejected: (event, defaultAction) {
            defaultAction.call();

            KitsFirebaseService().userTable.updateUserLiveStreamingPKState(
                  event.fromHost.id,
                  LiveStreamingPKState.idle,
                );
          },
          onOutgoingRequestTimeout: (event, defaultAction) {
            defaultAction.call();

            KitsFirebaseService().userTable.updateUserLiveStreamingPKState(
                  event.fromHost.id,
                  LiveStreamingPKState.idle,
                );
          },
          onEnded: (event, defaultAction) {
            defaultAction.call();

            KitsFirebaseService().userTable.updateUserLiveStreamingPKState(
                  event.fromHost.id,
                  LiveStreamingPKState.idle,
                );
          },
          onUserOffline: (event, defaultAction) {
            defaultAction.call();

            KitsFirebaseService().userTable.updateUserLiveStreamingPKState(
                  event.fromHost.id,
                  LiveStreamingPKState.idle,
                );
          },
          onUserQuited: (event, defaultAction) {
            defaultAction.call();

            KitsFirebaseService().userTable.updateUserLiveStreamingPKState(
                  event.fromHost.id,
                  LiveStreamingPKState.idle,
                );
          },
        );

        events.onStateUpdated = (state) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!mounted) {
              return;
            }
            liveStateNotifier.value = state;
          });

          final pkState =
              ZegoUIKitPrebuiltLiveStreamingController().pk.stateNotifier.value;

          final currentLoginUser = UserService().loginUserNotifier.value;

          switch (pkState) {
            case ZegoLiveStreamingPKBattleState.idle:
              KitsFirebaseService().userTable.updateUserLiveStreamingPKState(
                    currentLoginUser?.id ?? '',
                    LiveStreamingPKState.idle,
                  );
              break;
            case ZegoLiveStreamingPKBattleState.inPK:
              KitsFirebaseService().userTable.updateUserLiveStreamingPKState(
                    currentLoginUser?.id ?? '',
                    LiveStreamingPKState.inPK,
                  );
              break;
            case ZegoLiveStreamingPKBattleState.loading:
              break;
          }
        };

        return events;
      },
    );
  }
}
