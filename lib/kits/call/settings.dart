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
              '${Translations.settings.invitationAbout}(${Translations.settings.starTips})',
              [
                invitation(),
              ],
            ),
            settingsGroup(
              '${Translations.settings.calling}(${Translations.settings.starTips})',
              [
                settingsCheckBox(
                  title: '${Translations.settings.showVideoOnInviteeCall}(*)',
                  value: CallCache().showVideoOnInviteeCall,
                  onChanged: (value) {
                    setState(() {
                      CallCache().showVideoOnInviteeCall = value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: '${Translations.settings.inviteeUIShowAvatar}(*)',
                  value: CallCache().inviteeUIShowAvatar,
                  onChanged: (value) {
                    setState(() {
                      CallCache().inviteeUIShowAvatar = value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: '${Translations.settings.inviteeUIShowCentralName}(*)',
                  value: CallCache().inviteeUIShowCentralName,
                  onChanged: (value) {
                    setState(() {
                      CallCache().inviteeUIShowCentralName = value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: '${Translations.settings.inviteeUIShowCallingText}(*)',
                  value: CallCache().inviteeUIShowCallingText,
                  onChanged: (value) {
                    setState(() {
                      CallCache().inviteeUIShowCallingText = value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title:
                      '${Translations.settings.inviteeUIUseVideoViewAspectFill}(*)',
                  value: CallCache().inviteeUIUseVideoViewAspectFill,
                  onChanged: (value) {
                    setState(() {
                      CallCache().inviteeUIUseVideoViewAspectFill =
                          value ?? false;
                    });
                  },
                ),
                settingsCheckBox(
                  title:
                      '${Translations.settings.inviteeUIDefaultMicrophoneOn}(*)',
                  value: CallCache().inviteeUIDefaultMicrophoneOn,
                  onChanged: (value) {
                    setState(() {
                      CallCache().inviteeUIDefaultMicrophoneOn = value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: '${Translations.settings.inviteeUIDefaultCameraOn}(*)',
                  value: CallCache().inviteeUIDefaultCameraOn,
                  onChanged: (value) {
                    setState(() {
                      CallCache().inviteeUIDefaultCameraOn = value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title:
                      '${Translations.settings.inviteeUIShowMainButtonsText}(*)',
                  value: CallCache().inviteeUIShowMainButtonsText,
                  onChanged: (value) {
                    setState(() {
                      CallCache().inviteeUIShowMainButtonsText = value ?? false;
                    });
                  },
                ),
                settingsCheckBox(
                  title:
                      '${Translations.settings.inviteeUIShowSubButtonsText}(*)',
                  value: CallCache().inviteeUIShowSubButtonsText,
                  onChanged: (value) {
                    setState(() {
                      CallCache().inviteeUIShowSubButtonsText = value ?? true;
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
                  title: Translations.settings.turnOnCameraWhenJoining,
                  value: CallCache().turnOnCameraWhenJoining,
                  onChanged: (value) {
                    setState(() {
                      CallCache().turnOnCameraWhenJoining = value ?? true;
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
              ],
            ),
            settingsGroup(
              Translations.settings.duration,
              [
                settingsCheckBox(
                  title: Translations.settings.visible,
                  value: CallCache().videoAspectFill,
                  onChanged: (value) {
                    setState(() {
                      CallCache().videoAspectFill = value ?? true;
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
      ],
    );
  }
}
