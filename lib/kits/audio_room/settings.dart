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
              Translations.settings.seat,
              [
                layoutMode(),
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
