// Dart imports:
import 'dart:async';
import 'dart:convert';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:bot_toast/bot_toast.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

// Project imports:
import 'chatting_page_mixins.dart';
import 'notification.dart';
import 'widgets/red_envelope_message.dart';

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
    extends State<DemoChattingMessageListPage>
    with DemoChattingMessageListPageCallMixin {
  List<StreamSubscription> subscriptions = [];

  // In the initState method, subscribe the event.
  @override
  void initState() {
    subscriptions = [
      if (widget.conversationType == ZIMConversationType.group)
        ZIMKit().getGroupStateChangedEventStream().listen(
              onGroupStateChangedEvent,
            ),
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
    return ValueListenableBuilder<ZIMKitMessageListMultiModeData>(
      valueListenable: ZIMKitMessageListMultiSelectProcessor().modeNotifier,
      builder: (context, multiModeData, _) {
        return Scaffold(
          appBar: multiModeData.isMultiMode ? appBar() : null,
          body: Stack(
            children: [
              ZIMKitMessageListPage(
                conversationID: widget.conversationID,
                conversationType: widget.conversationType,
                config: _listPageConfigs(),
                style: _listPageStyles(),
                events: _listPageEvents(),
              ),
              if (multiModeData.isMultiMode)
                const Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: ZIMKitMultiSelectToolbarWidget(),
                ),
            ],
          ),
        );
      },
    );
  }

  AppBar appBar() {
    return AppBar(
      leading: TextButton(
        onPressed: () {
          ZIMKitMessageListMultiSelectProcessor().cancelMultiSelect();
        },
        child: const Text('取消', style: TextStyle(color: Colors.black87)),
      ),
      title: Text(
        '已选择${ZIMKitMessageListMultiSelectProcessor().selectedMessages.length}条',
      ),
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0.5,
    );
  }

  ZIMKitMessageListPageConfigs _listPageConfigs() {
    return ZIMKitMessageListPageConfigs(
      messageInput: ZIMKitMessageInputConfigs(
        actions: [
          ZIMKitMessageInputAction.more(
            buildZIMKitInputMoreActionItem(
              context,
              icon: Icons.call,
              label: 'Call',
              onTap: () {
                showCallOptions(
                  context: context,
                  conversationID: widget.conversationID,
                  conversationType: widget.conversationType,
                );
              },
            ),
          ),
          ZIMKitMessageInputAction.more(
            buildZIMKitInputMoreActionItem(
              context,
              icon: Icons.attach_money,
              backgroundColor: Colors.redAccent,
              label: 'Red Envelop',
              onTap: () {
                ZIMKit().sendCustomMessage(
                  widget.conversationID,
                  widget.conversationType,
                  customType: DemoCustomMessageType.redEnvelope.index,
                  customMessage: jsonEncode({'count': 10, 'money': 100}),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  ZIMKitMessageListPageStyles _listPageStyles() {
    return ZIMKitMessageListPageStyles(
      appBarActions: [
        IconButton(
          icon: const Icon(Icons.more_horiz),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ZIMKitSingleChatDetailPage(
                  conversationID: widget.conversationID,
                  conversationType: widget.conversationType,
                ),
              ),
            );
          },
        ),
      ],
      messageList: ZIMKitMessageListStyles(
        messageContentBuilder: (
          context,
          message,
          defaultWidget,
        ) {
          if (message.type == ZIMMessageType.custom &&
              message.customContent?.type ==
                  DemoCustomMessageType.redEnvelope.index) {
            return RedEnvelopeMessage(message: message);
          } else {
            return defaultWidget;
          }
        },
      ),
    );
  }

  ZIMKitMessageListPageEvents _listPageEvents() {
    return ZIMKitMessageListPageEvents(
      messageInput: _messageInputEvents(),
      audioRecord: _audioRecordEvents(),
    );
  }

  ZIMKitMessageInputEvents _messageInputEvents() {
    return ZIMKitMessageInputEvents(
      onMessageSent: (ZIMKitMessage message) {
        if (message.info.error != null) {
          debugPrint(
            'onMessageSent error: ${message.info.error!.message}, ${message.info.error!.code}',
          );
          BotToast.showText(
            text: 'message send failed:'
                '${message.info.error!.message}, '
                'code:${message.info.error!.code}',
            contentColor: Colors.red,
            textStyle: const TextStyle(fontSize: 10, color: Colors.white),
          );
        } else {
          debugPrint('onMessageSent: ${message.type.name}');
        }
      },
    );
  }

  ZIMKitAudioRecordEvents _audioRecordEvents() {
    return ZIMKitAudioRecordEvents(
      onFailed: (int errorCode) {
        /// audio message's error list:  https://doc-preview-zh.zego.im/article/20148
        debugPrint('onRecordFailed: $errorCode');
        var errorMessage = 'record failed:$errorCode';
        switch (errorCode) {
          case 32:
            errorMessage = 'recording time is too short';
            break;
        }
        BotToast.showText(
          text: errorMessage,
          contentColor: Colors.red,
          textStyle: const TextStyle(fontSize: 10, color: Colors.white),
        );
      },
      onCountdownTick: (int remainingSecond) {
        debugPrint('onCountdownTick: $remainingSecond');
        if (remainingSecond > 5 || remainingSecond <= 0) {
          return;
        }

        BotToast.showText(
          text: 'time remaining: $remainingSecond seconds',
          contentColor: Colors.black.withOpacity(0.3),
          textStyle: const TextStyle(fontSize: 10, color: Colors.white),
          duration: const Duration(milliseconds: 800),
        );
      },
    );
  }

  Future<void> onGroupStateChangedEvent(
    ZIMKitEventGroupStateChanged event,
  ) async {
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
