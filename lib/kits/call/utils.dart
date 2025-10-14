// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:zego_uikit/zego_uikit.dart';
import 'package:zego_uikit_beauty_plugin/zego_uikit_beauty_plugin.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

// Project imports:
import 'package:zego_uikits_demo/common/avatar.dart';
import 'package:zego_uikits_demo/common/constant.dart';
import 'package:zego_uikits_demo/common/countdown.dart';
import 'package:zego_uikits_demo/common/toast.dart';
import 'package:zego_uikits_demo/data/assets.dart';
import 'package:zego_uikits_demo/data/settings.dart';
import 'package:zego_uikits_demo/data/translations.dart';
import 'package:zego_uikits_demo/data/user.dart';
import 'package:zego_uikits_demo/kits/cache.dart';
import 'package:zego_uikits_demo/kits/call/cache.dart';
import 'package:zego_uikits_demo/kits/call/invitation/history.dart';
import 'package:zego_uikits_demo/kits/call/language.dart';

Future<bool> initCallInvitation() async {
  if (!SettingsCache().isAppKeyValid) {
    return false;
  }

  await UserService().getCacheLoginUser().then((userInfo) async {
    await ZegoUIKitPrebuiltCallInvitationService().init(
      appID: int.parse(SettingsCache().appID),
      appSign: SettingsCache().appSign,
      token: SettingsCache().appToken,
      userID: userInfo!.id,
      userName: userInfo.name,
      innerText: CallInvitationInnerText.current(
        navigatorKey.currentState!.context.locale,
      ),
      plugins: [
        ZegoUIKitSignalingPlugin(),
        ...(KitCommonCache().supportAdvanceBeauty
            ? [ZegoUIKitBeautyPlugin()]
            : []),
      ],
      config: ZegoCallInvitationConfig(
        permissions: const [
          ZegoCallInvitationPermission.camera,
          ZegoCallInvitationPermission.microphone,
          ZegoCallInvitationPermission.systemAlertWindow,
          ZegoCallInvitationPermission.manuallyByUser,
        ],

        /// beta config
        pip: ZegoCallInvitationPIPConfig(
          iOS: ZegoCallInvitationPIPIOSConfig(
            support: KitCommonCache().supportPIP,
          ),
        ),
        offline: ZegoCallInvitationOfflineConfig(
          autoEnterAcceptedOfflineCall: false,
        ),
        inCalling: ZegoCallInvitationInCallingConfig(
          canInvitingInCalling: CallCache().invitation.canInvitingInCalling,
          onlyInitiatorCanInvite:
              CallCache().invitation.onlyInitiatorCanInviteInCalling,
        ),
        missedCall: ZegoCallInvitationMissedCallConfig(
          enabled: CallCache().invitation.supportMissedNotification,
          resourceID: CallCache().invitation.resourceID,
          timeoutSeconds: CallCache().invitation.timeoutSecond,
          enableDialBack:
              CallCache().invitation.supportMissedNotificationReDial,
        ),
      ),
      uiConfig: ZegoCallInvitationUIConfig(
        withSafeArea: CallCache().invitation.safeArea,
        inviter: ZegoCallInvitationInviterUIConfig(
          useVideoViewAspectFill:
              CallCache().invitation.uiUseVideoViewAspectFill,
          showAvatar: CallCache().invitation.uiShowAvatar,
          showCentralName: CallCache().invitation.uiShowCentralName,
          showCallingText: CallCache().invitation.uiShowCallingText,
          defaultMicrophoneOn: CallCache().invitation.uiDefaultMicrophoneOn,
          defaultCameraOn: CallCache().invitation.uiDefaultCameraOn,
          defaultSpeakerOn: CallCache().invitation.uiDefaultSpeakerOn,
          showMainButtonsText: CallCache().invitation.uiShowMainButtonsText,
          showSubButtonsText: CallCache().invitation.uiShowSubButtonsText,
          minimized: ZegoCallInvitationInviterMinimizedUIConfig(
            cancelButton: ZegoCallButtonUIConfig(
                visible: CallCache()
                    .invitation
                    .uiInviterMinimizedCancelButtonVisible),
            showTips: CallCache().invitation.uiInviterMinimizedShowTips,
          ),
        ),
        invitee: ZegoCallInvitationInviteeUIConfig(
          showAvatar: CallCache().invitation.uiShowAvatar,
          showCentralName: CallCache().invitation.uiShowCentralName,
          showCallingText: CallCache().invitation.uiShowCallingText,
          useVideoViewAspectFill:
              CallCache().invitation.uiUseVideoViewAspectFill,
          showVideoOnCalling: CallCache().invitation.showVideoOnInvitationCall,
          defaultMicrophoneOn: CallCache().invitation.uiDefaultMicrophoneOn,
          defaultCameraOn: CallCache().invitation.uiDefaultCameraOn,
          showMainButtonsText: CallCache().invitation.uiShowMainButtonsText,
          showSubButtonsText: CallCache().invitation.uiShowSubButtonsText,
          minimized: ZegoCallInvitationInviteeMinimizedUIConfig(
            acceptButton: ZegoCallButtonUIConfig(
                visible: CallCache()
                    .invitation
                    .uiInviteeMinimizedAcceptButtonVisible),
            declineButton: ZegoCallButtonUIConfig(
                visible: CallCache()
                    .invitation
                    .uiInviteeMinimizedDeclineButtonVisible),
            showTips: CallCache().invitation.uiInviteeMinimizedShowTips,
          ),
        ),
      ),
      notificationConfig: ZegoCallInvitationNotificationConfig(
        androidNotificationConfig: ZegoCallAndroidNotificationConfig(
          showFullScreen: true,
          fullScreenBackgroundAssetURL: CallAssets.offlineBackground,
          callChannel: ZegoCallAndroidNotificationChannelConfig(
            channelID: "call_invitation",
            channelName: "Call Invitation",
            sound: "call",
            icon: "call",
            vibrate: true,
          ),
          missedCallChannel: ZegoCallAndroidNotificationChannelConfig(
            channelID: "missed_call",
            channelName: "Missed Call",
            sound: "missed_call",
            icon: "missed_call",
            vibrate: false,
          ),
          messageChannel: ZegoCallAndroidNotificationChannelConfig(
            channelID: "zimkit_message",
            channelName: 'Chat Message',
            sound: 'message',
            icon: 'message',
          ),
        ),
        iOSNotificationConfig: ZegoCallIOSNotificationConfig(
          systemCallingIconName: 'CallKitIcon',
        ),
      ),
      requireConfig: (ZegoCallInvitationData data) {
        return callConfig(
          context: navigatorKey.currentState!.context,
          isGroup: data.invitees.length > 1,
          isVideo: ZegoCallInvitationType.videoCall == data.type,
        );
      },
      events: ZegoUIKitPrebuiltCallEvents(
        onCallEnd: (
          ZegoCallEndEvent event,
          VoidCallback defaultAction,
        ) {
          CallCache().invitation.queryHistory(event.callID)?.hangup(true);

          defaultAction.call();
        },
      ),
      invitationEvents: ZegoUIKitPrebuiltCallInvitationEvents(
        onOutgoingCallSent: (
          String callID,
          ZegoCallUser caller,
          ZegoCallInvitationType callType,
          List<ZegoCallUser> callees,
          String customData,
        ) {
          if (callees.isEmpty) {
            return;
          }

          CallCache().invitation.addHistory(
                CallRecord(
                  callID: callID,
                  users: callees,
                  respondTime: DateTime.now(),
                  duration: const Duration(),
                  isMissed: true,
                  isCaller: true,
                  isVideo: callType == ZegoCallInvitationType.videoCall,
                  isGroup: callees.length > 1,
                ),
              );
        },
        onOutgoingCallDeclined: (
          String callID,
          ZegoCallUser callee,
          String customData,
        ) {
          CallCache().invitation.queryHistory(callID)?.hangup(true);
        },
        onOutgoingCallRejectedCauseBusy: (
          String callID,
          ZegoCallUser callee,
          String customData,
        ) {
          CallCache().invitation.queryHistory(callID)?.hangup(true);
        },
        onOutgoingCallTimeout: (
          String callID,
          List<ZegoCallUser> callees,
          bool isVideoCall,
        ) {
          CallCache().invitation.queryHistory(callID)?.hangup(false);
        },
        onIncomingCallReceived: (
          String callID,
          ZegoCallUser caller,
          ZegoCallInvitationType callType,
          List<ZegoCallUser> callees,
          String customData,
        ) {
          debugPrint("xxx onIncomingCallReceived, callID:$callID");

          final users = callees.length > 1 ? callees : [caller];
          CallCache().invitation.addHistory(
                CallRecord(
                  callID: callID,
                  users: users,
                  respondTime: DateTime.now(),
                  duration: const Duration(),
                  isMissed: true,
                  isCaller: false,
                  isVideo: callType == ZegoCallInvitationType.videoCall,
                  isGroup: callees.length > 1,
                ),
              );

          if (ZegoRoomStateChangedReason.Logining ==
                  ZegoUIKit().getRoomStateStream().value.reason ||
              ZegoRoomStateChangedReason.Logined ==
                  ZegoUIKit().getRoomStateStream().value.reason) {
            /// auto reject if in room(others kit)
            ZegoUIKitPrebuiltCallInvitationService().reject();
          }
        },
        onIncomingCallCanceled: (
          String callID,
          ZegoCallUser caller,
          String customData,
        ) {
          CallCache().invitation.queryHistory(callID)?.hangup(false);
        },
        onIncomingCallTimeout: (String callID, ZegoCallUser caller) {
          CallCache().invitation.queryHistory(callID)?.hangup(false);
        },
        onInvitationUserStateChanged: (
          List<ZegoSignalingPluginInvitationUserInfo> users,
        ) {
          debugPrint('xxx onInvitationUserStateChanged, users:$users');
        },
      ),
    );
  });

  return true;
}

