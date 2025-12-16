// Dart imports:
import 'dart:ui';

// Package imports:
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

// Project imports:
import 'package:zego_uikits_demo/data/translations.dart';

class LiveStreamingInnerText {
  static ZegoUIKitPrebuiltLiveStreamingInnerText current(Locale locale) {
    if (locale.languageCode == MyLocale.enUS.languageCode) {
      return ZegoUIKitPrebuiltLiveStreamingInnerText();
    } else if (locale.languageCode == MyLocale.zhCN.languageCode) {
      return ZegoUIKitPrebuiltLiveStreamingInnerTextZhCN();
    } else if (locale.languageCode == MyLocale.hiIN.languageCode) {
      return ZegoUIKitPrebuiltLiveStreamingInnerTextHi();
    }

    return ZegoUIKitPrebuiltLiveStreamingInnerText();
  }
}
