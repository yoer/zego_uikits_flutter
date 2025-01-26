part of 'default_dialogs.dart';

void showDefaultJoinGroupDialog(BuildContext context) {
  final groupIDController = TextEditingController();
  Timer.run(() {
    showDialog<bool>(
      useRootNavigator: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: const Text('Join Group'),
            content: TextField(
              controller: groupIDController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Group ID',
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text('OK'),
              ),
            ],
          );
        });
      },
    ).then((bool? ok) {
      if (ok != true) return;
      if (groupIDController.text.isNotEmpty) {
        ZIMKit().joinGroup(groupIDController.text).then((int errorCode) {
          if (errorCode == 0) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return DemoChattingMessageListPage(
                conversationID: groupIDController.text,
                conversationType: ZIMConversationType.group,
              );
            }));
          }
        });
      }
    });
  });
}
