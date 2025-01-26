// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:zego_uikits_demo/data/assets.dart';
import 'package:zego_uikits_demo/data/translations.dart';

enum BottomNavIndex {
  call,
  liveStreaming,
  audioRoom,
  conference,
  chat,
}

extension BottomNavIndexExtension on BottomNavIndex {
  String get text {
    switch (this) {
      case BottomNavIndex.call:
        return Translations.tab.call;
      case BottomNavIndex.liveStreaming:
        return Translations.tab.liveStreaming;
      case BottomNavIndex.audioRoom:
        return Translations.tab.audioRoom;
      case BottomNavIndex.conference:
        return Translations.tab.conference;
      case BottomNavIndex.chat:
        return Translations.tab.im;
    }
  }

  int get pageIndex {
    switch (this) {
      case BottomNavIndex.call:
        return 0;
      case BottomNavIndex.liveStreaming:
        return 1;
      case BottomNavIndex.audioRoom:
        return 2;
      case BottomNavIndex.conference:
        return 3;
      case BottomNavIndex.chat:
        return 4;
    }
  }

  Widget get icon {
    switch (this) {
      case BottomNavIndex.call:
        return Image.asset(MyIcons.navCall);
      case BottomNavIndex.liveStreaming:
        return Image.asset(MyIcons.navLiveStreaming);
      case BottomNavIndex.audioRoom:
        return Image.asset(MyIcons.navAudioRoom);
      case BottomNavIndex.conference:
        return Image.asset(MyIcons.navConference);
      case BottomNavIndex.chat:
        return Image.asset(MyIcons.navChat);
    }
  }
}
