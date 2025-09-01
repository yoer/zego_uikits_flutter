// Dart imports:
import 'dart:async';
import 'dart:io';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Project imports:
import 'package:zego_uikits_demo/firebase_options.dart';
import 'defines.dart';

class FcmService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  static bool _initialized = false;

  static Future<void> ensureInitialized() async {
    if (!_initialized) {
      await initialize();
    }
  }

  static Future<void> initialize() async {
    if (_initialized) return;

    // Ensure Firebase is initialized (uses the same app name as KitsFirebaseService)
    try {
      if (Firebase.apps.where((a) => a.name == firebaseProjectName).isEmpty) {
        await Firebase.initializeApp(
          name: firebaseProjectName,
          options: DefaultFirebaseOptions.currentPlatform,
        );
      }
    } catch (_) {
      // Already initialized; ignore
    }

    await _configureLocalNotifications();

    if (Platform.isIOS) {
      await _requestPermissionIOS();
    } else if (Platform.isAndroid) {
      await _requestPermissionAndroid();
    }

    // Retrieve and print the token (you can upload it to your server/Firestore here)
    try {
      // Add timeout mechanism to avoid infinite waiting
      final token = await _messaging.getToken().timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException(
              'FCM token request timeout', const Duration(seconds: 10));
        },
      );
      debugPrint('FCM token: $token');
    } catch (e) {
      // Token fetch failure should not prevent the entire service initialization
      debugPrint('FCM token fetch failed: $e');
    }

    // Listen for token refresh
    _messaging.onTokenRefresh.listen((newToken) {
      debugPrint('FCM token refreshed: $newToken');
    });

    // Foreground messages
    FirebaseMessaging.onMessage.listen(handleForegroundMessage);

    // Tapping a notification to return to the app
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessageOpenedApp);

    // Handle cold start launched via notification
    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      handleMessageOpenedApp(initialMessage);
    }

    _initialized = true;
  }

  static Future<void> _configureLocalNotifications() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings();

    await _localNotifications.initialize(
      const InitializationSettings(android: androidInit, iOS: iosInit),
    );

    if (Platform.isAndroid) {
      final android = _localNotifications.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();
      await android?.createNotificationChannel(const AndroidNotificationChannel(
        'high_importance_channel',
        'High Importance Notifications',
        description: 'Used for important notifications.',
        importance: Importance.max,
      ));
    }
  }

  static Future<void> _requestPermissionIOS() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );
    debugPrint('iOS Notification permission: ${settings.authorizationStatus}');
  }

  static Future<void> _requestPermissionAndroid() async {
    // Notification permission for Android 13+
    await _messaging.requestPermission();
  }

  static void handleForegroundMessage(RemoteMessage message) {
    final notification = message.notification;
    final android = notification?.android;

    debugPrint('fcm handleForegroundMessage, ${notification?.title} '
        '${notification?.body}');

    if (notification != null) {
      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel',
            'High Importance Notifications',
            channelDescription: 'Used for important notifications.',
            icon: android?.smallIcon ?? '@mipmap/ic_launcher',
            importance: Importance.max,
            priority: Priority.high,
          ),
          iOS: const DarwinNotificationDetails(),
        ),
        payload: message.data.isNotEmpty ? message.data.toString() : null,
      );
    }
  }

  @pragma('vm:entry-point')
  static Future<void> handleBackgroundMessage(RemoteMessage message) async {
    // Use message.data here to navigate or update state
    debugPrint('Handling a background message: ${message.messageId}, '
        '${message.notification?.title}, '
        '${message.notification?.body}');
  }

  static void handleMessageOpenedApp(RemoteMessage message) {
    // Handling when a notification opens the app, e.g., navigate to a specific page
    debugPrint('Notification caused app to open: ${message.messageId}, '
        '${message.notification?.title}, '
        '${message.notification?.body}');
  }
}
