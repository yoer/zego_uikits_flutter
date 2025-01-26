// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:zego_uikits_demo/data/assets.dart';
import 'package:zego_uikits_demo/data/settings.dart';
import 'package:zego_uikits_demo/data/user.dart';
import 'package:zego_uikits_demo/kits/conference/zego_page.dart';
import 'package:zego_uikits_demo/kits/room_list.dart';
import 'cache.dart';

class NormalConferencePage extends StatefulWidget {
  const NormalConferencePage({super.key});

  @override
  State<NormalConferencePage> createState() {
    return _NormalConferencePageState();
  }
}

class _NormalConferencePageState extends State<NormalConferencePage> {
  @override
  Widget build(BuildContext context) {
    return RoomList(
      cover: Image.asset(
        ConferenceAssets.roomCover,
        fit: BoxFit.fitWidth,
      ),
      valueNotifier: ConferenceCache().roomIDList,
      showStartButton: true,
      showJoinButton: true,
      onStart: (conferenceID) {
        startConference(conferenceID, true);
      },
      onJoin: (conferenceID) {
        startConference(conferenceID, false);
      },
    );
  }

  void startConference(String conferenceID, bool isHost) {
    final user = UserService().loginUserNotifier.value!;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ZegoConferencePage(
          appID: int.parse(SettingsCache().appID),
          appSign: SettingsCache().appSign,
          token: SettingsCache().appToken,
          userID: user.id,
          userName: user.name,
          roomID: 'conference_$conferenceID',
          isHost: isHost,
        ),
      ),
    );
  }
}
