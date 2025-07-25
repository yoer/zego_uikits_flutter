// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:zego_uikits_demo/data/assets.dart';

class KitCommonCache {
  bool _supportScreenSharing = true;
  bool _supportPIP = true;
  bool _supportAdvanceBeauty = true;

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
  }

  Future<void> clear() async {
    _supportScreenSharing = true;
    _supportPIP = true;
    _supportAdvanceBeauty = true;

    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_supportScreenSharingKey);
    prefs.remove(_supportPIPKey);
    prefs.remove(_supportPIPKey);
  }

  KitCommonCache._internal();
  bool _isLoaded = false;

  factory KitCommonCache() => _instance;

  static final KitCommonCache _instance = KitCommonCache._internal();

  final String _supportScreenSharingKey = 'cache_kit_screen_sharing';
  final String _supportPIPKey = 'cache_kit_pip';
  final String _supportAdvanceBeautyKey = 'cache_kit_advance_beauty';
}
