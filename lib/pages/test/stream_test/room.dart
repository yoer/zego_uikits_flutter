// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:zego_uikit/zego_uikit.dart';

// Project imports:
import 'package:zego_uikits_demo/common/toast.dart';
import 'package:zego_uikits_demo/data/translations.dart';
import 'package:zego_uikits_demo/pages/test/stream_test/defines.dart';

class StreamTestRoomWidget extends StatefulWidget {
  final StreamTestSettings settings;
  final VoidCallback onLeaveRoom;

  const StreamTestRoomWidget({
    super.key,
    required this.settings,
    required this.onLeaveRoom,
  });

  @override
  State<StreamTestRoomWidget> createState() => _StreamTestRoomWidgetState();
}

class _StreamTestRoomWidgetState extends State<StreamTestRoomWidget> {
  final inRoomNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();

    onRoomStateUpdated();
    ZegoUIKit().getRoomStateStream().addListener(onRoomStateUpdated);
    _joinRoom();
  }

  @override
  void dispose() {
    ZegoUIKit().getRoomStateStream().removeListener(onRoomStateUpdated);
    if (inRoomNotifier.value) {
      _leaveRoom();
    }
    inRoomNotifier.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ZegoScreenUtilInit(
        designSize: const Size(750, 1334),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return Stack(
            children: [
              avDisplay(),
              closeButton(),
              roomInfo(),
            ],
          );
        },
      ),
    );
  }

  Widget avDisplay() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black,
      child: ValueListenableBuilder<bool>(
        valueListenable: inRoomNotifier,
        builder: (context, isInRoom, _) {
          return isInRoom
              ? ZegoAudioVideoContainer(
                  layout: ZegoLayout.gallery(),
                  sources: const [
                    ZegoAudioVideoContainerSource.user,
                    ZegoAudioVideoContainerSource.audioVideo,
                    ZegoAudioVideoContainerSource.screenSharing,
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
        },
      ),
    );
  }

  Widget roomInfo() {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 10.zR,
      left: 16.zR,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.zR, vertical: 8.zR),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(20.zR),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${Translations.streamTest.roomInfo}: ${widget.settings.roomId}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.zR,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${Translations.streamTest.userInfo}: ${widget.settings.userName}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.zR,
              ),
            ),
            if (widget.settings.streamId.isNotEmpty)
              Text(
                '${Translations.streamTest.streamInfo}: ${widget.settings.streamId}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.zR,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget closeButton() {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 10.zR,
      right: 16.zR,
      child: GestureDetector(
        onTap: _leaveRoom,
        child: Container(
          width: 40.zR,
          height: 40.zR,
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.6),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.close,
            color: Colors.white,
            size: 30.zR,
          ),
        ),
      ),
    );
  }

  void _joinRoom() async {
    try {
      debugPrint('Joining room: ${widget.settings.roomId}');
      debugPrint(
          'User: ${widget.settings.userId} (${widget.settings.userName})');
      debugPrint('Stream: ${widget.settings.streamId}');
      debugPrint('Camera: ${widget.settings.turnOnCamera}');
      debugPrint('Microphone: ${widget.settings.turnOnMicrophone}');

      ZegoUIKit().login(widget.settings.userId, widget.settings.userName);
      await ZegoUIKit().joinRoom(widget.settings.roomId);

      // 根据设置控制摄像头和麦克风
      await _controlCameraAndMicrophone();

      showInfoToast(Translations.streamTest.joinedSuccessfully);
    } catch (e) {
      debugPrint('Failed to join room: $e');
      showInfoToast('${Translations.streamTest.failedToJoin}: $e');
    }
  }

  Future<void> _controlCameraAndMicrophone() async {
    if (widget.settings.turnOnCamera) {
      ZegoUIKit().turnCameraOn(true);
    } else {
      ZegoUIKit().turnCameraOn(false);
    }

    if (widget.settings.turnOnMicrophone) {
      ZegoUIKit().turnMicrophoneOn(true);
    } else {
      ZegoUIKit().turnMicrophoneOn(false);
    }
  }

  void _leaveRoom() async {
    try {
      debugPrint('Leaving room: ${widget.settings.roomId}');

      // 使用ZegoUIKit离开房间
      await ZegoUIKit().leaveRoom();

      widget.onLeaveRoom();
      showInfoToast(Translations.streamTest.leftSuccessfully);
    } catch (e) {
      debugPrint('Failed to leave room: $e');
      showInfoToast('${Translations.streamTest.failedToLeave}: $e');
    }
  }

  void onRoomStateUpdated() {
    final value = ZegoUIKit().getRoomStateStream().value;
    inRoomNotifier.value = ZegoRoomStateChangedReason.Logined == value.reason ||
        ZegoRoomStateChangedReason.Logining == value.reason;
  }
}
