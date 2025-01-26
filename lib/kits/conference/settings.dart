// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
              Translations.settings.common,
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
