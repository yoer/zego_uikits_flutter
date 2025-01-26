// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

// Project imports:
import 'package:zego_uikits_demo/common/avatar.dart';
import 'package:zego_uikits_demo/data/settings.dart';
import 'package:zego_uikits_demo/data/translations.dart';
import 'package:zego_uikits_demo/kits/live_streaming/cache.dart';
import 'package:zego_uikits_demo/kits/live_streaming/zego_page.dart';

class LiveStreamingLiveListPage extends StatefulWidget {
  const LiveStreamingLiveListPage({
    super.key,
    required this.settingPageBackNotifier,
  });

  final ValueNotifier<int> settingPageBackNotifier;

  @override
  State<LiveStreamingLiveListPage> createState() {
    return _LiveStreamingLiveListPageState();
  }
}

class _LiveStreamingLiveListPageState extends State<LiveStreamingLiveListPage> {
  final hostInfosEmptyNotifier = ValueNotifier<bool>(true);
  final outsideLiveListController =
      ZegoLiveStreamingOutsideLiveListController();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: widget.settingPageBackNotifier,
      builder: (context, _, __) {
        onLiveListMapUpdate();

        return ValueListenableBuilder(
          valueListenable: hostInfosEmptyNotifier,
          builder: (context, isHostInfoEmpty, _) {
            return isHostInfoEmpty ? liveListEmptyTips() : liveList();
          },
        );
      },
    );
  }

  Widget liveListEmptyTips() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(color: Colors.white),
            Text(
              Translations.liveStreaming.liveListEmptyTips,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 30.r),
            )
          ],
        ),
      ),
    );
  }

  Widget liveList() {
    return ZegoLiveStreamingOutsideLiveList(
      appID: int.parse(SettingsCache().appID),
      appSign: SettingsCache().appSign,
      token: SettingsCache().appToken,
      controller: outsideLiveListController,
      style: ZegoLiveStreamingOutsideLiveListStyle(
        scrollDirection: LiveStreamingCache().liveListHorizontal
            ? Axis.horizontal
            : Axis.vertical,
        scrollAxisCount: LiveStreamingCache().liveListAxisCount,
        itemAspectRatio:
            LiveStreamingCache().liveListHorizontal ? 16.0 / 9.0 : 9.0 / 16.0,
        item: ZegoLiveStreamingOutsideLiveListItemStyle(
          foregroundBuilder: foreground,
          loadingBuilder: (
            BuildContext context,
            ZegoUIKitUser? user,
            String roomID,
          ) {
            return ValueListenableBuilder<bool>(
              valueListenable:
                  ZegoUIKit().getCameraStateNotifier(user?.id ?? ''),
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
          avatar: ZegoAvatarConfig(
            builder: (
              BuildContext context,
              Size size,
              ZegoUIKitUser? user,
              Map<String, dynamic> extraInfo,
            ) {
              return avatar(user?.id ?? '');
            },
          ),
        ),
      ),
      config: ZegoOutsideRoomAudioVideoViewListConfig(
        video: ZegoUIKitVideoConfig.preset180P(),
        audioVideoResourceMode: ZegoAudioVideoResourceMode.onlyRTC,
      ),
    );
  }

  Widget foreground(
    BuildContext context,
    Size size,
    ZegoUIKitUser? user,
    String roomID,
  ) {
    final textStyle = TextStyle(fontSize: 20.r, color: Colors.white);

    return Stack(
      children: [
        Positioned(
          left: 10.r,
          bottom: 10.r,
          child: Text(
            '@user_${user?.id}',
            style: TextStyle(
                fontSize: 20.r,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
        Positioned(
          left: 20.r,
          right: 20.r,
          bottom: 50.r,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.white.withOpacity(0.2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
            child: Text(
              Translations.liveStreaming.enterLive,
              style: textStyle,
            ),
            onPressed: () {
              startLiveStreaming(
                context: context,
                liveID: roomID,
                isHost: false,
                addRoomIDPrefix: false,
                configQuery: (config) {
                  config.outsideLives.controller = outsideLiveListController;
                  return config;
                },
              );
            },
          ),
        ),
      ],
    );
  }

  void onLiveListMapUpdate() {
    final hostInfos = LiveStreamingCache()
        .liveListMap
        .value
        .entries
        .map((entry) => ZegoLiveStreamingOutsideLiveListHost(
              user: ZegoUIKitUser(id: entry.key, name: ''),
              roomID: 'live_${entry.value}',
            ))
        .toList();

    hostInfosEmptyNotifier.value = hostInfos.isEmpty;
    outsideLiveListController.updateHosts(hostInfos);
  }
}
