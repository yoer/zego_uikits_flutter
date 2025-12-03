// Package imports:
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zego_uikit/zego_uikit.dart';

class KitCommonCache {
  bool _supportScreenSharing = true;
  bool _supportPIP = true;
  bool _supportAdvanceBeauty = true;
  bool _enableDebugToast = false;
  bool _enableDebugMode = false;

  bool get supportPIP {
    return _supportPIP;
  }

  set supportPIP(bool value) {
    _supportPIP = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_supportPIPKey, value);
    });
  }

  bool get supportScreenSharing => _supportScreenSharing;

  set supportScreenSharing(bool value) {
    _supportScreenSharing = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_supportScreenSharingKey, value);
    });
  }

  bool get supportAdvanceBeauty => _supportAdvanceBeauty;

  set supportAdvanceBeauty(bool value) {
    _supportAdvanceBeauty = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_supportAdvanceBeautyKey, value);
    });
  }

  bool get enableDebugToast => _enableDebugToast;

  set enableDebugToast(bool value) {
    _enableDebugToast = value;

    ZegoUIKit().useDebugMode = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_enableDebugToastKey, value);
    });
  }

  bool get enableDebugMode => _enableDebugMode;

  set enableDebugMode(bool value) {
    _enableDebugMode = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_enableDebugModeKey, value);
    });
  }

  Future<void> load() async {
    if (_isLoaded) {
      return;
    }

    _isLoaded = true;

    final prefs = await SharedPreferences.getInstance();

    _supportScreenSharing =
        prefs.get(_supportScreenSharingKey) as bool? ?? true;
    _supportPIP = prefs.get(_supportPIPKey) as bool? ?? true;
    _supportAdvanceBeauty =
        prefs.get(_supportAdvanceBeautyKey) as bool? ?? true;
    _enableDebugToast = prefs.get(_enableDebugToastKey) as bool? ?? false;

    _enableDebugMode = prefs.get(_enableDebugModeKey) as bool? ?? false;
    ZegoUIKit().useDebugMode = _enableDebugMode;
  }

  Future<void> clear() async {
    _supportScreenSharing = true;
    _supportPIP = true;
    _supportAdvanceBeauty = true;
    _enableDebugToast = false;

    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_supportScreenSharingKey);
    prefs.remove(_supportPIPKey);
    prefs.remove(_supportAdvanceBeautyKey);
    prefs.remove(_enableDebugToastKey);
    prefs.remove(_enableDebugModeKey);
  }

  KitCommonCache._internal();

  bool _isLoaded = false;

  factory KitCommonCache() => _instance;

  static final KitCommonCache _instance = KitCommonCache._internal();

  final String _supportScreenSharingKey = 'cache_kit_screen_sharing';
  final String _supportPIPKey = 'cache_kit_pip';
  final String _supportAdvanceBeautyKey = 'cache_kit_advance_beauty';
  final String _enableDebugToastKey = 'cache_kit_enable_debug_toast';
  final String _enableDebugModeKey = 'cache_kit_enable_debug_mode';
}
