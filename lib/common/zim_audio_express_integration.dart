// Package imports:
import 'package:zego_uikit/zego_uikit.dart';
import 'package:zego_zim_audio/zego_zim_audio.dart';

/// Coordinates the shared audio session and output route when an app uses both
/// Zego Express (through ZegoUIKit) and ZIM Audio.
///
/// Both SDKs can update iOS's process-wide AVAudioSession. Configure ZIM Audio
/// before its initialization using the same session options as Express. During
/// an RTC room, Express owns the call route; forwarding its route notifications
/// back to ZIM Audio can make the route bounce between receiver and speaker.
/// Outside an RTC room, syncing the route keeps ZIM Audio playback aligned with
/// the user's selected output.
class ZIMAudioExpressIntegration {
  bool _isRouteSyncing = false;

  /// Set these values before the call that initializes ZIM Audio (ZIMKit().init(..)).
  ///
  /// In this demo, `ZIMKit.init` initializes ZIM Audio. The values must match
  /// the corresponding Express configuration; pass the same values configured
  /// by the host app instead of relying on SDK defaults.
  Future<void> configureBeforeZIMAudioInit({
    required bool audioSessionDoNothing,
    required bool audioSessionMixWithOthers,
  }) async {
    ZegoLoggerService.logInfo(
      'configure ZIM Audio session before init, '
      'doNothing:$audioSessionDoNothing, '
      'mixWithOthers:$audioSessionMixWithOthers',
      tag: 'ZIMAudioExpressIntegration',
      subTag: 'AudioConfig',
    );

    await ZIMAudio.setAdvancedConfig(
      'audio_session_do_nothing',
      audioSessionDoNothing.toString(),
    );
    await ZIMAudio.setAdvancedConfig(
      'audio_session_mix_with_others',
      audioSessionMixWithOthers.toString(),
    );
  }

  /// Start syncing Express route changes to ZIM Audio outside RTC rooms.
  ///
  /// Call this after ZIM Audio has initialized and before the app starts
  /// accepting calls. It subscribes to future route changes and immediately
  /// aligns ZIM Audio with the current Express route. Call [dispose] when the
  /// app's SDK integration is torn down.
  void startRouteSync() {
    if (_isRouteSyncing) {
      ZegoLoggerService.logInfo(
        'route sync is already active; skip start',
        tag: 'ZIMAudioExpressIntegration',
        subTag: 'AudioRoute',
      );
      return;
    }

    ZegoUIKit().getLocalUser().audioRoute.addListener(_onAudioRouteChanged);
    _isRouteSyncing = true;
    ZegoLoggerService.logInfo(
      'route sync started',
      tag: 'ZIMAudioExpressIntegration',
      subTag: 'AudioRoute',
    );
    _onAudioRouteChanged();
  }

  /// Stop listening for Express route changes.
  void dispose() {
    if (!_isRouteSyncing) {
      ZegoLoggerService.logInfo(
        'route sync is not active; skip dispose',
        tag: 'ZIMAudioExpressIntegration',
        subTag: 'AudioRoute',
      );
      return;
    }

    ZegoUIKit().getLocalUser().audioRoute.removeListener(_onAudioRouteChanged);
    _isRouteSyncing = false;
    ZegoLoggerService.logInfo(
      'route sync stopped',
      tag: 'ZIMAudioExpressIntegration',
      subTag: 'AudioRoute',
    );
  }

  void _onAudioRouteChanged() {
    if (ZegoUIKit().isRoomLogin) {
      ZegoLoggerService.logInfo(
        'skip ZIM Audio route sync during RTC room',
        tag: 'ZIMAudioExpressIntegration',
        subTag: 'AudioRoute',
      );
      return;
    }

    final isSpeaker = ZegoUIKit().getLocalUser().audioRoute.value ==
        ZegoUIKitAudioRoute.speaker;

    ZegoLoggerService.logInfo(
      'sync ZIM Audio route, isSpeaker:$isSpeaker',
      tag: 'ZIMAudioExpressIntegration',
      subTag: 'AudioRoute',
    );

    ZIMAudio.getInstance().setAudioRouteType(
      isSpeaker ? ZIMAudioRouteType.speaker : ZIMAudioRouteType.receiver,
    );
  }
}
