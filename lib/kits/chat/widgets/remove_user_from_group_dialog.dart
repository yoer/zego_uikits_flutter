part of 'default_dialogs.dart';

void showDefaultRemoveUserFromGroupDialog(
    BuildContext context, String groupID) {
  final groupUsersController = TextEditingController();
  Timer.run(() {
    showDialog<bool>(
      useRootNavigator: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Text(Translations.chat.removeUser),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
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
      if (groupUsersController.text.isNotEmpty) {
        ZIMKit()
            .removeUesrsFromGroup(groupID, groupUsersController.text.split(','))
            .then((int? errorCode) {
          if (errorCode != 0) {
            debugPrint('addUersToGroup faild');
          }
        });
      }
    });
  });
}
