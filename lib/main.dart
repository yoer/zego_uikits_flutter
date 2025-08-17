// Flutter imports:
import 'package:flutter/material.dart';

// Dart imports:
import 'dart:async';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

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
import 'firestore/fcm_service.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await FcmService.ensureInitialized();
  FcmService.handleBackgroundMessage(message);
}

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await KitsFirebaseService().init();

    // FCM service initialization, failure should not affect app startup
    try {
      await FcmService.initialize();
    } catch (e) {
      // FCM service initialization failure should not prevent app startup
      debugPrint('FCM service initialization failed: $e');
    }

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

    // Even if initialization fails, try to start the app
    try {
      runApp(
        MaterialApp(
          title: 'Zego UIKits Demo',
          home: Scaffold(
            appBar: AppBar(
              title: const Text('Zego UIKits Demo - Error State'),
              backgroundColor: Colors.red,
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error, size: 64, color: Colors.red),
                    const SizedBox(height: 16),
                    const Text(
                      'App Initialization Failed',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Some services could not start properly, but the app can still run',
                      style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Error Details:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            e.toString(),
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    } catch (fallbackError) {
      // Final fallback: display a very simple page
      try {
        runApp(
          MaterialApp(
            home: Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('App Startup Failed',
                        style: TextStyle(fontSize: 24)),
                    const SizedBox(height: 16),
                    Text('Error: $fallbackError'),
                  ],
                ),
              ),
            ),
          ),
        );
      } catch (finalError) {
        debugPrint('Final fallback also failed: $finalError');
      }
    }
  }
}
