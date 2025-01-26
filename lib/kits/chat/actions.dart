// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

// Project imports:
import 'package:zego_uikits_demo/data/translations.dart';
import 'widgets/default_dialogs.dart';

class ZegoIMKitPagePopupMenuButton extends StatefulWidget {
  const ZegoIMKitPagePopupMenuButton({super.key});

  @override
  State<ZegoIMKitPagePopupMenuButton> createState() =>
      _ZegoIMKitPagePopupMenuButtonState();
}

class _ZegoIMKitPagePopupMenuButtonState
    extends State<ZegoIMKitPagePopupMenuButton> {
  final userIDController = TextEditingController();
  final groupNameController = TextEditingController();
  final groupUsersController = TextEditingController();
  final groupIDController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(fontSize: 20.r, color: Colors.black);
    return PopupMenuButton(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      position: PopupMenuPosition.under,
      icon: Icon(
        CupertinoIcons.add_circled,
        size: 80.r,
      ),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: Translations.chat.newChat,
            child: ListTile(
              leading: Icon(
                CupertinoIcons.chat_bubble_2_fill,
                size: 30.r,
              ),
              title: Text(
                Translations.chat.newChat,
                maxLines: 1,
                style: textStyle,
              ),
            ),
            onTap: () => showDefaultNewPeerChatDialog(context),
          ),
          PopupMenuItem(
            value: Translations.chat.newGroup,
            child: ListTile(
              leading: Icon(
                CupertinoIcons.person_2_fill,
                size: 30.r,
              ),
              title: Text(
                Translations.chat.newGroup,
                maxLines: 1,
                style: textStyle,
              ),
            ),
            onTap: () => showDefaultNewGroupChatDialog(context),
          ),
          PopupMenuItem(
            value: Translations.chat.joinGroup,
            child: ListTile(
                leading: Icon(
                  Icons.group_add,
                  size: 30.r,
                ),
                title: Text(
                  Translations.chat.joinGroup,
                  maxLines: 1,
                  style: textStyle,
                )),
            onTap: () => showDefaultJoinGroupDialog(context),
          ),
          PopupMenuItem(
            value: Translations.chat.deleteAll,
            child: ListTile(
                leading: Icon(
                  Icons.delete,
                  size: 30.r,
                ),
                title: Text(
                  Translations.chat.deleteAll,
                  maxLines: 1,
                  style: textStyle,
                )),
            onTap: () {
              ZIMKit().deleteAllConversation(
                isAlsoDeleteFromServer: true,
                isAlsoDeleteMessages: true,
              );
            },
          ),
        ];
      },
    );
  }
}
