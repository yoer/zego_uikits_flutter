// Dart imports:
import 'dart:async';

// Package imports:
import 'package:firebase_core/firebase_core.dart';
import 'package:zego_uikit_prebuilt_live_audio_room/zego_uikit_prebuilt_live_audio_room.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

// Project imports:
import 'package:zego_uikits_demo/data/user.dart';
import 'package:zego_uikits_demo/firebase_options.dart';
import 'package:zego_uikits_demo/firestore/defines.dart';
import 'package:zego_uikits_demo/firestore/user_doc.dart';
import 'package:zego_uikits_demo/firestore/user_table.dart';

class KitsFirebaseService {
  bool _init = false;
  UserTable? _userTable;

  KitsFirebaseService._internal();

  factory KitsFirebaseService() => _instance;

  static final KitsFirebaseService _instance = KitsFirebaseService._internal();

  UserTable get userTable {
    _userTable ??= UserTable();
    return _userTable!;
  }

  Future<void> init() async {
    if (_init) {
      return;
    }

    _init = true;

    await Firebase.initializeApp(
      name: 'uikits_demo',
      options: DefaultFirebaseOptions.currentPlatform,
    );

    userTable.init();

    /// Start real-time listener
    _startListening();
  }

  void _startListening() {
    ZegoUIKit().getRoomStateStream().addListener(onRoomStateUpdated);
  }

  void onRoomStateUpdated() {
    final roomState = ZegoUIKit().getRoomStateStream().value;

    final isRoomLogin =
        roomState.reason == ZegoRoomStateChangedReason.Logining ||
            roomState.reason == ZegoRoomStateChangedReason.Logined;

    final currentLoginUser = UserService().loginUserNotifier.value;
    final currentRoomID = isRoomLogin ? ZegoUIKit().getRoom().id : '';
    final roomType = RoomTypeExtension.fromRoomID(currentRoomID);

    var isHost = false;
    if (isRoomLogin) {
      switch (roomType) {
        case RoomType.none:
        case RoomType.unknown:
        case RoomType.call:
        case RoomType.liveStreamingList:
          break;
        case RoomType.audioRoom:
          isHost = ZegoUIKitPrebuiltLiveAudioRoomController().seat.localIsHost;
          break;
        case RoomType.liveStreaming:
        case RoomType.liveStreamingPK:
          isHost = ZegoUIKitPrebuiltLiveStreamingController()
                  .coHost
                  .hostNotifier
                  .value
                  ?.id ==
              currentLoginUser?.id;

          ZegoUIKitPrebuiltLiveStreamingController()
              .coHost
              .hostNotifier
              .removeListener(onLiveStreamingHostUpdated);
          ZegoUIKitPrebuiltLiveStreamingController()
              .coHost
              .hostNotifier
              .addListener(onLiveStreamingHostUpdated);
          break;
        case RoomType.conference:
          break;
      }
    } else {
      KitsFirebaseService().userTable.updateUserLiveStreamingPKState(
            currentLoginUser?.id ?? '',
            LiveStreamingPKState.idle,
          );

      ZegoUIKitPrebuiltLiveStreamingController()
          .coHost
          .hostNotifier
          .removeListener(onLiveStreamingHostUpdated);
    }

    userTable.updateUserRoomInfo(
      currentLoginUser?.id ?? '',
      currentRoomID,
      roomType,
      isHost,
    );
  }

  void onLiveStreamingHostUpdated() {
    final currentLoginUser = UserService().loginUserNotifier.value;
    final isHost = ZegoUIKitPrebuiltLiveStreamingController()
            .coHost
            .hostNotifier
            .value
            ?.id ==
        currentLoginUser?.id;
    userTable.updateUserRoomHost(currentLoginUser?.id ?? '', isHost);
  }

  List<UserDoc> queryActiveUsers() {
    return userTable.cacheNotifier.value.values
        .where((user) => user.isLogin)
        .toList();
  }

  List<UserDoc> queryRoomActiveUsers() {
    return userTable.cacheNotifier.value.values
        .where((user) => user.roomID.isNotEmpty)
        .toList();
  }

  List<UserDoc> queryRoomActiveUsersWithType({
    required RoomType roomType,
    required bool isHost,
  }) {
    return userTable.cacheNotifier.value.values
        .where((user) =>
            user.roomID.isNotEmpty &&
            user.roomType == roomType &&
            user.isHost == isHost)
        .toList();
  }
}
