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
    debugPrint('FcmService.initialize: Starting...');
    
    if (_initialized) {
      debugPrint('FcmService.initialize: Already initialized, skipping');
      return;
    }

    // Ensure Firebase is initialized (uses the same app name as KitsFirebaseService)
    // Step 1: Ensure Firebase is initialized
    try {
      if (Firebase.apps.where((a) => a.name == firebaseProjectName).isEmpty) {
        await Firebase.initializeApp(
          name: firebaseProjectName,
          options: DefaultFirebaseOptions.currentPlatform,
        );
      } 
    } catch (e) {
      debugPrint('FcmService.initialize: Firebase configuration error (this is usually OK): $e');
    }

    // Step 2: Configure local notifications
    await _configureLocalNotifications();

    // Step 3: Request permissions
    if (Platform.isIOS) {
      await _requestPermissionIOS();
    } else if (Platform.isAndroid) {
      await _requestPermissionAndroid();
    }

    // Step 4: Get FCM token
    try {
      final token = await _messaging.getToken().timeout(
        const Duration(seconds: 2),
        onTimeout: () {
          throw TimeoutException(
              'FCM token request timeout', const Duration(seconds: 2));
        },
      );
    } catch (e) {
      debugPrint('FcmService.initialize: FCM token fetch failed (non-critical): $e');
    }

    // Step 5: Listen for token refresh
    _messaging.onTokenRefresh.listen((newToken) {
      debugPrint('FcmService.initialize: FCM token refreshed: ${newToken.substring(0, 20)}...');
    });

    // Step 6: Set up message listeners
    FirebaseMessaging.onMessage.listen(handleForegroundMessage);
    
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessageOpenedApp);

    // Step 7: Handle cold start via notification (with timeout to avoid blocking)
    try {
      final initialMessage = await _messaging.getInitialMessage().timeout(
        const Duration(seconds: 2),
        onTimeout: () {
          debugPrint('FcmService.initialize: getInitialMessage timeout (no notification launched app)');
          return null;
        },
      );
      if (initialMessage != null) {
        handleMessageOpenedApp(initialMessage);
      }
    } catch (e) {
      debugPrint('FcmService.initialize: getInitialMessage error (non-critical): $e');
    }

    _initialized = true;
    debugPrint('FcmService.initialize: COMPLETED SUCCESSFULLY');
  }

  static Future<void> _configureLocalNotifications() async {
    debugPrint('FcmService._configureLocalNotifications: Starting...');
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings();

    await _localNotifications.initialize(
      const InitializationSettings(android: androidInit, iOS: iosInit),
    );
    debugPrint('FcmService._configureLocalNotifications: Initialized');

    if (Platform.isAndroid) {
      final android = _localNotifications.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();
      await android?.createNotificationChannel(const AndroidNotificationChannel(
        'high_importance_channel',
        'High Importance Notifications',
        description: 'Used for important notifications.',
        importance: Importance.max,
      ));
      debugPrint('FcmService._configureLocalNotifications: Android channel created');
    }
  }

  static Future<void> _requestPermissionIOS() async {
    debugPrint('FcmService._requestPermissionIOS: Requesting permission...');
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );
    debugPrint('FcmService._requestPermissionIOS: Permission status: ${settings.authorizationStatus}');
  }

  static Future<void> _requestPermissionAndroid() async {
    debugPrint('FcmService._requestPermissionAndroid: Requesting permission...');
    await _messaging.requestPermission();
    debugPrint('FcmService._requestPermissionAndroid: Permission requested');
  }

  static void handleForegroundMessage(RemoteMessage message) {
    final notification = message.notification;
    final android = notification?.android;

    debugPrint('FcmService.handleForegroundMessage: ${notification?.title} - ${notification?.body}');

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
