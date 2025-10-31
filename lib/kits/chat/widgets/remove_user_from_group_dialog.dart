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
            title: const Text('Remove User'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  maxLines: 3,
                  controller: groupUsersController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'User IDs',
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
      if (groupUsersController.text.isNotEmpty) {
        ZIMKit()
            .removeUesrsFromGroup(groupID, groupUsersController.text.split(','))
            .then((int? errorCode) {
          if (errorCode != 0) {
            debugPrint('addUersToGroup failed');
          }
        });
      }
    });
  });
}
