// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zego_uikit/zego_uikit.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

// Project imports:
import 'package:zego_uikits_demo/common/toast.dart';
import 'package:zego_uikits_demo/data/settings.dart';
import 'package:zego_uikits_demo/data/translations.dart';
import 'package:zego_uikits_demo/data/user.dart';
import 'package:zego_uikits_demo/kits/live_streaming/cache.dart';
import 'package:zego_uikits_demo/kits/live_streaming/zego_page.dart';

class LiveStreamingSwipingPage extends StatefulWidget {
  const LiveStreamingSwipingPage({
    super.key,
  });

  @override
  State<LiveStreamingSwipingPage> createState() {
    return _LiveStreamingSwipingPageState();
  }
}

class _LiveStreamingSwipingPageState extends State<LiveStreamingSwipingPage> {
  List<String> liveIDs = [];

  final hallHosts = LiveStreamingCache()
      .liveListMap
      .value
      .entries
      .map((entry) => ZegoLiveStreamingHallHost(
            user: ZegoUIKitUser(
              id: entry.key,
              name: 'user_${entry.key}',
              isAnotherRoomUser: true,
            ),
            roomID: 'live_${entry.value}',
          ))
      .toList();

  @override
  void initState() {
    super.initState();

    ZegoUIKit().getRoomsStateStream().addListener(onRoomsStateChanged);
  }

  @override
  void dispose() {
    ZegoUIKit().getRoomsStateStream().removeListener(onRoomsStateChanged);

    super.dispose();
  }

  void onRoomsStateChanged() {
    final roomsState = ZegoUIKit().getRoomsStateStream().value;
    roomsState.forEach((roomID, roomState) {
      if (roomState.reason == ZegoUIKitRoomStateChangedReason.Logined) {
        showInfoToast(Translations.liveStreaming.swipingJoinTips(roomID));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<String>>(
      valueListenable: LiveStreamingCache().roomIDList,
      builder: (context, value, _) {
        liveIDs = value;
        return liveIDs.isEmpty ? emptyTips() : swipingButton();
      },
    );
  }

  Widget swipingButton() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: ElevatedButton(
          onPressed: () {
            final user = UserService().loginUserNotifier.value!;

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ZegoLiveStreamingPage(
                  appID: int.parse(SettingsCache().appID),
                  appSign: SettingsCache().appSign,
                  token: SettingsCache().appToken,
                  userID: user.id,
                  userName: user.name,
                  liveID: 'live_${liveIDs.first}',
                  isHost: false,
                  configQuery: (config) {
                    /// 更新滑动页的主播间滑动上下文
                    config.swiping = ZegoLiveStreamingSwipingConfig(
                      streamMode: LiveStreamingCache().streamMode,
                      model: ZegoUIKitHallRoomListModel.fromActiveStreamUsers(
                        activeStreamUsers: hallHosts,
                      ),
                    );

                    return config;
                  },
                ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
            padding: EdgeInsets.symmetric(
              vertical: 20.r,
              horizontal: 20.r,
            ), // 设置高度和宽度
          ),
          child: Text(
            Translations.tips.join,
            style: TextStyle(color: Colors.white, fontSize: 20.r),
          ),
        ),
      ),
    );
  }

  Widget emptyTips() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.5),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(color: Colors.white),
            Text(
              Translations.liveStreaming.roomListEmptyTips,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 30.r),
            )
          ],
        ),
      ),
    );
  }
}
