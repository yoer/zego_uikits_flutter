// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:zego_uikit/zego_uikit.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
import 'package:zego_zim_audio/zego_zim_audio.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

// Project imports:
import 'package:zego_uikits_demo/common/avatar.dart';
import 'package:zego_uikits_demo/common/constant.dart';
import 'package:zego_uikits_demo/data/settings.dart';
import 'package:zego_uikits_demo/data/user.dart';
import 'package:zego_uikits_demo/kits/call/utils.dart';
import '../kits/chat/cache.dart';

class ZegoSDKer {
  bool isInit = false;

  Future<void> init() async {
    if (!UserService().isLogin) {
      return;
    }

    if (isInit) {
      return;
    }

    isInit = true;

    ZegoUIKit()
        .getLocalUser()
        .audioRoute
        .addListener(_onLocalAudioRouteChanged);

    final user = UserService().loginUserNotifier.value!;

    try {
      await ZegoUIKit().initLog();

      await _syncZIMAudioConfigToExpressConfigBeforeZIMAudioInit();

      await ZIMKit().init(
        appID: int.parse(SettingsCache().appID),
        appSign: SettingsCache().appSign,
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
      );

      await _syncZIMAudioConfigToExpressConfigAfterZIMAudioInit();

      await ZIMKit().connectUser(
        id: user.id,
        name: user.name,
        avatarUrl: avatarURL(user.id),
      );

      ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);

      ///  [FBI WARING]
      ///  useSystemCallingUI Must be called AFTER zimkit.init!!!
      ///  otherwise the offline handler will be caught by zimkit, resulting in callkit unable to receive the offline handler
      await ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI(
        [ZegoUIKitSignalingPlugin()],
      );
      await initCallInvitation();
    } catch (e) {
      debugPrint('ERROR!!!! init sdk on login failed:$e');
    }
  }

  void uninit() {
    ZegoUIKit()
        .getLocalUser()
        .audioRoute
        .removeListener(_onLocalAudioRouteChanged);

    ZegoUIKit().uninit();

    isInit = false;
  }

  void _onLocalAudioRouteChanged() {
    /// Synchronize the audio route of zim audio, otherwise the two SDKs will compete with each other
    final currentAudioRoute = ZegoUIKit().getLocalUser().audioRoute.value;
    final isSpeaker = currentAudioRoute == ZegoUIKitAudioRoute.speaker;

    debugPrint('sync zim audio route, isSpeaker:$isSpeaker');

    if (isSpeaker) {
      ZIMAudio.getInstance().setAudioRouteType(ZIMAudioRouteType.speaker);
    } else {
      ZIMAudio.getInstance().setAudioRouteType(ZIMAudioRouteType.receiver);
    }
  }

  Future<void> _syncZIMAudioConfigToExpressConfigBeforeZIMAudioInit() async {
    debugPrint('sync zim audio advanced config');

    await ZIMAudio.setAdvancedConfig('audio_session_do_nothing', 'true');
  }

  Future<void> _syncZIMAudioConfigToExpressConfigAfterZIMAudioInit() async {
    debugPrint('sync zim audio advanced config');

    /// Ensure consistency with the RTC SDK configuration and support coexistence of audio sessions
    await ZIMAudio.setAdvancedConfig('audio_session_mix_with_others', 'true');
  }

  ZegoSDKer._internal();

  factory ZegoSDKer() => _instance;

  static final ZegoSDKer _instance = ZegoSDKer._internal();
}
