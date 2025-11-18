// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

// Project imports:
import 'package:zego_uikits_demo/common/avatar.dart';
import 'package:zego_uikits_demo/data/settings.dart';
import 'package:zego_uikits_demo/data/translations.dart';
import 'package:zego_uikits_demo/kits/live_streaming/cache.dart';
import 'package:zego_uikits_demo/kits/live_streaming/zego_page.dart';

import 'page.dart';

class LiveStreamingLiveHallHome extends StatefulWidget {
  const LiveStreamingLiveHallHome({
    super.key,
    required this.settingPageBackNotifier,
  });

  final ValueNotifier<int> settingPageBackNotifier;

  @override
  State<LiveStreamingLiveHallHome> createState() {
    return _LiveStreamingLiveHallHomeState();
  }
}

class _LiveStreamingLiveHallHomeState extends State<LiveStreamingLiveHallHome> {
  final liveHallController = ZegoLiveStreamingHallListController();

  var currentPageIndex = 0;
  final hallHostsNotifier = ValueNotifier<List<ZegoLiveStreamingHallHost>>([]);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: widget.settingPageBackNotifier,
      builder: (context, _, __) {
        onLiveListMapUpdate();

        return ValueListenableBuilder(
          valueListenable: hallHostsNotifier,
          builder: (context, isHostInfoEmpty, _) {
            return hallHostsNotifier.value.isEmpty
                ? liveListEmptyTips()
                : liveListButton();
          },
        );
      },
    );
  }

  Widget liveListEmptyTips() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.5),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(color: Colors.white),
            Text(
              Translations.liveStreaming.liveListEmptyTips,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 30.r),
            )
          ],
        ),
      ),
    );
  }

  Widget liveListButton() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LiveStreamingLiveHallPage(),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
            padding: EdgeInsets.symmetric(
              vertical: 20.r,
              horizontal: 20.r,
            ), // 设置高度和宽度
          ),
          child: Text(
            Translations.tips.start,
            style: TextStyle(color: Colors.white, fontSize: 20.r),
          ),
        ),
      ),
    );
  }

  void onLiveListMapUpdate() {
    hallHostsNotifier.value = LiveStreamingCache()
        .liveListMap
        .value
        .entries
        .map((entry) => ZegoLiveStreamingHallHost(
              user: ZegoUIKitUser(id: entry.key, name: ''),
              roomID: 'live_${entry.value}',
            ))
        .toList();

    debugPrint(
      'hall list data update ${hallHostsNotifier.value.length}, '
      '${hallHostsNotifier.value.map((e) => '${e.user.id}, ${e.roomID};')}, ',
    );
  }
}
