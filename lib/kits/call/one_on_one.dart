// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:zego_uikits_demo/data/assets.dart';
import 'package:zego_uikits_demo/data/settings.dart';
import 'package:zego_uikits_demo/data/user.dart';
import 'package:zego_uikits_demo/kits/call/zego_page.dart';
import 'package:zego_uikits_demo/kits/room_list.dart';
import 'cache.dart';

class OneOnOneCallPage extends StatefulWidget {
  const OneOnOneCallPage({super.key});

  @override
  State<OneOnOneCallPage> createState() {
    return _OneOnOneCallPageState();
  }
}

class _OneOnOneCallPageState extends State<OneOnOneCallPage> {
  @override
  Widget build(BuildContext context) {
    return RoomList(
      cover: Image.asset(
        CallAssets.roomCover,
        fit: BoxFit.fitWidth,
      ),
      valueNotifier: CallCache().roomIDList,
      showJoinButton: true,
      onJoin: (callID) {
        startCall(callID);
      },
    );
  }

  void startCall(String callID) {
    final user = UserService().loginUserNotifier.value!;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ZegoCallPage(
          appID: int.parse(SettingsCache().appID),
          appSign: SettingsCache().appSign,
          token: SettingsCache().appToken,
          userID: user.id,
          userName: user.name,
          roomID: 'call_1v1_$callID',
          isGroup: false,
          isVideo: CallCache().turnOnCameraWhenJoining,
        ),
      ),
    );
  }
}
