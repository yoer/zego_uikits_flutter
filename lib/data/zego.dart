// Package imports:
import 'package:zego_uikit/zego_uikit.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

// Project imports:
import 'package:zego_uikits_demo/common/avatar.dart';
import 'package:zego_uikits_demo/common/constant.dart';
import 'package:zego_uikits_demo/common/zim_audio_express_integration.dart';
import 'package:zego_uikits_demo/data/settings.dart';
import 'package:zego_uikits_demo/data/user.dart';
import 'package:zego_uikits_demo/kits/call/utils.dart';

import '../kits/chat/cache.dart';

class ZegoSDKer {
  bool isInit = false;

  // Owns the route-listener state. Reuse this instance so teardown removes
  // the same listener that was registered during initialization.
  final ZIMAudioExpressIntegration _audioIntegration =
      ZIMAudioExpressIntegration();

  Future<void> init() async {
    if (!UserService().isLogin) {
      return;
    }

    if (isInit) {
      return;
    }

    isInit = true;

    final user = UserService().loginUserNotifier.value!;

    try {
      await ZegoUIKit().initLog();

      // ZIMKit.init initializes ZIM Audio, so configure the shared audio-session
      // options first. Keep these values aligned with the host's Express setup.
      await _audioIntegration.configureBeforeZIMAudioInit(
        audioSessionDoNothing: true,
        audioSessionMixWithOthers: true,
      );

      await ZIMKit().init(
        appID: int.parse(SettingsCache().appID),
        appSign: SettingsCache().appSign,
        config: ZIMKitConfig(
          inputConfig: ZIMKitInputConfig(
            expandButtons: const [
              ZIMKitInputButtonName.takePhoto,
              ZIMKitInputButtonName.file,
              ZIMKitInputButtonName.voiceCall,
              ZIMKitInputButtonName.videoCall,
            ],
          ),
          notificationConfig: ZegoZIMKitNotificationConfig(
            resourceID: ChatCache().resourceID,
            androidNotificationConfig: ZegoZIMKitAndroidNotificationConfig(
              channelID: "zimkit_message",
              channelName: 'Chat Message',
              sound: 'message',
              icon: 'message',
              enable: false,
            ),
          ),
        ),
      );

      // ZIM Audio is initialized, so route synchronization can start. The
      // integration skips writes during RTC rooms, leaving call routing to Express.
      _audioIntegration.startRouteSync();

      await ZIMKit().connectUser(
        id: user.id,
        name: user.name,
        avatarUrl: avatarURL(user.id),
        token: SettingsCache().appToken,
      );

      ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);

      ///  [FBI WARING]
      ///  useSystemCallingUI Must be called AFTER zimkit.init!!!
      ///  otherwise the offline handler will be caught by zimkit, resulting in callkit unable to receive the offline handler
      await ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI([
        ZegoUIKitSignalingPlugin(),
      ]);
      await initCallInvitation();
    } catch (e) {
      await _cleanupAfterInitFailure();
      ZegoLoggerService.logError(
        'ERROR!!!! init sdk on login failed:$e',
        tag: 'ZegoSDKer',
        subTag: 'Init',
      );
    }
  }

  void uninit() {
    // Remove the listener before releasing the SDK to avoid callbacks afterward.
    _audioIntegration.dispose();

    ZegoUIKit().uninit();

    isInit = false;
  }

  Future<void> _cleanupAfterInitFailure() async {
    // Remove the listener on partial initialization too, then release initialized SDKs.
    _audioIntegration.dispose();

    var cleanupSucceeded = true;

    try {
      await ZIMKit().uninit();
    } catch (e) {
      cleanupSucceeded = false;
      ZegoLoggerService.logError(
        'failed to uninit ZIMKit after init failure:$e',
        tag: 'ZegoSDKer',
        subTag: 'Init',
      );
    }

    try {
      await ZegoUIKitPrebuiltCallInvitationService().uninit();
    } catch (e) {
      cleanupSucceeded = false;
      ZegoLoggerService.logError(
        'failed to uninit call invitation service after init failure:$e',
        tag: 'ZegoSDKer',
        subTag: 'Init',
      );
    }

    try {
      await ZegoUIKit().uninit();
    } catch (e) {
      cleanupSucceeded = false;
      ZegoLoggerService.logError(
        'failed to uninit ZegoUIKit after init failure:$e',
        tag: 'ZegoSDKer',
        subTag: 'Init',
      );
    }

    if (cleanupSucceeded) {
      isInit = false;
    }
  }

  ZegoSDKer._internal();

  factory ZegoSDKer() => _instance;

  static final ZegoSDKer _instance = ZegoSDKer._internal();
}
