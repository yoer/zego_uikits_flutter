part of 'default_dialogs.dart';

void showDefaultNewPeerChatDialog(BuildContext context) {
  final userIDController = TextEditingController();
  Timer.run(() {
    showDialog<bool>(
      useRootNavigator: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Text(Translations.chat.newChat),
            content: TextField(
              controller: userIDController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: Translations.chat.userIdsPlaceHolder,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(Translations.tips.cancel),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(Translations.tips.ok),
              ),
            ],
          );
        });
      },
    ).then((ok) {
      if (ok != true) return;
      if (userIDController.text.isNotEmpty) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return DemoChattingMessageListPage(
            conversationID: userIDController.text,
            conversationType: ZIMConversationType.peer,
          );
        }));
      }
    });
  });
}
