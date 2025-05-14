// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
import 'package:zego_zimkit/zego_zimkit.dart';
import 'package:zego_uikit/zego_uikit.dart';

// Project imports:
import 'package:zego_uikits_demo/common/avatar.dart';
import 'package:zego_uikits_demo/common/constant.dart';
import 'package:zego_uikits_demo/data/settings.dart';
import 'package:zego_uikits_demo/data/user.dart';
import 'package:zego_uikits_demo/kits/call/cache.dart';
import 'package:zego_uikits_demo/kits/call/utils.dart';

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
          resourceID: CallCache().invitation.resourceID,
          androidNotificationConfig: ZegoZIMKitAndroidNotificationConfig(
            channelName: 'Chat Message',
            sound: 'message',
            icon: 'message',
          ),
        ),
      );
      await ZIMKit().connectUser(
        id: user.id,
        name: user.name,
        avatarUrl: avatarURL(user.id),
      );

      ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);

      ///  [FBI WARING]
      ///  useSystemCallingUI Must be called AFTER zimkit.init!!!
      ///  otherwise the offline handler will be caught by zimkit, resulting in callkit unable to receive the offline handler
      ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI(
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

  ZegoSDKer._internal();

  factory ZegoSDKer() => _instance;

  static final ZegoSDKer _instance = ZegoSDKer._internal();
}
