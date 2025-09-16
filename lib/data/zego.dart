// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:zego_uikit/zego_uikit.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
import 'package:zego_zimkit/zego_zimkit.dart';
import 'package:zego_zim_audio/zego_zim_audio.dart';

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

    final user = UserService().loginUserNotifier.value!;

    try {
      await ZegoUIKit().initLog();

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

      /// Set the following three configs before initializing ZIMAudio
      _syncZIMAudioConfigToExpressConfig();
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
    ZegoUIKit().uninit();

    isInit = false;
  }

  void _syncZIMAudioConfigToExpressConfig() {
    /// Ensure consistency with the RTC SDK configuration and support coexistence of audio sessions
    ZIMAudio.setAdvancedConfig('audio_session_mix_with_others', 'true');

    /// Ensure consistency with the RTC SDK configuration to avoid the RTC SDK repeatedly modifying options
    ZIMAudio.setAdvancedConfig('bluetooth_capture_only_voip', 'true');

    ///After ZIMAudio is deinitialized, the audio session is not deactivated
    ZIMAudio.setAdvancedConfig('audio_session_do_nothing', 'true');
  }

  ZegoSDKer._internal();

  factory ZegoSDKer() => _instance;

  static final ZegoSDKer _instance = ZegoSDKer._internal();
}
