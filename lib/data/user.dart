// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

// Project imports:
import 'package:zego_uikits_demo/data/zego.dart';
import 'package:zego_uikits_demo/firestore/kits_service.dart';
import 'package:zego_uikits_demo/firestore/user_doc.dart';
import 'package:zego_uikits_demo/kits/call/cache.dart';

class UserInfo {
  String id = '';
  String name = '';

  UserInfo({
    required this.id,
    required this.name,
  });

  bool get isEmpty => id.isEmpty;
}

class UserService {
  final loginUserNotifier = ValueNotifier<UserInfo?>(null);

  final String _cacheUserIDKey = 'cache_user_id_key';
  final String _cacheUserNameKey = 'cache_user_name_key';

  bool get isLogin => null != loginUserNotifier.value;

  Future<bool> tryAutoLogin() async {
    final cacheUser = await getCacheLoginUser();
    if (null == cacheUser) {
      return false;
    }

    return await login(cacheUser);
  }

  Future<bool> login(UserInfo userInfo) async {
    if (userInfo.id == loginUserNotifier.value?.id &&
        userInfo.name == loginUserNotifier.value?.name) {
      return true;
    }

    loginUserNotifier.value = userInfo;

    KitsFirebaseService().userTable.addUser(
          UserDoc(
            id: userInfo.id,
            name: userInfo.name,
            isLogin: true,
          ),
        );
    await _saveLoginUserInfo(userInfo);

    return true;
  }

  Future<void> logout() async {
    final currentLoginUser = loginUserNotifier.value;

    loginUserNotifier.value = null;

    CallCache().invitation.clearHistory();

    await ZIMKit().disconnectUser();
    await ZIMKit().uninit();

    await ZegoUIKitPrebuiltCallInvitationService().uninit();

    await KitsFirebaseService().userTable.updateUserLoginStatus(
          currentLoginUser?.id ?? '',
          false,
        );
    _clearCacheLoginUser();

    ZegoSDKer().uninit();
  }

  Future<UserInfo?> getCacheLoginUser() async {
    final prefs = await SharedPreferences.getInstance();
    final cacheUserID = prefs.get(_cacheUserIDKey) as String? ?? '';
    final cacheUserName = prefs.get(_cacheUserNameKey) as String? ?? '';
    if (cacheUserID.isNotEmpty) {
      return UserInfo(id: cacheUserID, name: cacheUserName);
    }

    return null;
  }

  Future<void> _saveLoginUserInfo(UserInfo userInfo) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_cacheUserIDKey, userInfo.id);
    prefs.setString(_cacheUserNameKey, userInfo.name);
  }

  Future<void> _clearCacheLoginUser() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_cacheUserIDKey);
    prefs.remove(_cacheUserNameKey);
  }

  UserService._internal();

  factory UserService() => _instance;

  static final UserService _instance = UserService._internal();
}
