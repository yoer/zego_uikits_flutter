// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';

// Project imports:
import 'package:zego_uikits_demo/data/settings.dart';
import 'package:zego_uikits_demo/firestore/kits_service.dart';
import 'package:zego_uikits_demo/kits/cache.dart';
import 'app.dart';
import 'data/translations.dart';
import 'data/user.dart';
import 'kits/audio_room/cache.dart';
import 'kits/call/cache.dart';
import 'kits/conference/cache.dart';
import 'kits/live_streaming/cache.dart';
import 'kits/live_streaming/gifts/service.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    await KitsFirebaseService().init();

    await EasyLocalization.ensureInitialized();

    await SettingsCache().load();
    await KitCommonCache().load();
    await AudioRoomCache().load();
    await CallCache().load();
    await LiveStreamingCache().load();
    await ConferenceCache().load();
    await GiftService().init();
    await UserService().tryAutoLogin();

    runApp(
      EasyLocalization(
        supportedLocales: [
          MyLocale.enUS,
          MyLocale.zhCN,
          MyLocale.hiIN,
        ],
        path: 'assets/csv/langs.csv',
        assetLoader: CsvAssetLoader(),
        fallbackLocale: const Locale('en', 'US'),
        child: const App(),
      ),
    );
  } catch (e, stack) {
    debugPrint('Error during initialization: $e');
    debugPrint('Stack trace: $stack');
  }
}
