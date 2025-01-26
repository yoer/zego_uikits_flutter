// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

import 'package:zego_uikits_demo/data/assets.dart';

enum AudioRoomLayoutMode {
  defaultLayout,
  full,
  horizontal,
  vertical,
  hostTopCenter,
  hostCenter,
  fourPeoples,
}

class AudioRoomCache {
  final roomIDList = ValueNotifier<List<String>>(
    AudioRoomCache.defaultRoomIDList(),
  );
  bool _showBackground = true;
  bool _showHostInfo = true;
  AudioRoomLayoutMode _layoutMode = AudioRoomLayoutMode.defaultLayout;
  bool _supportScreenSharing = true;
  bool _supportPIP = true;

  String _mediaDefaultURL = '';
  bool _autoPlayMedia = true;

  bool get supportPIP => _supportPIP;
  set supportPIP(bool value) {
    _supportPIP = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_supportPIPKey, value);
    });
  }

  String get mediaDefaultURL => _mediaDefaultURL;
  set mediaDefaultURL(String value) {
    _mediaDefaultURL = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setString(_supportMediaDefURLKey, value);
    });
  }

  bool get autoPlayMedia => _autoPlayMedia;
  set autoPlayMedia(bool value) {
    _autoPlayMedia = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_supportMediaAutoPlayKey, value);
    });
  }

  // bool get supportScreenSharing => _supportScreenSharing;
  // set supportScreenSharing(bool value) {
  //   _supportScreenSharing = value;
  //
  //   SharedPreferences.getInstance().then((prefs) {
  //     prefs.setBool(_supportScreenSharingKey, value);
  //   });
  // }

  bool get showBackground => _showBackground;

  set showBackground(bool value) {
    _showBackground = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_cacheShowBackgroundKey, value);
    });
  }

  bool get showHostInfo => _showHostInfo;

  set showHostInfo(bool value) {
    _showHostInfo = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_cacheShowHostInfoKey, value);
    });
  }

  AudioRoomLayoutMode get layoutMode => _layoutMode;
  set layoutMode(AudioRoomLayoutMode value) {
    _layoutMode = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt(_cacheLayoutModeKey, value.index);
    });
  }

  void addRoomID(String roomID) {
    roomIDList.value = [
      ...roomIDList.value,
      roomID,
    ];

    SharedPreferences.getInstance().then((prefs) {
      prefs.setStringList(_cacheRoomIDListKey, roomIDList.value);
    });
  }

  void removeRoomID(String roomID) {
    final oldValue = roomIDList.value;
    oldValue.removeWhere((e) => e == roomID);
    roomIDList.value = [...oldValue];

    SharedPreferences.getInstance().then((prefs) {
      prefs.setStringList(_cacheRoomIDListKey, roomIDList.value);
    });
  }

  Future<void> load() async {
    if (_isLoaded) {
      return;
    }

    _isLoaded = true;

    final prefs = await SharedPreferences.getInstance();

    final cacheRoomIDList =
        (prefs.get(_cacheRoomIDListKey) as List<Object?>? ?? [])
            .map((e) => e as String)
            .toList();
    roomIDList.value = cacheRoomIDList.isNotEmpty
        ? cacheRoomIDList
        : AudioRoomCache.defaultRoomIDList();

    _showBackground = prefs.get(_cacheShowBackgroundKey) as bool? ?? true;
    _showHostInfo = prefs.get(_cacheShowHostInfoKey) as bool? ?? true;
    _layoutMode =
        AudioRoomLayoutMode.values[prefs.get(_cacheLayoutModeKey) as int? ?? 0];
    _supportScreenSharing =
        prefs.get(_supportScreenSharingKey) as bool? ?? true;
    _supportPIP = prefs.get(_supportPIPKey) as bool? ?? true;

    _autoPlayMedia = prefs.get(_supportMediaAutoPlayKey) as bool? ?? true;
    _mediaDefaultURL =
        prefs.get(_supportMediaDefURLKey) as String? ?? defaultMediaURL;
  }

  Future<void> clear() async {
    roomIDList.value = AudioRoomCache.defaultRoomIDList();

    _showBackground = true;
    _showHostInfo = true;
    _layoutMode = AudioRoomLayoutMode.defaultLayout;
    _supportScreenSharing = true;
    _supportPIP = true;

    _mediaDefaultURL = '';
    _autoPlayMedia = true;

    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_cacheRoomIDListKey);
    prefs.remove(_cacheShowBackgroundKey);
    prefs.remove(_cacheShowHostInfoKey);
    prefs.remove(_cacheLayoutModeKey);
    prefs.remove(_supportScreenSharingKey);
    prefs.remove(_supportPIPKey);

    prefs.remove(_supportMediaDefURLKey);
    prefs.remove(_supportMediaAutoPlayKey);
  }

  static List<String> defaultRoomIDList() {
    return List<String>.generate(5, (index) => '${100 + index}');
  }

  AudioRoomCache._internal();
  bool _isLoaded = false;

  factory AudioRoomCache() => _instance;

  static final AudioRoomCache _instance = AudioRoomCache._internal();

  final String _cacheRoomIDListKey = 'cache_ar_room_id_list';
  final String _cacheShowBackgroundKey = 'cache_ar_show_bg';
  final String _cacheShowHostInfoKey = 'cache_ar_show_host_info';
  final String _cacheLayoutModeKey = 'cache_ar_layout_mode';
  final String _supportScreenSharingKey = 'cache_ar_screen_sharing';
  final String _supportPIPKey = 'cache_ar_pip';

  final String _supportMediaDefURLKey = 'cache_ar_media_def_url';
  final String _supportMediaAutoPlayKey = 'cache_ar_media_auto_play';
}
