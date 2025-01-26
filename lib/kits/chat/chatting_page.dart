// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:zego_zimkit/zego_zimkit.dart';

// Project imports:
import 'package:zego_uikits_demo/common/toast.dart';
import 'package:zego_uikits_demo/data/translations.dart';
import 'chatting_page_actions.dart';
import 'notification.dart';
import 'widgets/widgets.dart';

class DemoChattingMessageListPage extends StatefulWidget {
  const DemoChattingMessageListPage({
    super.key,
    required this.conversationID,
    required this.conversationType,
  });

  final String conversationID;
  final ZIMConversationType conversationType;

  @override
  State<DemoChattingMessageListPage> createState() =>
      _DemoChattingMessageListPageState();
}

class _DemoChattingMessageListPageState
    extends State<DemoChattingMessageListPage> {
  List<StreamSubscription> subscriptions = [];

  // In the initState method, subscribe the event.
  @override
  void initState() {
    subscriptions = [
      if (widget.conversationType == ZIMConversationType.group)
        ZIMKit()
            .getGroupStateChangedEventStream()
            .listen(onGroupStateChangedEvent)
    ];
    // When on the chat page, the notification for that chat page is not displayed.
    NotificationManager().ignoreConversationID = widget.conversationID;
    super.initState();
  }

  // When the widget is disposed, please remember to cancel subscribe.
  @override
  void dispose() {
    for (final element in subscriptions) {
      element.cancel();
    }
    // After exiting the chat page, if the conversation continues to receive messages, the notification of the chat page needs to be displayed.
    NotificationManager().ignoreConversationID = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ZIMKitMessageListPage(
      conversationID: widget.conversationID,
      conversationType: widget.conversationType,
      events: ZIMKitMessageListPageEvents(
        audioRecord: ZIMKitAudioRecordEvents(
          onFailed: (int errorCode) {
            /// audio message's error list:  https://doc-preview-zh.zego.im/article/20148
            debugPrint('onRecordFailed: $errorCode');
            var errorMessage = 'record failed:$errorCode';
            switch (errorCode) {
              case 32:
                errorMessage = 'recording time is too short';
                break;
            }

            showFailedToast(errorMessage);
          },
          onCountdownTick: (int remainingSecond) {
            debugPrint('onCountdownTick: $remainingSecond');
            if (remainingSecond > 5 || remainingSecond <= 0) {
              return;
            }

            showInfoToast('time remaining: $remainingSecond seconds');
          },
        ),
      ),
      onMessageSent: (ZIMKitMessage message) {
        if (message.info.error != null) {
          debugPrint(
              'onMessageSent error: ${message.info.error!.message}, ${message.info.error!.code}');
          showInfoToast('message send failed:'
              '${message.info.error!.message}, '
              'code:${message.info.error!.code}');
        } else {
          debugPrint('onMessageSent: ${message.type.name}');
        }
      },
      appBarActions: demoAppBarActions(
        context,
        widget.conversationID,
        widget.conversationType,
      ),
      onMessageItemLongPress: onMessageItemLongPress,
      messageListBackgroundBuilder: (context, defaultWidget) {
        return const ColoredBox(color: Colors.white);
      },
      messageContentBuilder: (context, message, defaultWidget) {
        if (message.type == ZIMMessageType.custom &&
            message.customContent!.type ==
                DemoCustomMessageType.redEnvelope.index) {
          return RedEnvelopeMessage(message: message);
        } else {
          return defaultWidget;
        }
      },
      messageInputActions: [
        ZIMKitMessageInputAction.more(demoSendRedEnvelopeButton(
          widget.conversationID,
          widget.conversationType,
        )),
      ],
    );
  }

  Future<void> onGroupStateChangedEvent(
      ZIMKitEventGroupStateChanged event) async {
    debugPrint('getGroupStateChangedEventStream: $event');
    // If you need to automatically exit the page and delete a group
    // conversation that is already in the 'quit' state,
    // you can use this code here.

    // if ((event.groupInfo.baseInfo.id == widget.conversationID) && (event.state == ZIMGroupState.quit)) {
    //   debugPrint('app deleteConversation: $event');
    //   await ZIMKit().deleteConversation(widget.conversationID, widget.conversationType);
    //   if (mounted) {
    //     Navigator.pop(context);
    //   }
    // }
  }
}

Future<void> onMessageItemLongPress(
  BuildContext context,
  LongPressStartDetails details,
  ZIMKitMessage message,
  Function defaultAction,
) async {
  showCupertinoDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return CupertinoAlertDialog(
        title: Text(Translations.tips.confirm),
        content: const Text('Delete or recall this message?'),
        actions: [
          CupertinoDialogAction(
            onPressed: Navigator.of(context).pop,
            child: Text(Translations.tips.cancel),
          ),
          CupertinoDialogAction(
            onPressed: () {
              ZIMKit().deleteMessage([message]);
              Navigator.pop(context);
            },
            child: Text(Translations.chat.delete),
          ),
          CupertinoDialogAction(
            onPressed: () {
              ZIMKit().recallMessage(message).catchError((error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(error.toString())),
                );
              });
              Navigator.pop(context);
            },
            child: Text(Translations.chat.revoke),
          ),
        ],
      );
    },
  );
}
