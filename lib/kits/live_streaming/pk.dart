// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    startLiveStreaming(
      context: context,
      liveID: 'pk_$liveID',
      isHost: isHost,
      configQuery: (config) {
        // config.mediaPlayer.defaultPlayer.support = false;

        config.audioVideoView.foregroundBuilder = (
          BuildContext context,
          Size size,
          ZegoUIKitUser? user,
          Map<String, dynamic> extraInfo,
        ) {
          return foregroundBuilder(isHost, context, size, user, extraInfo);
        };
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
          liveStateNotifier.value = state;

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

  Widget foregroundBuilder(
    bool isHost,
    BuildContext context,
    Size size,
    ZegoUIKitUser? user,
    extraInfo,
  ) {
    if (user == null) {
      return Container();
    }

    return ValueListenableBuilder(
      valueListenable: liveStateNotifier,
      builder: (context, state, _) {
        return state == ZegoLiveStreamingState.inPKBattle
            ? Stack(
                children: [
                  /// camera state
                  Positioned(
                    bottom: 10.r,
                    right: 10.r * 2 + 20.r,
                    child: SizedBox(
                      width: 20.r,
                      height: 20.r,
                      child: CircleAvatar(
                        backgroundColor: Colors.black.withValues(alpha: 0.5),
                        child: Icon(
                          user.camera.value
                              ? Icons.videocam
                              : Icons.videocam_off,
                          color: Colors.white,
                          size: 18.r,
                        ),
                      ),
                    ),
                  ),

                  /// microphone state
                  Positioned(
                    bottom: 10.r,
                    right: 10.r,
                    child: SizedBox(
                      width: 20.r,
                      height: 20.r,
                      child: CircleAvatar(
                        backgroundColor: Colors.black.withValues(alpha: 0.5),
                        child: Icon(
                          user.microphone.value ? Icons.mic : Icons.mic_off,
                          color: Colors.white,
                          size: 18.r,
                        ),
                      ),
                    ),
                  ),

                  /// name
                  Positioned(
                    bottom: 10.r,
                    left: 10.r,
                    child: Container(
                      height: 40.r,
                      padding: EdgeInsets.all(5.r),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4.r)),
                        color: Colors.black.withValues(alpha: 0.5),
                      ),
                      child: Text(
                        user.name,
                        style: TextStyle(
                          fontSize: 20.r,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : const SizedBox();
      },
    );
  }
}
