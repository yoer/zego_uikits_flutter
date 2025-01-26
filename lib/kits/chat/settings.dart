// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:zego_uikits_demo/data/translations.dart';

class ChatPageSettings extends StatefulWidget {
  const ChatPageSettings({super.key});

  @override
  State<ChatPageSettings> createState() {
    return _ChatPageSettingsState();
  }
}

class _ChatPageSettingsState extends State<ChatPageSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Translations.settings.title),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const <Widget>[],
        ),
      ),
    );
  }
}
