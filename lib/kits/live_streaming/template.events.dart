// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:zego_uikit/zego_uikit.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

ZegoUIKitPrebuiltLiveStreamingEvents getEvents(
  bool isHost,
  ValueNotifier<ZegoLiveStreamingState> liveStateNotifier,
) {
  final audienceEvents = ZegoUIKitPrebuiltLiveStreamingEvents(
    audioVideo: ZegoLiveStreamingAudioVideoEvents(
      onCameraTurnOnByOthersConfirmation: (BuildContext context) {
        return onTurnOnAudienceDeviceConfirmation(
          context,
          isCameraOrMicrophone: true,
        );
      },
      onMicrophoneTurnOnByOthersConfirmation: (BuildContext context) {
        return onTurnOnAudienceDeviceConfirmation(
          context,
          isCameraOrMicrophone: false,
        );
      },
    ),
  );

  final events =
      isHost ? ZegoUIKitPrebuiltLiveStreamingEvents() : audienceEvents;

  events.onError = (ZegoUIKitError error) {
    // debugPrint('onError:$error');
  };
  events.onStateUpdated = (state) {
    liveStateNotifier.value = state;
  };
  events.beauty = ZegoLiveStreamingBeautyEvents(
    onError: (error) {
      debugPrint('live onBeautyError:$error');
    },
    onFaceDetection: (data) {
      debugPrint('live onBeautyFaceDetection:$data');
    },
  );

  return events;
}

Future<bool> onTurnOnAudienceDeviceConfirmation(
  BuildContext context, {
  required bool isCameraOrMicrophone,
}) async {
  const textStyle = TextStyle(
    fontSize: 10,
    color: Colors.white70,
  );
  const buttonTextStyle = TextStyle(
    fontSize: 10,
    color: Colors.black,
  );
  return await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.blue[900]!.withValues(alpha: 0.9),
        title: Text(
            "You have a request to turn on your ${isCameraOrMicrophone ? "camera" : "microphone"}",
            style: textStyle),
        content: Text(
            "Do you agree to turn on the ${isCameraOrMicrophone ? "camera" : "microphone"}?",
            style: textStyle),
        actions: [
          ElevatedButton(
            child: const Text('Cancel', style: buttonTextStyle),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          ElevatedButton(
            child: const Text('OK', style: buttonTextStyle),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      );
    },
  );
}
