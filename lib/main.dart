// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:zego_uikits_demo/data/settings.dart';
import 'package:zego_uikits_demo/firestore/kits_service.dart';

// Project imports:
import 'app.dart';
import 'data/translations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await KitsFirebaseService().init();

  await EasyLocalization.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
  );

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
}
