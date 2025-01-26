// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:zego_uikits_demo/data/assets.dart';
import 'package:zego_uikits_demo/data/settings.dart';
import 'package:zego_uikits_demo/data/user.dart';
import 'package:zego_uikits_demo/kits/call/zego_page.dart';
import 'package:zego_uikits_demo/kits/room_list.dart';
import 'cache.dart';

class GroupCallPage extends StatefulWidget {
  const GroupCallPage({super.key});

  @override
  State<GroupCallPage> createState() {
    return _GroupCallPageState();
  }
}

class _GroupCallPageState extends State<GroupCallPage> {
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
          roomID: 'call_g_$callID',
          isGroup: true,
          isVideo: true,
        ),
      ),
    );
  }
}
