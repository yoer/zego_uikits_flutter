// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:zego_uikit/zego_uikit.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

enum DemoCustomMessageType {
  redEnvelope,
}

mixin DemoChattingMessageListPageCallMixin {
  void showCallOptions({
    required BuildContext context,
    required String conversationID,
    required ZIMConversationType conversationType,
  }) {
    // Get the call buttons using the original logic
    final callButtons = _peerChatCallButtons(
      context,
      conversationID,
      conversationType,
    );

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
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
                  callButtons: callButtons,
                  conversationID: conversationID,
                  conversationType: conversationType,
                ),
                const Divider(height: 1),
                _videoCallButton(
                  context: context,
                  callButtons: callButtons,
                  conversationID: conversationID,
                  conversationType: conversationType,
                ),
                const Divider(height: 8, color: Color(0xFFF5F5F5)),
                _buildCallOption(
                  label: 'Cancel',
                  onTap: () {
                    Navigator.pop(context);
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
    required List<Widget> callButtons,
    required String conversationID,
    required ZIMConversationType conversationType,
  }) {
    return _buildCallOption(
      icon: Icons.phone,
      label: 'Audio Call',
      onTap: () {
        Navigator.pop(context);
        // Trigger the audio call button (isVideoCall: false)
        if (callButtons.length > 1) {
          // callButtons[1] is audio call (isVideoCall: false)
          // We need to programmatically trigger it
          // For now, show the call UI manually
          _makeCall(
            isVideoCall: false,
            userID: conversationID,
            conversationID: conversationID,
            conversationType: conversationType,
          );
        }
      },
    );
  }

  Widget _videoCallButton({
    required BuildContext context,
    required List<Widget> callButtons,
    required String conversationID,
    required ZIMConversationType conversationType,
  }) {
    return _buildCallOption(
      icon: Icons.videocam,
      label: 'Video Call',
      onTap: () {
        Navigator.pop(context);
        // Trigger the video call button (isVideoCall: true)
        if (callButtons.isNotEmpty) {
          // callButtons[0] is video call (isVideoCall: true)
          _makeCall(
            isVideoCall: true,
            userID: conversationID,
            conversationID: conversationID,
            conversationType: conversationType,
          );
        }
      },
    );
  }

  List<Widget> _peerChatCallButtons(
    BuildContext context,
    String conversationID,
    ZIMConversationType type,
  ) {
    return [
      for (final isVideoCall in [true, false])
        ZegoSendCallInvitationButton(
          iconSize: const Size(40, 40),
          buttonSize: const Size(50, 50),
          isVideoCall: isVideoCall,
          resourceID: 'zego_data',
          invitees: [
            ZegoUIKitUser(
              id: conversationID,
              name: ZIMKit().getConversation(conversationID, type).value.name,
              isAnotherRoomUser: false,
            )
          ],
          onPressed: (String code, String message, List<String> errorInvitees) {
            var log = '';
            if (errorInvitees.isNotEmpty) {
              log = "User doesn't exist or is offline: ${errorInvitees[0]}";
              if (code.isNotEmpty) {
                log += ', code: $code, message:$message';
              }
            } else if (code.isNotEmpty) {
              log = 'code: $code, message:$message';
            }
            if (log.isEmpty) {
              return;
            }

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(log)),
            );
          },
        )
    ];
  }

  void _makeCall({
    required String userID,
    required bool isVideoCall,
    required String conversationID,
    required ZIMConversationType conversationType,
  }) {
    // Use the original call logic from peerChatCallButtons
    ZegoUIKitPrebuiltCallInvitationService().send(
      invitees: [
        ZegoCallUser(
          userID,
          ZIMKit().getConversation(conversationID, conversationType).value.name,
        ),
      ],
      isVideoCall: isVideoCall,
      resourceID: 'zego_data',
    );
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
