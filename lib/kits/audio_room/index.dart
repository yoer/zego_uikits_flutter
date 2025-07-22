// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:zego_uikits_demo/data/assets.dart';
import 'package:zego_uikits_demo/data/translations.dart';
import 'package:zego_uikits_demo/kits/audio_room/normal.dart';
import 'package:zego_uikits_demo/kits/kits_page.dart';
import 'package:zego_uikits_demo/pages/utils/router.dart';
import 'media.dart';

class AudioRoomPage extends StatefulWidget {
  const AudioRoomPage({super.key});

  @override
  State<AudioRoomPage> createState() {
    return _AudioRoomPageState();
  }
}

class _AudioRoomPageState extends State<AudioRoomPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Timer? _tabSwitchTimer;
  final _tabPageCount = 2;
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
                  backgroundURL: AudioRoomAssets.ad,
                  title: Translations.audioRoom.title,
                  onSettingsClicked: () {
                    PageRouter.audioRoomSettings.go(context);
                  },
                  child: const NormalAudioRoomPage(),
                ),
                KitsPage(
                  backgroundURL: AudioRoomAssets.adMedia,
                  title: Translations.audioRoom.mediaSharingTitle,
                  onSettingsClicked: () {
                    PageRouter.audioRoomSettings.go(context);
                  },
                  child: const MediaAudioRoomPage(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
