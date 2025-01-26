// Flutter imports:
import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_live_audio_room/zego_uikit_prebuilt_live_audio_room.dart';

// Project imports:
import 'package:zego_uikits_demo/data/assets.dart';
import 'package:zego_uikits_demo/data/settings.dart';
import 'package:zego_uikits_demo/data/user.dart';
import 'package:zego_uikits_demo/kits/audio_room/cache.dart';
import 'package:zego_uikits_demo/kits/audio_room/zego_page.dart';
import 'package:zego_uikits_demo/kits/room_list.dart';

class MediaAudioRoomPage extends StatefulWidget {
  const MediaAudioRoomPage({super.key});

  @override
  State<MediaAudioRoomPage> createState() {
    return _MediaAudioRoomPageState();
  }
}

class _MediaAudioRoomPageState extends State<MediaAudioRoomPage> {
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
          configQuery: (ZegoUIKitPrebuiltLiveAudioRoomConfig config) {
            config.mediaPlayer.defaultPlayer.support = true;
            return config;
          },
          eventsQuery: (ZegoUIKitPrebuiltLiveAudioRoomEvents events) {
            events.room.onStateChanged = (ZegoUIKitRoomState state) {
              if (state.reason == ZegoRoomStateChangedReason.Logined) {
                tryAutoPlayMedia(isHost);
              }
            };

            return events;
          },
        ),
      ),
    );
  }

  void tryAutoPlayMedia(bool isHost) {
    if (!isHost) {
      return;
    }

    if (AudioRoomCache().mediaDefaultURL.isNotEmpty) {
      ZegoUIKitPrebuiltLiveAudioRoomController().media.play(
            filePathOrURL: AudioRoomCache().mediaDefaultURL,
            autoStart: AudioRoomCache().autoPlayMedia,
          );
    }
  }
}
