// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:zego_uikits_demo/common/settings.dart';
import 'package:zego_uikits_demo/common/string_list_editor.dart';
import 'package:zego_uikits_demo/data/translations.dart';
import 'package:zego_uikits_demo/kits/audio_room/cache.dart';

class AudioRoomPageSettings extends StatefulWidget {
  const AudioRoomPageSettings({super.key});

  @override
  State<AudioRoomPageSettings> createState() {
    return _AudioRoomPageSettingsState();
  }
}

class _AudioRoomPageSettingsState extends State<AudioRoomPageSettings> {
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
              Translations.settings.audioListId,
              [
                roomIDEditor(),
              ],
            ),
            settingsGroup(
              Translations.settings.mediaSharing,
              [
                settingsEditor(
                  tips: Translations.settings.url,
                  value: AudioRoomCache().mediaDefaultURL,
                  onChanged: (String value) {
                    AudioRoomCache().mediaDefaultURL = value;
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.autoPlay,
                  value: AudioRoomCache().autoPlayMedia,
                  onChanged: (value) {
                    setState(() {
                      AudioRoomCache().autoPlayMedia = value ?? true;
                    });
                  },
                ),
              ],
            ),
            settingsGroup(
              Translations.settings.basic,
              [
                settingsCheckBox(
                  title: Translations.settings.turnOnMicrophoneWhenJoining,
                  value: AudioRoomCache().turnOnMicrophoneWhenJoining,
                  onChanged: (value) {
                    setState(() {
                      AudioRoomCache().turnOnMicrophoneWhenJoining =
                          value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.useSpeakerWhenJoining,
                  value: AudioRoomCache().useSpeakerWhenJoining,
                  onChanged: (value) {
                    setState(() {
                      AudioRoomCache().useSpeakerWhenJoining = value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.rootNavigator,
                  value: AudioRoomCache().rootNavigator,
                  onChanged: (value) {
                    setState(() {
                      AudioRoomCache().rootNavigator = value ?? false;
                    });
                  },
                ),
              ],
            ),
            settingsGroup(
              Translations.settings.seat,
              [
                layoutMode(),
                settingsCheckBox(
                  title: Translations.settings.seatCloseWhenJoining,
                  value: AudioRoomCache().seatCloseWhenJoining,
                  onChanged: (value) {
                    setState(() {
                      AudioRoomCache().seatCloseWhenJoining = value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.seatShowSoundWaveInAudioMode,
                  value: AudioRoomCache().seatShowSoundWaveInAudioMode,
                  onChanged: (value) {
                    setState(() {
                      AudioRoomCache().seatShowSoundWaveInAudioMode =
                          value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.seatKeepOriginalForeground,
                  value: AudioRoomCache().seatKeepOriginalForeground,
                  onChanged: (value) {
                    setState(() {
                      AudioRoomCache().seatKeepOriginalForeground =
                          value ?? false;
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
                  value: AudioRoomCache().bottomMenuBarVisible,
                  onChanged: (value) {
                    setState(() {
                      AudioRoomCache().bottomMenuBarVisible = value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.showInRoomMessageButton,
                  value: AudioRoomCache().bottomMenuBarShowInRoomMessageButton,
                  onChanged: (value) {
                    setState(() {
                      AudioRoomCache().bottomMenuBarShowInRoomMessageButton =
                          value ?? true;
                    });
                  },
                ),
                settingsIntEditor(
                  tips: Translations.settings.bottomMenuBarMaxCount,
                  value: AudioRoomCache().bottomMenuBarMaxCount,
                  onChanged: (value) {
                    setState(() {
                      AudioRoomCache().bottomMenuBarMaxCount = value;
                    });
                  },
                ),
              ],
            ),
            settingsGroup(
              Translations.settings.inRoomMessage,
              [
                settingsCheckBox(
                  title: Translations.settings.visible,
                  value: AudioRoomCache().inRoomMessageVisible,
                  onChanged: (value) {
                    setState(() {
                      AudioRoomCache().inRoomMessageVisible = value ?? true;
                    });
                  },
                ),
                settingsDoubleEditor(
                  tips: Translations.settings.inRoomMessageWidth,
                  value: AudioRoomCache().inRoomMessageWidth ?? 0.0,
                  onChanged: (value) {
                    setState(() {
                      AudioRoomCache().inRoomMessageWidth =
                          value > 0 ? value : null;
                    });
                  },
                ),
                settingsDoubleEditor(
                  tips: Translations.settings.inRoomMessageHeight,
                  value: AudioRoomCache().inRoomMessageHeight ?? 0.0,
                  onChanged: (value) {
                    setState(() {
                      AudioRoomCache().inRoomMessageHeight =
                          value > 0 ? value : null;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.inRoomMessageShowName,
                  value: AudioRoomCache().inRoomMessageShowName,
                  onChanged: (value) {
                    setState(() {
                      AudioRoomCache().inRoomMessageShowName = value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.inRoomMessageShowAvatar,
                  value: AudioRoomCache().inRoomMessageShowAvatar,
                  onChanged: (value) {
                    setState(() {
                      AudioRoomCache().inRoomMessageShowAvatar = value ?? true;
                    });
                  },
                ),
                settingsDoubleEditor(
                  tips: Translations.settings.inRoomMessageOpacity,
                  value: AudioRoomCache().inRoomMessageOpacity,
                  onChanged: (value) {
                    setState(() {
                      AudioRoomCache().inRoomMessageOpacity = value;
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
                  value: AudioRoomCache().durationIsVisible,
                  onChanged: (value) {
                    setState(() {
                      AudioRoomCache().durationIsVisible = value ?? true;
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
                  value: AudioRoomCache().pipAspectWidth,
                  onChanged: (value) {
                    setState(() {
                      AudioRoomCache().pipAspectWidth = value;
                    });
                  },
                ),
                settingsIntEditor(
                  tips: Translations.settings.pipAspectHeight,
                  value: AudioRoomCache().pipAspectHeight,
                  onChanged: (value) {
                    setState(() {
                      AudioRoomCache().pipAspectHeight = value;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.pipEnableWhenBackground,
                  value: AudioRoomCache().pipEnableWhenBackground,
                  onChanged: (value) {
                    setState(() {
                      AudioRoomCache().pipEnableWhenBackground = value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.pipAndroidShowUserName,
                  value: AudioRoomCache().pipAndroidShowUserName,
                  onChanged: (value) {
                    setState(() {
                      AudioRoomCache().pipAndroidShowUserName = value ?? true;
                    });
                  },
                ),
              ],
            ),
            settingsGroup(
              Translations.settings.mediaPlayer,
              [
                settingsCheckBox(
                  title: Translations.settings.mediaPlayerSupportTransparent,
                  value: AudioRoomCache().mediaPlayerSupportTransparent,
                  onChanged: (value) {
                    setState(() {
                      AudioRoomCache().mediaPlayerSupportTransparent =
                          value ?? false;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.mediaPlayerDefaultPlayerSupport,
                  value: AudioRoomCache().mediaPlayerDefaultPlayerSupport,
                  onChanged: (value) {
                    setState(() {
                      AudioRoomCache().mediaPlayerDefaultPlayerSupport =
                          value ?? false;
                    });
                  },
                ),
              ],
            ),
            settingsGroup(
              Translations.settings.backgroundMedia,
              [
                settingsEditor(
                  tips: Translations.settings.backgroundMediaPath,
                  value: AudioRoomCache().backgroundMediaPath ?? '',
                  onChanged: (String value) {
                    AudioRoomCache().backgroundMediaPath =
                        value.isEmpty ? null : value;
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.backgroundMediaEnableRepeat,
                  value: AudioRoomCache().backgroundMediaEnableRepeat,
                  onChanged: (value) {
                    setState(() {
                      AudioRoomCache().backgroundMediaEnableRepeat =
                          value ?? true;
                    });
                  },
                ),
              ],
            ),
            settingsGroup(
              Translations.settings.signalingPlugin,
              [
                settingsCheckBox(
                  title:
                      Translations.settings.signalingPluginLeaveRoomOnDispose,
                  value: AudioRoomCache().signalingPluginLeaveRoomOnDispose,
                  onChanged: (value) {
                    setState(() {
                      AudioRoomCache().signalingPluginLeaveRoomOnDispose =
                          value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.signalingPluginUninitOnDispose,
                  value: AudioRoomCache().signalingPluginUninitOnDispose,
                  onChanged: (value) {
                    setState(() {
                      AudioRoomCache().signalingPluginUninitOnDispose =
                          value ?? true;
                    });
                  },
                ),
              ],
            ),
            settingsGroup(
              Translations.settings.common,
              [
                showBackground(),
                showHostInfo(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget layoutMode() {
    return settingSwitchDropList<AudioRoomLayoutMode>(
      title: Translations.settings.layoutMode,
      defaultValue: AudioRoomCache().layoutMode,
      itemValues: [
        AudioRoomLayoutMode.defaultLayout,
        AudioRoomLayoutMode.full,
        AudioRoomLayoutMode.horizontal,
        AudioRoomLayoutMode.vertical,
        AudioRoomLayoutMode.hostTopCenter,
        AudioRoomLayoutMode.hostCenter,
        AudioRoomLayoutMode.fourPeoples,
      ],
      onChanged: (layoutMode) {
        setState(() {
          AudioRoomCache().layoutMode = layoutMode;
        });
      },
      widgetBuilder: (layoutMode) {
        return Text(
          layoutMode.name,
          style: settingsTextStyle,
        );
      },
    );
  }

  Widget showBackground() {
    return settingsCheckBox(
      title: Translations.settings.showBackground,
      value: AudioRoomCache().showBackground,
      onChanged: (bool? value) {
        setState(() {
          AudioRoomCache().showBackground = value!;
        });
      },
    );
  }

  Widget showHostInfo() {
    return settingsCheckBox(
      title: Translations.settings.showHostInfo,
      value: AudioRoomCache().showHostInfo,
      onChanged: (bool? value) {
        setState(() {
          AudioRoomCache().showHostInfo = value!;
        });
      },
    );
  }

  Widget roomIDEditor() {
    return StringListTextEditor(
      tips: Translations.settings.idTips,
      fontSize: 20.r,
      defaultValues: AudioRoomCache().roomIDList.value,
      onAdd: (String roomID) {
        AudioRoomCache().addRoomID(roomID);
      },
      onDelete: (String roomID) {
        AudioRoomCache().removeRoomID(roomID);
      },
    );
  }
}
