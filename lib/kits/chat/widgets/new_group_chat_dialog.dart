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
            title: Text(Translations.chat.newGroup),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: groupNameController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: Translations.chat.groupName,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: groupIDController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: Translations.chat.groupIdPlaceHolder,
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
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: Translations.chat.userIdsPlaceHolder,
                    hintText: Translations.chat.userIdsTips,
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text(Translations.tips.cancel),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text(Translations.tips.ok),
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
