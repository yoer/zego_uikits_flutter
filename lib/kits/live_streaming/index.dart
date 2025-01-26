// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:zego_uikits_demo/data/assets.dart';
import 'package:zego_uikits_demo/data/translations.dart';
import 'package:zego_uikits_demo/kits/kits_page.dart';
import 'package:zego_uikits_demo/kits/live_streaming/normal.dart';
import 'package:zego_uikits_demo/kits/live_streaming/pk.dart';
import 'package:zego_uikits_demo/kits/live_streaming/swiping.dart';
import 'package:zego_uikits_demo/pages/utils/router.dart';
import 'live_list.dart';
import 'media.dart';

class LiveStreamingPage extends StatefulWidget {
  const LiveStreamingPage({super.key});

  @override
  State<LiveStreamingPage> createState() {
    return _LiveStreamingPageState();
  }
}

class _LiveStreamingPageState extends State<LiveStreamingPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Timer? _tabSwitchTimer;
  final _tabPageCount = 5;
  final _tagPageIndexNotifier = ValueNotifier<int>(0);

  final settingPageBackNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: _tabPageCount, vsync: this);
    _tagPageIndexNotifier.value = 0;
    _tabController.addListener(() {
      _tagPageIndexNotifier.value = _tabController.index;
    });
    // _tabSwitchTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
    //   if (_tabController.index < _tabController.length - 1) {
    //     _tabController.index++;
    //   } else {
    //     _tabController.index = 0;
    //   }
    // });
  }

  @override
  void dispose() {
    super.dispose();

    _tabController.dispose();
    _tabSwitchTimer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10.r),
            child: Text(
              '👈🏻 ${Translations.tab.swipeTips} 👉🏻',
              style: TextStyle(fontSize: 20.r, fontStyle: FontStyle.italic),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.r),
            child: PreferredSize(
              preferredSize: Size.fromHeight(30.r),
              child: ValueListenableBuilder(
                valueListenable: _tagPageIndexNotifier,
                builder: (context, tabIndex, _) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _tabPageCount,
                      (index) {
                        return GestureDetector(
                          onTap: () {
                            _tabController.index = index;
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 4.r),
                            width: 20.r,
                            height: 20.r,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: tabIndex == index
                                  ? Colors.black
                                  : Colors.yellow,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                KitsPage(
                  backgroundURL: LiveStreamingAssets.ad,
                  title: Translations.liveStreaming.title,
                  onSettingsClicked: () {
                    PageRouter.liveStreamingSettings.go(context);
                  },
                  child: const NormalLiveStreamingPage(),
                ),
                KitsPage(
                  backgroundURL: LiveStreamingAssets.adPK,
                  title: Translations.liveStreaming.pkTitle,
                  onSettingsClicked: () {
                    PageRouter.liveStreamingSettings.go(context);
                  },
                  child: const LiveStreamingPKPage(),
                ),
                KitsPage(
                  backgroundURL: LiveStreamingAssets.adLiveList,
                  title: Translations.liveStreaming.liveListTitle,
                  onSettingsClicked: () {
                    PageRouter.liveStreamingSettings.go(context).then((_) {
                      settingPageBackNotifier.value =
                          DateTime.now().millisecondsSinceEpoch;
                    });
                  },
                  child: LiveStreamingLiveListPage(
                    settingPageBackNotifier: settingPageBackNotifier,
                  ),
                ),
                KitsPage(
                  backgroundURL: LiveStreamingAssets.adSwiping,
                  title: Translations.liveStreaming.swipingTitle,
                  onSettingsClicked: () {
                    PageRouter.liveStreamingSettings.go(context);
                  },
                  child: const LiveStreamingSwipingPage(),
                ),
                KitsPage(
                  backgroundURL: LiveStreamingAssets.adMedia,
                  title: Translations.liveStreaming.mediaSharingTitle,
                  onSettingsClicked: () {
                    PageRouter.liveStreamingSettings.go(context);
                  },
                  child: const MediaLiveStreamingPage(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
