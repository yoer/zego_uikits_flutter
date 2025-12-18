// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';

// Project imports:
import 'package:zego_uikits_demo/common/settings.dart';
import 'package:zego_uikits_demo/common/string_list_editor.dart';
import 'package:zego_uikits_demo/data/translations.dart';
import 'cache.dart';

class ConferencePageSettings extends StatefulWidget {
  const ConferencePageSettings({super.key});

  @override
  State<ConferencePageSettings> createState() {
    return _ConferencePageSettingsState();
  }
}

class _ConferencePageSettingsState extends State<ConferencePageSettings> {
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
              Translations.settings.conferenceListId,
              [
                roomIDEditor(),
              ],
            ),
            settingsGroup(
              Translations.settings.basic,
              [
                settingsCheckBox(
                  title: Translations.settings.turnOnCameraWhenJoining,
                  value: ConferenceCache().turnOnCameraWhenJoining,
                  onChanged: (value) {
                    setState(() {
                      ConferenceCache().turnOnCameraWhenJoining = value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.useFrontFacingCamera,
                  value: ConferenceCache().useFrontFacingCamera,
                  onChanged: (value) {
                    setState(() {
                      ConferenceCache().useFrontFacingCamera = value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.turnOnMicrophoneWhenJoining,
                  value: ConferenceCache().turnOnMicrophoneWhenJoining,
                  onChanged: (value) {
                    setState(() {
                      ConferenceCache().turnOnMicrophoneWhenJoining =
                          value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.useSpeakerWhenJoining,
                  value: ConferenceCache().useSpeakerWhenJoining,
                  onChanged: (value) {
                    setState(() {
                      ConferenceCache().useSpeakerWhenJoining = value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.rootNavigator,
                  value: ConferenceCache().rootNavigator,
                  onChanged: (value) {
                    setState(() {
                      ConferenceCache().rootNavigator = value ?? false;
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
                  value: ConferenceCache().videoAspectFill,
                  onChanged: (value) {
                    setState(() {
                      ConferenceCache().videoAspectFill = value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.muteInvisible,
                  value: ConferenceCache().muteInvisible,
                  onChanged: (value) {
                    setState(() {
                      ConferenceCache().muteInvisible = value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.isVideoMirror,
                  value: ConferenceCache().isVideoMirror,
                  onChanged: (value) {
                    setState(() {
                      ConferenceCache().isVideoMirror = value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.showMicrophoneStateOnView,
                  value: ConferenceCache().showMicrophoneStateOnView,
                  onChanged: (value) {
                    setState(() {
                      ConferenceCache().showMicrophoneStateOnView =
                          value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.showCameraStateOnView,
                  value: ConferenceCache().showCameraStateOnView,
                  onChanged: (value) {
                    setState(() {
                      ConferenceCache().showCameraStateOnView = value ?? false;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.showUserNameOnView,
                  value: ConferenceCache().showUserNameOnView,
                  onChanged: (value) {
                    setState(() {
                      ConferenceCache().showUserNameOnView = value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.showAvatarInAudioMode,
                  value: ConferenceCache().showAvatarInAudioMode,
                  onChanged: (value) {
                    setState(() {
                      ConferenceCache().showAvatarInAudioMode = value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.showSoundWavesInAudioMode,
                  value: ConferenceCache().showSoundWavesInAudioMode,
                  onChanged: (value) {
                    setState(() {
                      ConferenceCache().showSoundWavesInAudioMode =
                          value ?? true;
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
                  value: ConferenceCache().topMenuBarIsVisible,
                  onChanged: (value) {
                    setState(() {
                      ConferenceCache().topMenuBarIsVisible = value ?? true;
                    });
                  },
                ),
                settingsEditor(
                  tips: Translations.settings.topMenuBarTitle,
                  value: ConferenceCache().topMenuBarTitle,
                  onChanged: (String value) {
                    ConferenceCache().topMenuBarTitle = value;
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.hideAutomatically,
                  value: ConferenceCache().topMenuBarHideAutomatically,
                  onChanged: (value) {
                    setState(() {
                      ConferenceCache().topMenuBarHideAutomatically =
                          value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.hideByClick,
                  value: ConferenceCache().topMenuBarHideByClick,
                  onChanged: (value) {
                    setState(() {
                      ConferenceCache().topMenuBarHideByClick = value ?? true;
                    });
                  },
                ),
                menuBarStyleSelector(
                  title: Translations.settings.topMenuBarStyle,
                  value: ConferenceCache().topMenuBarStyle,
                  onChanged: (value) {
                    setState(() {
                      ConferenceCache().topMenuBarStyle = value;
                    });
                  },
                ),
              ],
            ),
            settingsGroup(
              Translations.settings.bottomMenuBar,
              [
                settingsCheckBox(
                  title: Translations.settings.hideAutomatically,
                  value: ConferenceCache().bottomMenuBarHideAutomatically,
                  onChanged: (value) {
                    setState(() {
                      ConferenceCache().bottomMenuBarHideAutomatically =
                          value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.hideByClick,
                  value: ConferenceCache().bottomMenuBarHideByClick,
                  onChanged: (value) {
                    setState(() {
                      ConferenceCache().bottomMenuBarHideByClick =
                          value ?? true;
                    });
                  },
                ),
                settingsIntEditor(
                  tips: Translations.settings.bottomMenuBarMaxCount,
                  value: ConferenceCache().bottomMenuBarMaxCount,
                  onChanged: (value) {
                    setState(() {
                      ConferenceCache().bottomMenuBarMaxCount = value;
                    });
                  },
                ),
                menuBarStyleSelector(
                  title: Translations.settings.bottomMenuBarStyle,
                  value: ConferenceCache().bottomMenuBarStyle,
                  onChanged: (value) {
                    setState(() {
                      ConferenceCache().bottomMenuBarStyle = value;
                    });
                  },
                ),
              ],
            ),
            settingsGroup(
              Translations.settings.memberList,
              [
                settingsCheckBox(
                  title: Translations.settings.memberListShowMicrophoneState,
                  value: ConferenceCache().memberListShowMicrophoneState,
                  onChanged: (value) {
                    setState(() {
                      ConferenceCache().memberListShowMicrophoneState =
                          value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.memberListShowCameraState,
                  value: ConferenceCache().memberListShowCameraState,
                  onChanged: (value) {
                    setState(() {
                      ConferenceCache().memberListShowCameraState =
                          value ?? true;
                    });
                  },
                ),
              ],
            ),
            settingsGroup(
              Translations.settings.notificationView,
              [
                settingsCheckBox(
                  title: Translations.settings.notificationViewNotifyUserLeave,
                  value: ConferenceCache().notificationViewNotifyUserLeave,
                  onChanged: (value) {
                    setState(() {
                      ConferenceCache().notificationViewNotifyUserLeave =
                          value ?? true;
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
                  value: ConferenceCache().durationIsVisible,
                  onChanged: (value) {
                    setState(() {
                      ConferenceCache().durationIsVisible = value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.durationCanSync,
                  value: ConferenceCache().durationCanSync,
                  onChanged: (value) {
                    setState(() {
                      ConferenceCache().durationCanSync = value ?? false;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget menuBarStyleSelector({
    required String title,
    required int value,
    required ValueChanged<int> onChanged,
  }) {
    return settingSwitchDropList<int>(
      title: title,
      defaultValue: value,
      itemValues: [0, 1], // 0 = light, 1 = dark
      onChanged: onChanged,
      widgetBuilder: (int style) {
        return Text(
          style == 0 ? 'Light' : 'Dark',
          style: settingsTextStyle,
        );
      },
    );
  }

  Widget roomIDEditor() {
    return StringListTextEditor(
      tips: Translations.settings.idTips,
      fontSize: 20.r,
      defaultValues: ConferenceCache().roomIDList.value,
      onAdd: (String roomID) {
        ConferenceCache().addRoomID(roomID);
      },
      onDelete: (String roomID) {
        ConferenceCache().removeRoomID(roomID);
      },
    );
  }
}