ZegoUIKitPrebuiltCallConfig callConfig({
  required BuildContext context,
  required bool isGroup,
  required bool isVideo,
}) {
  final config = isGroup
      ? (isVideo
          ? ZegoUIKitPrebuiltCallConfig.groupVideoCall()
          : ZegoUIKitPrebuiltCallConfig.groupVoiceCall())
      : (isVideo
          ? ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
          : ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall());

  config.audioVideoView.useVideoViewAspectFill = CallCache().videoAspectFill;
  config.avatarBuilder = (
    BuildContext context,
    Size size,
    ZegoUIKitUser? user,
    Map<String, dynamic> extraInfo,
  ) {
    return avatar(user?.id ?? '');
  };

  config.topMenuBar.isVisible = true;

  /// support minimizing, show minimizing button
  config.topMenuBar.buttons.insert(
    0,
    ZegoCallMenuBarButtonName.minimizingButton,
  );

  /// duration
  config.duration.isVisible = CallCache().durationVisible;
  if (CallCache().durationAutoHangUp &&
      CallCache().durationAutoHangUpSeconds > 1) {
    config.foreground = ValueListenableBuilder<int>(
      valueListenable: CallCache().durationCountDownNotifier,
      builder: (context, seconds, _) {
        final isVisible = seconds != -1;
        return Positioned.fill(
          child: Visibility(
            visible: isVisible,
            child: Align(
              alignment: Alignment.center,
              child: CountdownTimer(
                seconds: seconds,
                tips: Translations.settings.durationEndTips,
                onFinished: () {
                  CallCache().durationCountDownNotifier.value = -1;
                  ZegoUIKitPrebuiltCallController().hangUp(context);
                },
              ),
            ),
          ),
        );
      },
    );

    config.duration.onDurationUpdate = (Duration duration) {
      final remainingSeconds =
          CallCache().durationAutoHangUpSeconds - duration.inSeconds;
      if (remainingSeconds == 5) {
        /// remain 5 seconds, count down to hangup
        CallCache().durationCountDownNotifier.value = remainingSeconds;
      }
    };
  }

  if (KitCommonCache().supportAdvanceBeauty) {
    config.bottomMenuBar.buttons.add(
      ZegoCallMenuBarButtonName.beautyEffectButton,
    );
  }

  if (CallCache().supportChat) {
    config.bottomMenuBar.buttons.add(
      ZegoCallMenuBarButtonName.chatButton,
    );
  }

  if (KitCommonCache().supportScreenSharing) {
    config.layout = ZegoLayout.gallery(
      showScreenSharingFullscreenModeToggleButtonRules:
          ZegoShowFullscreenModeToggleButtonRules.alwaysShow,
      showNewScreenSharingViewInFullscreenMode: false,
    );
    config.topMenuBar.buttons.add(
      ZegoCallMenuBarButtonName.toggleScreenSharingButton,
    );
  }

  if (CallCache().invitation.canInvitingInCalling) {
    //support calling invitation
    final sendCallingInvitationButton = StreamBuilder(
      stream: ZegoUIKit().getUserListStream(),
      builder: (context, snapshot) {
        return ValueListenableBuilder(
            valueListenable:

                /// '#' is removed when send call invitation
                ZIMKit().queryGroupMemberList('#${ZegoUIKit().getRoom().id}'),
            builder: (context, List<ZIMGroupMemberInfo> members, _) {
              final memberIDsInCall =
                  ZegoUIKit().getRemoteUsers().map((user) => user.id).toList();
              final membersNotInCall = members.where((member) {
                if (member.userID == ZIMKit().currentUser()!.baseInfo.userID) {
                  return false;
                }

                return !memberIDsInCall.contains(member.userID);
              }).toList();
              return ZegoSendCallingInvitationButton(
                avatarBuilder: (
                  BuildContext context,
                  Size size,
                  ZegoUIKitUser? user,
                  Map<String, dynamic> extraInfo,
                ) {
                  return avatar(user?.id ?? '');
                },
                selectedUsers: ZegoUIKit()
                    .getRemoteUsers()
                    .map((e) => ZegoCallUser(
                          e.id,
                          e.name,
                        ))
                    .toList(),
                waitingSelectUsers: membersNotInCall
                    .map((member) => ZegoCallUser(
                          member.userID,
                          member.userName,
                        ))
                    .toList(),
              );
            });
      },
    );

    config.topMenuBar.extendButtons = [
      ...config.topMenuBar.extendButtons,
      sendCallingInvitationButton,
    ];
  }

  config.pip.enableWhenBackground = KitCommonCache().supportPIP;
  config.pip.iOS.support = KitCommonCache().supportPIP;
  if (KitCommonCache().supportPIP) {
    config.topMenuBar.buttons.add(
      ZegoCallMenuBarButtonName.pipButton,
    );
  }

  config.translationText = CallInnerText.current(context.locale);

  return config;
}

void onSendCallInvitationFinished(
  String code,
  String message,
  List<String> errorInvitees,
) {
  if (errorInvitees.isNotEmpty) {
    String userIDs = "";
    for (int index = 0; index < errorInvitees.length; index++) {
      if (index >= 5) {
        userIDs += '... ';
        break;
      }

      var userID = errorInvitees.elementAt(index);
      userIDs += '$userID ';
    }
    if (userIDs.isNotEmpty) {
      userIDs = userIDs.substring(0, userIDs.length - 1);
    }

    var message = 'error users: $userIDs';
    if (code.isNotEmpty) {
      message += ', ${Translations.tips.errorCode}: $code, '
          '${Translations.tips.errorMsg}:$message';
    }
    showFailedToast(message);
  } else if (code.isNotEmpty) {
    showFailedToast(
      '${Translations.tips.errorCode}: $code, '
      '${Translations.tips.errorMsg}:$message',
    );
  }
}
