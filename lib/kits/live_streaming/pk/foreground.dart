import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';
import 'package:zego_uikits_demo/common/bottom_sheet.dart';

import '../../../common/avatar.dart';
import '../../../data/assets.dart';
import '../../../data/translations.dart';
import '../../../data/user.dart';
import '../../../firestore/kits_service.dart';
import '../../../firestore/user_doc.dart';
import 'host_list.dart';

class LiveStreamingPKForeground extends StatefulWidget {
  const LiveStreamingPKForeground({
    super.key,
    required this.stateNotifier,
  });

  final ValueNotifier<ZegoLiveStreamingState> stateNotifier;

  @override
  State<StatefulWidget> createState() {
    return _LiveStreamingPKForegroundState();
  }
}

class _LiveStreamingPKForegroundState extends State<LiveStreamingPKForeground> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: widget.stateNotifier,
        builder: (context, state, _) {
          return state == ZegoLiveStreamingState.living ||
                  state == ZegoLiveStreamingState.inPKBattle
              ? Stack(
                  children: [
                    Positioned(
                      bottom: 100.r,
                      left: 50.r,
                      child: bottomSheetButton(),
                    ),
                  ],
                )
              : const SizedBox();
        });
  }

  Widget bottomSheetButton() {
    return GestureDetector(
      onTap: () {
        openBottomSheet(
          context: context,
          title: Translations.liveStreaming.hostListTitle,
          child: LiveStreamingPKHostList(
            stateNotifier: widget.stateNotifier,
          ),
          heightFactor: 0.8,
          backgroundColor: Colors.white.withOpacity(0.9),
        );
      },
      child: Image.asset(
        MyIcons.pk,
        width: 80.r,
        height: 80.r,
      ),
    );
  }
}
