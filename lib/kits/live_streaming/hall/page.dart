// Flutter imports:
import 'dart:math' as math;
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

// Project imports:
import 'package:zego_uikits_demo/common/avatar.dart';
import 'package:zego_uikits_demo/data/settings.dart';
import 'package:zego_uikits_demo/kits/live_streaming/cache.dart';
import 'package:zego_uikits_demo/kits/live_streaming/zego_page.dart';

import 'foreground.dart';

class LiveStreamingLiveHallPage extends StatefulWidget {
  const LiveStreamingLiveHallPage({
    super.key,
  });

  @override
  State<LiveStreamingLiveHallPage> createState() {
    return _LiveStreamingLiveHallPageState();
  }
}

class _LiveStreamingLiveHallPageState extends State<LiveStreamingLiveHallPage> {
  final liveHallController = ZegoLiveStreamingHallListController();

  var currentPageIndex = 0;
  final hallHostsNotifier = ValueNotifier<List<ZegoLiveStreamingHallHost>>([]);

  @override
  void initState() {
    hallHostsNotifier.value = LiveStreamingCache()
        .liveListMap
        .value
        .entries
        .map((entry) => ZegoLiveStreamingHallHost(
              user: ZegoUIKitUser(id: entry.key, name: ''),
              roomID: 'live_${entry.value}',
            ))
        .toList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    currentPageIndex = 0;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            hallList(),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget hallList() {
    return ZegoLiveStreamingHallList(
      appID: int.parse(SettingsCache().appID),
      appSign: SettingsCache().appSign,
      token: SettingsCache().appToken,
      controller: liveHallController,
      initialStreamUser: hallHostsNotifier.value[currentPageIndex],
      initialResponse: ZegoUIKitHallRoomListUpdateResponse(
        previous: hallHostsNotifier.value[hallHostsNotifier.value.length - 1],
        next: hallHostsNotifier.value[1],
      ),
      streamUserUpdateRequest: (bool toNext) {
        var oldCurrentPageIndex = currentPageIndex;
        currentPageIndex += toNext ? 1 : -1;
        if (currentPageIndex < 0) {
          ///  Cycle through the pages to get back to the bottom
          currentPageIndex = hallHostsNotifier.value.length - 1;
        }
        if (currentPageIndex > hallHostsNotifier.value.length - 1) {
          ///  Cycle through the pages to get back to the top
          currentPageIndex = 0;
        }

        var previousIndex = currentPageIndex - 1;
        if (previousIndex < 0) {
          ///  Cycle through the pages to get back to the bottom
          previousIndex = hallHostsNotifier.value.length - 1;
        }

        var nextIndex = currentPageIndex + 1;
        if (nextIndex > hallHostsNotifier.value.length - 1) {
          ///  Cycle through the pages to get back to the top
          nextIndex = 0;
        }

        debugPrint(
          'hall list request, '
          'to next:$toNext, '
          'previous index:$previousIndex, '
          'next index:$nextIndex, '
          'old current index:$oldCurrentPageIndex, '
          'now current index:$currentPageIndex, ',
        );

        return ZegoUIKitHallRoomListUpdateResponse(
          previous: hallHostsNotifier.value[previousIndex],
          next: hallHostsNotifier.value[nextIndex],
        );
      },
      style: ZegoLiveStreamingHallListStyle(
        item: ZegoLiveStreamingHallListItemStyle(
          foregroundBuilder: (
            BuildContext context,
            Size size,
            ZegoUIKitUser? user,
            String roomID,
          ) {
            return LiveStreamingLiveHallForeground(
              user: user,
              liveID: roomID,
              onEnter: () {
                startLiveStreaming(
                  context: context,
                  liveID: roomID,
                  isHost: false,
                  addRoomIDPrefix: false,
                  configQuery: (config) {
                    config.hall = ZegoLiveStreamingHallConfig(
                      fromHall: true,
                      controller: liveHallController,
                    );
                    return config;
                  },
                );
              },
            );
          },
          loadingBuilder: (
            BuildContext context,
            ZegoUIKitUser? user,
            String roomID,
          ) {
            return ValueListenableBuilder<bool>(
              valueListenable: ZegoUIKit().getCameraStateNotifier(
                targetRoomID: liveHallController.roomID,
                user?.id ?? '',
              ),
              builder: (context, isCameraOpen, _) {
                return isCameraOpen
                    ? Container()
                    : Stack(
                        children: [
                          CircleAvatar(
                            child: avatar(user?.id ?? ''),
                          ),
                          const CircularProgressIndicator()
                        ],
                      );
              },
            );
          },
          avatar: ZegoAvatarConfig(builder: (
            BuildContext context,
            Size size,
            ZegoUIKitUser? user,
            Map<String, dynamic> extraInfo,
          ) {
            return avatar(user?.id ?? '');
          }),
        ),
      ),
      config: ZegoLiveStreamingHallListConfig(
        video: ZegoVideoConfigExtension.preset180P(),
        audioVideoResourceMode: ZegoUIKitStreamResourceMode.OnlyRTC,
      ),
    );
  }
}
