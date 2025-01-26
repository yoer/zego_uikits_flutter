// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:zego_uikits_demo/data/assets.dart';
import 'package:zego_uikits_demo/data/settings.dart';
import 'package:zego_uikits_demo/data/user.dart';
import 'package:zego_uikits_demo/kits/audio_room/cache.dart';
import 'package:zego_uikits_demo/kits/audio_room/zego_page.dart';
import 'package:zego_uikits_demo/kits/room_list.dart';

class NormalAudioRoomPage extends StatefulWidget {
  const NormalAudioRoomPage({super.key});

  @override
  State<NormalAudioRoomPage> createState() {
    return _NormalAudioRoomPageState();
  }
}

class _NormalAudioRoomPageState extends State<NormalAudioRoomPage> {
  @override
  Widget build(BuildContext context) {
    return RoomList(
      cover: Image.asset(
        AudioRoomAssets.roomCover,
        fit: BoxFit.fitWidth,
      ),
      valueNotifier: AudioRoomCache().roomIDList,
      showStartButton: true,
      showJoinButton: true,
      onStart: (roomID) {
        startAudioRoom(roomID, true);
      },
      onJoin: (roomID) {
        startAudioRoom(roomID, false);
      },
    );
  }

  void startAudioRoom(String roomID, bool isHost) {
    final user = UserService().loginUserNotifier.value!;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ZegoAudioRoomPage(
          appID: int.parse(SettingsCache().appID),
          appSign: SettingsCache().appSign,
          token: SettingsCache().appToken,
          userID: user.id,
          userName: user.name,
          roomID: 'audio_room_$roomID',
          isHost: isHost,
        ),
      ),
    );
  }
}
