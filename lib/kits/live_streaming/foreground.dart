import 'package:flutter/cupertino.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';
import 'package:zego_uikits_demo/kits/live_streaming/pk/foreground.dart';

import 'gifts/player.dart';

class LiveStreamingForeground extends StatefulWidget {
  const LiveStreamingForeground({
    super.key,
    required this.stateNotifier,
    this.displayGift = true,
    this.supportPK = false,
  });

  final bool displayGift;
  final bool supportPK;
  final ValueNotifier<ZegoLiveStreamingState> stateNotifier;

  @override
  State<StatefulWidget> createState() {
    return _LiveStreamingForegroundState();
  }
}

class _LiveStreamingForegroundState extends State<LiveStreamingForeground> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (widget.displayGift) const LiveStreamingGiftPlayer(),
        if (widget.supportPK)
          LiveStreamingPKForeground(
            stateNotifier: widget.stateNotifier,
          ),
      ],
    );
  }
}
