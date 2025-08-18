// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

class SettingsCache {
  bool _isLoaded = false;

  String appID = '';
  String appSign = '';
  String appToken = '';

  bool _useFirestore = true;
  bool _showSplash = true;

  bool get isAppKeyValid =>
      appID.isNotEmpty && (appSign.isNotEmpty || appToken.isNotEmpty);

  bool get useFirestore => _useFirestore;

  set useFirestore(bool value) {
    _useFirestore = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_cacheUseFirestoreKey, value);
    });
  }

  bool get showSplash => _showSplash;

  set showSplash(bool value) {
    _showSplash = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_cacheShowSplashKey, value);
    });
  }

  Future<void> load() async {
    if (_isLoaded) {
      return;
    }
    _isLoaded = true;

    final prefs = await SharedPreferences.getInstance();
    appID = prefs.get(_cacheAppIDKey) as String? ?? '';
    appSign = prefs.get(_cacheAppSignKey) as String? ?? '';
    appToken = prefs.get(_cacheAppTokenKey) as String? ?? '';

    _showSplash = prefs.get(_cacheShowSplashKey) as bool? ?? true;
    _useFirestore = prefs.get(_cacheUseFirestoreKey) as bool? ?? true;
  }

  Future<void> saveAppKey({
    required String appID,
    required String appSign,
    required String appToken,
  }) async {
    this.appID = appID;
    this.appSign = appSign;
    this.appToken = appToken;

    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_cacheAppIDKey, appID);
    prefs.setString(_cacheAppSignKey, appSign);
    prefs.setString(_cacheAppTokenKey, appToken);
  }

  Future<void> clear() async {
    appID = '';
    appSign = '';
    appToken = '';

    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_cacheAppIDKey);
    prefs.remove(_cacheAppSignKey);
    prefs.remove(_cacheAppTokenKey);
  }

  final String _cacheAppIDKey = 'cache_app_id_key';
  final String _cacheAppSignKey = 'cache_app_sign_key';
  final String _cacheAppTokenKey = 'cache_app_token_key';
  final String _cacheShowSplashKey = 'cache_show_splash_key';
  final String _cacheUseFirestoreKey = 'cache_use_firestore_key';

  SettingsCache._internal();

  factory SettingsCache() => _instance;

  static final SettingsCache _instance = SettingsCache._internal();
}
