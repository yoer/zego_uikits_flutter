// Flutter imports:
import 'package:flutter/cupertino.dart';

// Project imports:
import 'package:zego_uikits_demo/data/assets.dart';
import 'package:zego_uikits_demo/data/translations.dart';
import 'package:zego_uikits_demo/kits/conference/normal.dart';
import 'package:zego_uikits_demo/kits/kits_page.dart';
import 'package:zego_uikits_demo/pages/utils/router.dart';

class ConferencePage extends StatefulWidget {
  const ConferencePage({super.key});

  @override
  State<ConferencePage> createState() {
    return _ConferencePageState();
  }
}

class _ConferencePageState extends State<ConferencePage> {
  @override
  Widget build(BuildContext context) {
    return KitsPage(
      backgroundURL: ConferenceAssets.ad,
      title: Translations.conference.title,
      onSettingsClicked: () {
        PageRouter.conferenceSettings.go(context);
      },
      child: const NormalConferencePage(),
    );
  }
}
