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
              '${Translations.settings.common}(${Translations.settings.starTips})',
              [
                settingsCheckBox(
                  title: Translations.settings.screenSharing,
                  value: CallCache().supportScreenSharing,
                  onChanged: (value) {
                    setState(() {
                      CallCache().supportScreenSharing = value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.pip,
                  value: CallCache().supportPIP,
                  onChanged: (value) {
                    setState(() {
                      CallCache().supportPIP = value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: '${Translations.settings.advanceBeauty}(*)',
                  value: CallCache().supportAdvanceBeauty,
                  onChanged: (value) {
                    setState(() {
                      CallCache().supportAdvanceBeauty = value ?? true;
                    });
                  },
                ),
              ],
            ),
            settingsGroup(
              Translations.settings.audioVideo,
              [
                settingsCheckBox(
                  title: Translations.settings.videoAspectFill,
                  value: CallCache().videoAspectFill,
                  onChanged: (value) {
                    setState(() {
                      CallCache().videoAspectFill = value ?? true;
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
      ],
    );
  }
}
