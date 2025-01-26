// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

// Project imports:
import 'package:zego_uikits_demo/data/assets.dart';
import 'package:zego_uikits_demo/kits/live_streaming/zego_page.dart';
import 'package:zego_uikits_demo/kits/room_list.dart';
import 'cache.dart';

class MediaLiveStreamingPage extends StatefulWidget {
  const MediaLiveStreamingPage({super.key});

  @override
  State<MediaLiveStreamingPage> createState() {
    return _MediaLiveStreamingPageState();
  }
}

class _MediaLiveStreamingPageState extends State<MediaLiveStreamingPage> {
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
        startLiveStreaming(
          context: context,
          liveID: liveID,
          isHost: true,
          configQuery: (ZegoUIKitPrebuiltLiveStreamingConfig config) {
            config.mediaPlayer.defaultPlayer.support = true;

            return config;
          },
          eventsQuery: (ZegoUIKitPrebuiltLiveStreamingEvents events) {
            events.room.onStateChanged = (ZegoUIKitRoomState state) {
              if (state.reason == ZegoRoomStateChangedReason.Logined) {
                tryAutoPlayMedia();
              }
            };

            return events;
          },
        );
      },
      onJoin: (liveID) {
        startLiveStreaming(
          context: context,
          liveID: liveID,
          isHost: false,
          configQuery: (ZegoUIKitPrebuiltLiveStreamingConfig config) {
            config.mediaPlayer.defaultPlayer.support = true;

            return config;
          },
        );
      },
    );
  }

  void tryAutoPlayMedia() {
    if (LiveStreamingCache().mediaDefaultURL.isNotEmpty) {
      ZegoUIKitPrebuiltLiveStreamingController().media.play(
            filePathOrURL: LiveStreamingCache().mediaDefaultURL,
            autoStart: LiveStreamingCache().autoPlayMedia,
          );
    }
  }
}
