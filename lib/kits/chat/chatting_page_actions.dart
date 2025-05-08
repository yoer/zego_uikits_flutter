// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit/zego_uikit.dart';
import 'package:zego_zimkit/zego_zimkit.dart';
import 'package:zego_zim/zego_zim.dart';

// Project imports:
import 'package:zego_uikits_demo/common/avatar.dart';
import 'package:zego_uikits_demo/data/translations.dart';
import 'package:zego_uikits_demo/kits/call/cache.dart';
import 'package:zego_uikits_demo/kits/call/utils.dart';
import 'widgets/default_dialogs.dart';

List<Widget>? demoAppBarActions(
  BuildContext context,
  String conversationID,
  ZIMKitConversationType type,
) {
  return type == ZIMKitConversationType.peer
      ? peerChatCallButtons(context, conversationID, type)
      : [
          GroupPageCallButton(groupID: conversationID),
          GroupPagePopupMenuButton(groupID: conversationID),
        ];
}

List<Widget> peerChatCallButtons(
  BuildContext context,
  String conversationID,
  ZIMKitConversationType type,
) {
  return [
    for (final isVideoCall in [true, false])
      ZegoSendCallInvitationButton(
        iconSize: const Size(40, 40),
        buttonSize: const Size(50, 50),
        isVideoCall: isVideoCall,
        resourceID: CallCache().invitation.resourceID,
        invitees: [
          ZegoUIKitUser(
            id: conversationID,
            name: ZIMKit().getConversation(conversationID, type).value.name,
          )
        ],
        onPressed: onSendCallInvitationFinished,
      )
  ];
}

class GroupPageCallButton extends StatefulWidget {
  const GroupPageCallButton({super.key, required this.groupID});

  final String groupID;

  @override
  State<GroupPageCallButton> createState() => _GroupPageCallButtonState();
}

class _GroupPageCallButtonState extends State<GroupPageCallButton> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ZIMKit().queryGroupMemberList(widget.groupID),
      builder: (context, List<ZIMGroupMemberInfo> members, _) {
        return IconButton(
          onPressed: () {
            showCallingInvitationListSheet(
              context,
              avatarBuilder: (
                BuildContext context,
                Size size,
                ZegoUIKitUser? user,
                Map<String, dynamic> extraInfo,
              ) {
                return avatar(user?.id ?? '');
              },
              waitingSelectUsers: members
                  .where((member) =>
                      member.userID != ZIMKit().currentUser()!.baseInfo.userID)
                  .toList()
                  .map((member) => ZegoCallUser(
                        member.userID,
                        member.userName,
                      ))
                  .toList(),
              onPressed: (checkUsers) {
                ZegoUIKitPrebuiltCallInvitationService().send(
                  invitees: checkUsers,
                  isVideoCall: true,

                  /// '#' is not a valid char
                  callID: widget.groupID.replaceAll('#', ''),
                  resourceID: CallCache().invitation.resourceID,
                );
              },
            );
          },
          icon: const Icon(
            Icons.call,
            color: Colors.green,
          ),
        );
      },
    );
  }
}

class GroupPagePopupMenuButton extends StatefulWidget {
  const GroupPagePopupMenuButton({super.key, required this.groupID});

  final String groupID;

  @override
  State<GroupPagePopupMenuButton> createState() =>
      _GroupPagePopupMenuButtonState();
}

class _GroupPagePopupMenuButtonState extends State<GroupPagePopupMenuButton> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ZIMKit().queryGroupOwner(widget.groupID),
      builder: (context, ZIMGroupMemberInfo? owner, _) {
        final imGroupOwner =
            owner?.userID == ZIMKit().currentUser()?.baseInfo.userID;
        return PopupMenuButton(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          position: PopupMenuPosition.under,
          icon: const Icon(Icons.more_vert),
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                value: Translations.chat.addMember,
                child: ListTile(
                    leading: const Icon(Icons.group_add),
                    title: Text(Translations.chat.addMember, maxLines: 1)),
                onTap: () => showDefaultAddUserToGroupDialog(
                  context,
                  widget.groupID,
                ),
              ),
              if (imGroupOwner)
                PopupMenuItem(
                  value: Translations.chat.removeMember,
                  child: ListTile(
                      leading: const Icon(Icons.group_remove),
                      title: Text(Translations.chat.removeMember, maxLines: 1)),
                  onTap: () => showDefaultRemoveUserFromGroupDialog(
                    context,
                    widget.groupID,
                  ),
                ),
              PopupMenuItem(
                value: '',
                child: ListTile(
                    leading: const Icon(Icons.people),
                    title: Text(Translations.chat.memberList, maxLines: 1)),
                onTap: () => showDefaultGroupMemberListDialog(
                  context,
                  widget.groupID,
                ),
              ),
              PopupMenuItem(
                value: Translations.chat.leaveGroup,
                onTap: leaveGroup,
                child: ListTile(
                    leading: const Icon(Icons.logout),
                    title: Text(Translations.chat.leaveGroup, maxLines: 1)),
              ),
              if (imGroupOwner)
                PopupMenuItem(
                  value: Translations.chat.disbandGroup,
                  onTap: dispandGroup,
                  child: ListTile(
                    leading: const Icon(Icons.close),
                    title: Text(Translations.chat.disbandGroup, maxLines: 1),
                  ),
                ),
            ];
          },
        );
      },
    );
  }

  void leaveGroup() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(Translations.tips.confirm),
          content: Text(Translations.chat.leaveTips),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(Translations.tips.cancel),
            ),
            TextButton(
              onPressed: () {
                ZIMKit().leaveGroup(widget.groupID);
                Navigator.pop(context);
              },
              child: Text(Translations.tips.ok),
            ),
          ],
        );
      },
    );
  }

  void dispandGroup() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm'),
          content: const Text('Do you want to disband this group?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                ZIMKit().disbandGroup(widget.groupID);
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
