part of 'default_dialogs.dart';

void showDefaultNewGroupChatDialog(BuildContext context) {
  final groupIDController = TextEditingController();
  final groupNameController = TextEditingController();
  final groupUsersController = TextEditingController();
  Timer.run(() {
    showDialog<bool>(
      useRootNavigator: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: const Text('New Group'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: groupNameController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Group Name',
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: groupIDController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'ID(optional)',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextField(
                  maxLines: 3,
                  controller: groupUsersController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Invite User IDs',
                    hintText: 'separate by comma, e.g. 123,987,229',
                  ),
                ),
              ],
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
      if (groupNameController.text.isNotEmpty &&
          groupUsersController.text.isNotEmpty) {
        ZIMKit()
            .createGroup(
          groupNameController.text,
          groupUsersController.text.split(','),
          id: groupIDController.text,
        )
            .then((String? conversationID) {
          if (conversationID != null) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return DemoChattingMessageListPage(
                conversationID: conversationID,
                conversationType: ZIMConversationType.group,
              );
            }));
          }
        });
      }
    });
  });
}
