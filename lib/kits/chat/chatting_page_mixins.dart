import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_zim/zego_zim.dart';
import 'package:zego_zimkit/zego_zimkit.dart';
import 'package:zego_uikits_demo/data/translations.dart';

enum DemoCustomMessageType { redEnvelope }

const int maxGroupCallInviteeCount = 9;

typedef GroupMemberPageQuery = Future<ZIMGroupMemberListQueriedResult> Function(
  String groupID,
  ZIMGroupMemberQueryConfig config,
);

Future<List<ZegoCallUser>> queryGroupCallInvitees({
  required String groupID,
  required String currentUserID,
  GroupMemberPageQuery? queryPage,
}) async {
  final query = queryPage ??
      (groupID, config) {
        final zim = ZIM.getInstance();
        if (zim == null) {
          throw StateError('ZIM is not initialized');
        }
        return zim.queryGroupMemberList(groupID, config);
      };

  final inviteesByID = <String, ZegoCallUser>{};
  final seenNextFlags = <int>{};
  var nextFlag = 0;

  while (true) {
    final result = await query(
      groupID,
      ZIMGroupMemberQueryConfig(count: 100, nextFlag: nextFlag),
    );

    for (final member in result.userList) {
      if (member.userID.isEmpty || member.userID == currentUserID) {
        continue;
      }

      final nickname = member.memberNickname.trim();
      final name = nickname.isNotEmpty ? nickname : member.userName;
      inviteesByID[member.userID] = ZegoCallUser(
        member.userID,
        name.isNotEmpty ? name : member.userID,
      );
    }

    if (result.nextFlag == 0) {
      break;
    }
    if (!seenNextFlags.add(result.nextFlag)) {
      throw StateError('Group member query pagination did not advance');
    }
    nextFlag = result.nextFlag;
  }

  return inviteesByID.values.toList(growable: false);
}

List<ZegoCallUser> selectGroupCallInvitees({
  required List<ZegoCallUser> availableInvitees,
  required Set<String> selectedUserIDs,
}) {
  final selected = availableInvitees
      .where((invitee) => selectedUserIDs.contains(invitee.id))
      .toList(growable: false);
  if (selected.length > maxGroupCallInviteeCount) {
    throw ArgumentError.value(
      selected.length,
      'selectedUserIDs',
      'A group call can invite at most $maxGroupCallInviteeCount users.',
    );
  }

  return selected;
}

