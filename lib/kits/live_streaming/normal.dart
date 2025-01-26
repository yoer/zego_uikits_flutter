// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:zego_uikits_demo/data/assets.dart';
import 'package:zego_uikits_demo/kits/live_streaming/zego_page.dart';
import 'package:zego_uikits_demo/kits/room_list.dart';
import 'cache.dart';

class NormalLiveStreamingPage extends StatefulWidget {
  const NormalLiveStreamingPage({super.key});

  @override
  State<NormalLiveStreamingPage> createState() {
    return _NormalLiveStreamingPageState();
  }
}

class _NormalLiveStreamingPageState extends State<NormalLiveStreamingPage> {
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
        );
      },
      onJoin: (liveID) {
        startLiveStreaming(
          context: context,
          liveID: liveID,
          isHost: false,
        );
      },
    );
  }
}
