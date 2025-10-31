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
            title: const Text('New Chat'),
            content: TextField(
              controller: userIDController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'User ID',
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('OK'),
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
