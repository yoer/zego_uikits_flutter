// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  var currentPageIndex = 0;
  List<String> liveIDs = [];

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
    roomsState.states.forEach((roomID, roomState) {
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

            currentPageIndex = 0;

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
                    config.swiping = ZegoLiveStreamingSwipingConfig(
                      requirePreviousLiveID: () {
                        currentPageIndex = currentPageIndex - 1;
                        if (currentPageIndex < 0) {
                          // currentPageIndex = 0;  No page loop, at the top.
                          currentPageIndex = liveIDs.length -
                              1; //  Cycle through the pages to get back to the bottom
                        }
                        return 'live_${liveIDs[currentPageIndex]}';
                      },
                      requireNextLiveID: () {
                        currentPageIndex = currentPageIndex + 1;
                        if (currentPageIndex > liveIDs.length - 1) {
                          //currentPageIndex = liveIDs.length - 1;   No page rotation. It's over.
                          currentPageIndex =
                              0; //  Cycle through the pages to get back to the top
                        }

                        return 'live_${liveIDs[currentPageIndex]}';
                      },
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
