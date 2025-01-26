// Flutter imports:
import 'package:flutter/cupertino.dart';

// Project imports:
import 'package:zego_uikits_demo/data/assets.dart';
import 'package:zego_uikits_demo/data/translations.dart';
import 'package:zego_uikits_demo/kits/chat/zego_page.dart';
import 'package:zego_uikits_demo/kits/kits_page.dart';
import 'package:zego_uikits_demo/pages/utils/router.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() {
    return _ChatPageState();
  }
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return KitsPage(
      backgroundURL: ChatAssets.ad,
      title: Translations.chat.title,
      onSettingsClicked: () {
        PageRouter.chatSettings.go(context);
      },
      child: const ZegoChatPage(),
    );
  }
}