mixin DemoChattingMessageListPageCallMixin {
  void makeCallFromInputButton({
    required BuildContext context,
    required String conversationID,
    required ZIMConversationType conversationType,
    required bool isVideoCall,
  }) {
    _makeCall(
      context: context,
      isVideoCall: isVideoCall,
      conversationID: conversationID,
      conversationType: conversationType,
    );
  }

  void showCallOptions({
    required BuildContext context,
    required String conversationID,
    required ZIMConversationType conversationType,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _audioCallButton(
                  context: context,
                  conversationID: conversationID,
                  conversationType: conversationType,
                ),
                const Divider(height: 1),
                _videoCallButton(
                  context: context,
                  conversationID: conversationID,
                  conversationType: conversationType,
                ),
                const Divider(height: 8, color: Color(0xFFF5F5F5)),
                _buildCallOption(
                  label: 'Cancel',
                  onTap: () {
                    Navigator.pop(sheetContext);
                  },
                  textColor: Colors.black54,
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _audioCallButton({
    required BuildContext context,
    required String conversationID,
    required ZIMConversationType conversationType,
  }) {
    return _buildCallOption(
      icon: Icons.phone,
      label: 'Audio Call',
      onTap: () {
        Navigator.pop(context);
        _makeCall(
          context: context,
          isVideoCall: false,
          conversationID: conversationID,
          conversationType: conversationType,
        );
      },
    );
  }

  Widget _videoCallButton({
    required BuildContext context,
    required String conversationID,
    required ZIMConversationType conversationType,
  }) {
    return _buildCallOption(
      icon: Icons.videocam,
      label: 'Video Call',
      onTap: () {
        Navigator.pop(context);
        _makeCall(
          context: context,
          isVideoCall: true,
          conversationID: conversationID,
          conversationType: conversationType,
        );
      },
    );
  }

  void _makeCall({
    required BuildContext context,
    required bool isVideoCall,
    required String conversationID,
    required ZIMConversationType conversationType,
  }) {
    unawaited(
      _sendCallInvitation(
        context: context,
        messenger: ScaffoldMessenger.maybeOf(context),
        isVideoCall: isVideoCall,
        conversationID: conversationID,
        conversationType: conversationType,
      ),
    );
  }

  Future<void> _sendCallInvitation({
    required BuildContext context,
    required ScaffoldMessengerState? messenger,
    required bool isVideoCall,
    required String conversationID,
    required ZIMConversationType conversationType,
  }) async {
    try {
      final List<ZegoCallUser> invitees;
      if (conversationType == ZIMConversationType.group) {
        final currentUserID = ZIMKit().currentUser()?.baseInfo.userID;
        if (currentUserID == null || currentUserID.isEmpty) {
          throw StateError('Current user is not logged in');
        }

        final groupInvitees = await queryGroupCallInvitees(
          groupID: conversationID,
          currentUserID: currentUserID,
        );
        if (groupInvitees.isEmpty) {
          _showCallError(
            messenger,
            Translations.chat.callNoOtherMembers,
          );
          return;
        }

        if (groupInvitees.length > maxGroupCallInviteeCount) {
          if (!context.mounted) {
            return;
          }

          final selectedInvitees = await _selectGroupCallInvitees(
            context: context,
            availableInvitees: groupInvitees,
          );
          if (selectedInvitees == null) {
            return;
          }
          invitees = selectedInvitees;
        } else {
          invitees = groupInvitees;
        }
      } else {
        invitees = [
          ZegoCallUser(
            conversationID,
            ZIMKit()
                .getConversation(conversationID, conversationType)
                .value
                .name,
          ),
        ];
      }

      final sent = await ZegoUIKitPrebuiltCallInvitationService().send(
        invitees: invitees,
        isVideoCall: isVideoCall,
        resourceID: 'zego_data',
      );
      if (!sent) {
        _showCallError(messenger, Translations.chat.callInvitationFailed);
      }
    } catch (error, stackTrace) {
      debugPrint('Failed to prepare the call invitation: $error\n$stackTrace');
      _showCallError(
        messenger,
        Translations.chat.callStartFailed,
      );
    }
  }

  Future<List<ZegoCallUser>?> _selectGroupCallInvitees({
    required BuildContext context,
    required List<ZegoCallUser> availableInvitees,
  }) {
    final selectedUserIDs = <String>{};
    return showDialog<List<ZegoCallUser>>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(Translations.chat.callMemberSelectionTitle),
              content: SizedBox(
                width: double.maxFinite,
                height: 360,
                child: Column(
                  children: [
                    Text(
                      Translations.chat.callMemberSelectionTip(
                        maxGroupCallInviteeCount,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        Translations.chat.callMemberSelectionCount(
                          selectedUserIDs.length,
                          maxGroupCallInviteeCount,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Expanded(
                      child: ListView.builder(
                        itemCount: availableInvitees.length,
                        itemBuilder: (context, index) {
                          final invitee = availableInvitees[index];
                          final isSelected = selectedUserIDs.contains(
                            invitee.id,
                          );
                          final isLimitReached = selectedUserIDs.length >=
                              maxGroupCallInviteeCount;
                          return CheckboxListTile(
                            value: isSelected,
                            title: Text(invitee.name),
                            subtitle: Text(invitee.id),
                            controlAffinity: ListTileControlAffinity.leading,
                            onChanged: !isSelected && isLimitReached
                                ? null
                                : (selected) {
                                    setState(() {
                                      if (selected == true) {
                                        selectedUserIDs.add(invitee.id);
                                      } else {
                                        selectedUserIDs.remove(invitee.id);
                                      }
                                    });
                                  },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: Text(Translations.tips.cancel),
                ),
                TextButton(
                  onPressed: selectedUserIDs.isEmpty
                      ? null
                      : () => Navigator.of(dialogContext).pop(
                            selectGroupCallInvitees(
                              availableInvitees: availableInvitees,
                              selectedUserIDs: selectedUserIDs,
                            ),
                          ),
                  child: Text(Translations.chat.startCall),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showCallError(ScaffoldMessengerState? messenger, String message) {
    if (messenger?.mounted != true) {
      return;
    }

    messenger!.showSnackBar(SnackBar(content: Text(message)));
  }

  Widget _buildCallOption({
    IconData? icon,
    required String label,
    required VoidCallback onTap,
    Color? textColor,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 56,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 24, color: Colors.black87),
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: 18,
                color: textColor ?? Colors.black87,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
