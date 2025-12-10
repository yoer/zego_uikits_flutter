// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:zego_uikits_demo/common/settings.dart';
import 'package:zego_uikits_demo/common/string_list_editor.dart';
import 'package:zego_uikits_demo/data/translations.dart';
import 'cache.dart';

class CallPageSettings extends StatefulWidget {
  const CallPageSettings({super.key});

  @override
  State<CallPageSettings> createState() {
    return _CallPageSettingsState();
  }
}

class _CallPageSettingsState extends State<CallPageSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Translations.settings.title),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            settingsGroup(
              Translations.settings.callListId,
              [
                roomIDEditor(),
              ],
            ),
            settingsLine(),
            settingsGroup(
              '邀请-${Translations.settings.invitationAbout}(${Translations.settings.starTips})',
              [
                invitation(),
              ],
            ),
            settingsGroup(
              '邀请-${Translations.settings.calling}(${Translations.settings.starTips})',
              [
                settingsCheckBox(
                  title: '${Translations.settings.uiShowAvatar}(*)',
                  value: CallCache().invitation.uiShowAvatar,
                  onChanged: (value) {
                    setState(() {
                      CallCache().invitation.uiShowAvatar = value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: '${Translations.settings.uiShowCentralName}(*)',
                  value: CallCache().invitation.uiShowCentralName,
                  onChanged: (value) {
                    setState(() {
                      CallCache().invitation.uiShowCentralName = value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: '${Translations.settings.uiShowCallingText}(*)',
                  value: CallCache().invitation.uiShowCallingText,
                  onChanged: (value) {
                    setState(() {
                      CallCache().invitation.uiShowCallingText = value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: '${Translations.settings.uiUseVideoViewAspectFill}(*)',
                  value: CallCache().invitation.uiUseVideoViewAspectFill,
                  onChanged: (value) {
                    setState(() {
                      CallCache().invitation.uiUseVideoViewAspectFill =
                          value ?? false;
                    });
                  },
                ),
                settingsCheckBox(
                  title: '${Translations.settings.uiDefaultMicrophoneOn}(*)',
                  value: CallCache().invitation.uiDefaultMicrophoneOn,
                  onChanged: (value) {
                    setState(() {
                      CallCache().invitation.uiDefaultMicrophoneOn =
                          value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: '${Translations.settings.uiDefaultCameraOn}(*)',
                  value: CallCache().invitation.uiDefaultCameraOn,
                  onChanged: (value) {
                    setState(() {
                      CallCache().invitation.uiDefaultCameraOn = value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: '${Translations.settings.uiDefaultSpeakerOn}(*)',
                  value: CallCache().invitation.uiDefaultSpeakerOn,
                  onChanged: (value) {
                    setState(() {
                      CallCache().invitation.uiDefaultSpeakerOn = value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: '${Translations.settings.uiShowMainButtonsText}(*)',
                  value: CallCache().invitation.uiShowMainButtonsText,
                  onChanged: (value) {
                    setState(() {
                      CallCache().invitation.uiShowMainButtonsText =
                          value ?? false;
                    });
                  },
                ),
                settingsCheckBox(
                  title: '${Translations.settings.uiShowSubButtonsText}(*)',
                  value: CallCache().invitation.uiShowSubButtonsText,
                  onChanged: (value) {
                    setState(() {
                      CallCache().invitation.uiShowSubButtonsText =
                          value ?? true;
                    });
                  },
                ),
                // minimized settings for inviter
                settingsCheckBox(
                  title:
                      '${Translations.settings.uiInviterMinimizedCancelButtonVisible}(*)',
                  value: CallCache()
                      .invitation
                      .uiInviterMinimizedCancelButtonVisible,
                  onChanged: (value) {
                    setState(() {
                      CallCache()
                              .invitation
                              .uiInviterMinimizedCancelButtonVisible =
                          value ?? false;
                    });
                  },
                ),
                settingsCheckBox(
                  title:
                      '${Translations.settings.uiInviterMinimizedShowTips}(*)',
                  value: CallCache().invitation.uiInviterMinimizedShowTips,
                  onChanged: (value) {
                    setState(() {
                      CallCache().invitation.uiInviterMinimizedShowTips =
                          value ?? true;
                    });
                  },
                ),
                // minimized settings for invitee
                settingsCheckBox(
                  title:
                      '${Translations.settings.uiInviteeMinimizedAcceptButtonVisible}(*)',
                  value: CallCache()
                      .invitation
                      .uiInviteeMinimizedAcceptButtonVisible,
                  onChanged: (value) {
                    setState(() {
                      CallCache()
                              .invitation
                              .uiInviteeMinimizedAcceptButtonVisible =
                          value ?? false;
                    });
                  },
                ),
                settingsCheckBox(
                  title:
                      '${Translations.settings.uiInviteeMinimizedDeclineButtonVisible}(*)',
                  value: CallCache()
                      .invitation
                      .uiInviteeMinimizedDeclineButtonVisible,
                  onChanged: (value) {
                    setState(() {
                      CallCache()
                              .invitation
                              .uiInviteeMinimizedDeclineButtonVisible =
                          value ?? false;
                    });
                  },
                ),
                settingsCheckBox(
                  title:
                      '${Translations.settings.uiInviteeMinimizedShowTips}(*)',
                  value: CallCache().invitation.uiInviteeMinimizedShowTips,
                  onChanged: (value) {
                    setState(() {
                      CallCache().invitation.uiInviteeMinimizedShowTips =
                          value ?? true;
                    });
                  },
                ),
              ],
            ),
            settingsGroup(
              Translations.settings.basic,
              [
                settingsCheckBox(
                  title: Translations.settings.turnOnCameraWhenJoining,
                  value: CallCache().turnOnCameraWhenJoining,
                  onChanged: (value) {
                    setState(() {
                      CallCache().turnOnCameraWhenJoining = value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.useFrontFacingCamera,
                  value: CallCache().useFrontCameraWhenJoining,
                  onChanged: (value) {
                    setState(() {
                      CallCache().useFrontCameraWhenJoining = value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.turnOnMicrophoneWhenJoining,
                  value: CallCache().turnOnMicrophoneWhenJoining,
                  onChanged: (value) {
                    setState(() {
                      CallCache().turnOnMicrophoneWhenJoining = value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.useSpeakerWhenJoining,
                  value: CallCache().useSpeakerWhenJoining,
                  onChanged: (value) {
                    setState(() {
                      CallCache().useSpeakerWhenJoining = value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.rootNavigator,
                  value: CallCache().rootNavigator,
                  onChanged: (value) {
                    setState(() {
                      CallCache().rootNavigator = value ?? false;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.enableAccidentalTouchPrevention,
                  value: CallCache().enableAccidentalTouchPrevention,
                  onChanged: (value) {
                    setState(() {
                      CallCache().enableAccidentalTouchPrevention =
                          value ?? true;
                    });
                  },
                ),
              ],
            ),
            settingsGroup(
              Translations.settings.audioVideo,
              [
                settingsCheckBox(
                  title: '${Translations.settings.videoAspectFill}(*)',
                  value: CallCache().videoAspectFill,
                  onChanged: (value) {
                    setState(() {
                      CallCache().videoAspectFill = value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.isVideoMirror,
                  value: CallCache().isVideoMirror,
                  onChanged: (value) {
                    setState(() {
                      CallCache().isVideoMirror = value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.showMicState,
                  value: CallCache().showMicrophoneStateOnView,
                  onChanged: (value) {
                    setState(() {
                      CallCache().showMicrophoneStateOnView = value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.showCameraStateOnView,
                  value: CallCache().showCameraStateOnView,
                  onChanged: (value) {
                    setState(() {
                      CallCache().showCameraStateOnView = value ?? false;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.showUserName,
                  value: CallCache().showUserNameOnView,
                  onChanged: (value) {
                    setState(() {
                      CallCache().showUserNameOnView = value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.showOnlyCameraMicrophoneOpened,
                  value: CallCache().showOnlyCameraMicrophoneOpened,
                  onChanged: (value) {
                    setState(() {
                      CallCache().showOnlyCameraMicrophoneOpened =
                          value ?? false;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.showLocalUser,
                  value: CallCache().showLocalUser,
                  onChanged: (value) {
                    setState(() {
                      CallCache().showLocalUser = value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title:
                      Translations.settings.showWaitingCallAcceptAudioVideoView,
                  value: CallCache().showWaitingCallAcceptAudioVideoView,
                  onChanged: (value) {
                    setState(() {
                      CallCache().showWaitingCallAcceptAudioVideoView =
                          value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.uiShowAvatar,
                  value: CallCache().showAvatarInAudioMode,
                  onChanged: (value) {
                    setState(() {
                      CallCache().showAvatarInAudioMode = value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.showSoundWavesInAudioMode,
                  value: CallCache().showSoundWavesInAudioMode,
                  onChanged: (value) {
                    setState(() {
                      CallCache().showSoundWavesInAudioMode = value ?? true;
                    });
                  },
                ),
              ],
            ),
            settingsGroup(
              Translations.settings.topMenuBar,
              [
                settingsCheckBox(
                  title: Translations.settings.visible,
                  value: CallCache().topMenuBarIsVisible,
                  onChanged: (value) {
                    setState(() {
                      CallCache().topMenuBarIsVisible = value ?? true;
                    });
                  },
                ),
                settingsEditor(
                  tips: Translations.settings.title,
                  value: CallCache().topMenuBarTitle,
                  onChanged: (String value) {
                    CallCache().topMenuBarTitle = value;
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.hideAutomatically,
                  value: CallCache().topMenuBarHideAutomatically,
                  onChanged: (value) {
                    setState(() {
                      CallCache().topMenuBarHideAutomatically = value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.hideByClick,
                  value: CallCache().topMenuBarHideByClick,
                  onChanged: (value) {
                    setState(() {
                      CallCache().topMenuBarHideByClick = value ?? true;
                    });
                  },
                ),
              ],
            ),
            settingsGroup(
              Translations.settings.bottomMenuBar,
              [
                settingsCheckBox(
                  title: Translations.settings.visible,
                  value: CallCache().bottomMenuBarIsVisible,
                  onChanged: (value) {
                    setState(() {
                      CallCache().bottomMenuBarIsVisible = value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.hideAutomatically,
                  value: CallCache().bottomMenuBarHideAutomatically,
                  onChanged: (value) {
                    setState(() {
                      CallCache().bottomMenuBarHideAutomatically =
                          value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.hideByClick,
                  value: CallCache().bottomMenuBarHideByClick,
                  onChanged: (value) {
                    setState(() {
                      CallCache().bottomMenuBarHideByClick = value ?? true;
                    });
                  },
                ),
                settingsIntEditor(
                  tips: Translations.settings.bottomMenuBarMaxCount,
                  value: CallCache().bottomMenuBarMaxCount,
                  onChanged: (value) {
                    setState(() {
                      CallCache().bottomMenuBarMaxCount = value;
                    });
                  },
                ),
              ],
            ),
            settingsGroup(
              Translations.settings.memberList,
              [
                settingsCheckBox(
                  title: Translations.settings.showMicState,
                  value: CallCache().memberListShowMicrophoneState,
                  onChanged: (value) {
                    setState(() {
                      CallCache().memberListShowMicrophoneState = value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.showCameraState,
                  value: CallCache().memberListShowCameraState,
                  onChanged: (value) {
                    setState(() {
                      CallCache().memberListShowCameraState = value ?? true;
                    });
                  },
                ),
              ],
            ),
            settingsGroup(
              Translations.settings.screenSharing,
              [
                settingsIntEditor(
                  tips: Translations.settings.screenSharingAutoStopInvalidCount,
                  value: CallCache().screenSharingAutoStopInvalidCount,
                  onChanged: (value) {
                    setState(() {
                      CallCache().screenSharingAutoStopInvalidCount = value;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.screenSharingDefaultFullScreen,
                  value: CallCache().screenSharingDefaultFullScreen,
                  onChanged: (value) {
                    setState(() {
                      CallCache().screenSharingDefaultFullScreen =
                          value ?? false;
                    });
                  },
                ),
              ],
            ),
            settingsGroup(
              Translations.settings.pip,
              [
                settingsIntEditor(
                  tips: Translations.settings.pipAspectWidth,
                  value: CallCache().pipAspectWidth,
                  onChanged: (value) {
                    setState(() {
                      CallCache().pipAspectWidth = value;
                    });
                  },
                ),
                settingsIntEditor(
                  tips: Translations.settings.pipAspectHeight,
                  value: CallCache().pipAspectHeight,
                  onChanged: (value) {
                    setState(() {
                      CallCache().pipAspectHeight = value;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.pipEnableWhenBackground,
                  value: CallCache().pipEnableWhenBackground,
                  onChanged: (value) {
                    setState(() {
                      CallCache().pipEnableWhenBackground = value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.pipIOSSupport,
                  value: CallCache().pipIOSSupport,
                  onChanged: (value) {
                    setState(() {
                      CallCache().pipIOSSupport = value ?? true;
                    });
                  },
                ),
              ],
            ),
            settingsGroup(
              Translations.settings.requiredUser,
              [
                settingsCheckBox(
                  title: Translations.settings.requiredUserEnabled,
                  value: CallCache().requiredUserEnabled,
                  onChanged: (value) {
                    setState(() {
                      CallCache().requiredUserEnabled = value ?? false;
                    });
                  },
                ),
                settingsIntEditor(
                  tips: Translations.settings.requiredUserDetectSeconds,
                  value: CallCache().requiredUserDetectSeconds,
                  onChanged: (value) {
                    setState(() {
                      CallCache().requiredUserDetectSeconds = value;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.requiredUserDetectInDebugMode,
                  value: CallCache().requiredUserDetectInDebugMode,
                  onChanged: (value) {
                    setState(() {
                      CallCache().requiredUserDetectInDebugMode =
                          value ?? false;
                    });
                  },
                ),
              ],
            ),
            settingsGroup(
              Translations.settings.duration,
              [
                settingsCheckBox(
                  title: Translations.settings.visible,
                  value: CallCache().durationVisible,
                  onChanged: (value) {
                    setState(() {
                      CallCache().durationVisible = value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.autoHangUp,
                  value: CallCache().durationAutoHangUp,
                  onChanged: (value) {
                    setState(() {
                      CallCache().durationAutoHangUp = value ?? true;
                    });
                  },
                ),
                settingsEditor(
                  tips:
                      '${Translations.settings.autoHangUp}(${Translations.settings.seconds})',
                  value: CallCache().durationAutoHangUpSeconds.toString(),
                  onChanged: (String value) {
                    CallCache().durationAutoHangUpSeconds =
                        int.tryParse(value) ?? -1;
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget roomIDEditor() {
    return StringListTextEditor(
      tips: Translations.settings.idTips,
      fontSize: 20.r,
      defaultValues: CallCache().roomIDList.value,
      onAdd: (String roomID) {
        CallCache().addRoomID(roomID);
      },
      onDelete: (String roomID) {
        CallCache().removeRoomID(roomID);
      },
    );
  }

  Widget invitation() {
    return Column(
      children: [
        settingsEditor(
          tips: Translations.settings.invitationTimeout,
          value: CallCache().invitation.timeoutSecond.toString(),
          onChanged: (String value) {
            CallCache().invitation.timeoutSecond = int.tryParse(value) ?? 30;
          },
        ),
        settingsEditor(
          tips: '${Translations.settings.resourceId}(*)',
          value: CallCache().invitation.resourceID,
          onChanged: (String value) {
            CallCache().invitation.resourceID = value;
          },
        ),
        settingsCheckBox(
          title: '${Translations.settings.missedNotification}(*)',
          value: CallCache().invitation.supportMissedNotification,
          onChanged: (value) {
            setState(() {
              CallCache().invitation.supportMissedNotification = value ?? true;
            });
          },
        ),
        settingsCheckBox(
          title: '${Translations.settings.missedNotificationRedial}(*)',
          value: CallCache().invitation.supportMissedNotificationReDial,
          onChanged: (value) {
            setState(() {
              CallCache().invitation.supportMissedNotificationReDial =
                  value ?? false;
            });
          },
        ),
        settingsCheckBox(
          title: '${Translations.settings.callInCalling}(*)',
          value: CallCache().invitation.canInvitingInCalling,
          onChanged: (value) {
            setState(() {
              CallCache().invitation.canInvitingInCalling = value ?? true;
            });
          },
        ),
        settingsCheckBox(
          title: '${Translations.settings.onlyInvitorCanInviteInCalling}(*)',
          value: CallCache().invitation.onlyInitiatorCanInviteInCalling,
          onChanged: (value) {
            setState(() {
              CallCache().invitation.onlyInitiatorCanInviteInCalling =
                  value ?? false;
            });
          },
        ),
        settingsCheckBox(
          title: '${Translations.settings.safeArea}(*)',
          value: CallCache().invitation.safeArea,
          onChanged: (value) {
            setState(() {
              CallCache().invitation.safeArea = value ?? false;
            });
          },
        ),
        settingsCheckBox(
          title: '${Translations.settings.endCallWhenInitiatorLeave}(*)',
          value: CallCache().invitation.endCallWhenInitiatorLeave,
          onChanged: (value) {
            setState(() {
              CallCache().invitation.endCallWhenInitiatorLeave = value ?? false;
            });
          },
        ),
        settingsCheckBox(
          title:
              '${Translations.settings.offlineAutoEnterAcceptedOfflineCall}(*)',
          value: CallCache().invitation.offlineAutoEnterAcceptedOfflineCall,
          onChanged: (value) {
            setState(() {
              CallCache().invitation.offlineAutoEnterAcceptedOfflineCall =
                  value ?? true;
            });
          },
        ),
      ],
    );
  }
}
