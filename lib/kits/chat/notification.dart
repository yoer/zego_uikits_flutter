// Dart imports:
import 'dart:convert';
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:zego_zim/zego_zim.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

// Project imports:
import 'package:zego_uikits_demo/common/constant.dart';
import 'chatting_page.dart';

const demoChannelID = 'your channel id';
const demoChannelName = 'your channel name';

class NotificationManager {
  factory NotificationManager() => instance;
  NotificationManager._internal();
  static NotificationManager instance = NotificationManager._internal();
  String? ignoreConversationID;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  bool isAppInBackground = false;
  int notificationID = 1;

  Future<void> init() async {
    ZIMKit().getOnMessageReceivedNotifier().addListener(_onMessageArrived);

    if (Platform.isAndroid) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
      const channel = AndroidNotificationChannel(
        demoChannelID,
        demoChannelName,
        description: 'your channel description',
        importance: Importance.high,
        enableVibration: true,
        showBadge: false,
        playSound: true,
      );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
    }

    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@drawable/message'),
        iOS: DarwinInitializationSettings(
            // requestSoundPermission: true,
            // requestBadgePermission: false,
            // requestAlertPermission: false,
            ),
      ),
      onDidReceiveNotificationResponse: onNotificationTappedBackground,
      onDidReceiveBackgroundNotificationResponse:
          onNotificationTappedBackground,
    );
  }

  Future<void> uninit() async {
    ZIMKit().getOnMessageReceivedNotifier().removeListener(_onMessageArrived);
  }

  Future<void> _onMessageArrived() async {
    final messages = ZIMKit().getOnMessageReceivedNotifier().value;
    if (messages == null) return;
    if (messages.id == ignoreConversationID) return;
    showNotifications(messages);
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
    debugPrint('cancelAllNotifications');
  }

  static void onNotificationTappedBackground(NotificationResponse response) {
    debugPrint('onNotificationTappedBackground ${response.payload}');
    NotificationManager().cancelAllNotifications();

    try {
      final Map payload = jsonDecode(response.payload!);
      navigatorKey.currentState?.push(
        MaterialPageRoute(
          builder: (context) {
            return DemoChattingMessageListPage(
              conversationID: payload['id'],
              conversationType:
                  ZIMKitConversationType.values[payload['typeIndex']],
            );
          },
        ),
      );
    } catch (e) {
      debugPrint('decode error $e');
    }
  }

  int initTimestamp = DateTime.now().millisecondsSinceEpoch;
  Future<void> showNotifications(ZIMKitReceivedMessages messages) async {
    messages.receiveMessages
        .where((e) => e.info.timestamp > initTimestamp)
        .toList()
        .forEach((message) async {
      var content = '[${message.type.name}]';
      if (ZIMKitMessageType.text == message.type) {
        content = message.textContent?.text ?? '';
      }

      var senderName = '';
      await ZIMKit()
          .queryUser(message.info.senderUserID)
          .then((ZIMUserFullInfo zimResult) {
        senderName = zimResult.baseInfo.userName;
      });

      await flutterLocalNotificationsPlugin.show(
        notificationID,
        senderName,
        content,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            demoChannelID,
            demoChannelName,
            channelDescription: 'your channel description',
            priority: Priority.high,
            importance: Importance.high,
            visibility: NotificationVisibility.public,
          ),
          iOS: DarwinNotificationDetails(),
        ),
        payload: jsonEncode({
          'id': messages.id,
          'typeIndex': messages.type.index,
        }),
      );

      notificationID++;
    });
  }
}
