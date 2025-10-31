// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

// Project imports:
import 'package:zego_uikits_demo/kits/chat/actions.dart';
import 'chatting_page.dart';

class ZegoChatPage extends StatefulWidget {
  const ZegoChatPage({super.key});

  @override
  State<ZegoChatPage> createState() => _ZegoChatPageState();
}

class _ZegoChatPageState extends State<ZegoChatPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Positioned.fill(
            child: ZIMKitConversationListView(
              events: ZIMKitConversationListEvents(
                onPressed: (context, conversation, defaultAction) {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return DemoChattingMessageListPage(
                        conversationID: conversation.id,
                        conversationType: conversation.type,
                      );
                    },
                  ));
                },
              ),
            ),
          ),
          Positioned(
            bottom: 50.r,
            right: 0,
            child: const ZegoIMKitPagePopupMenuButton(),
          ),
        ],
      ),
    );
  }
}
