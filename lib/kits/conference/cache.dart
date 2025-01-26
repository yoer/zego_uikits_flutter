// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

class ConferenceCache {
  final roomIDList = ValueNotifier<List<String>>(
    ConferenceCache.defaultRoomIDList(),
  );

  bool _supportScreenSharing = true;
  bool _videoAspectFill = true;

  bool get videoAspectFill => _videoAspectFill;
  set videoAspectFill(bool value) {
    _videoAspectFill = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_supportVideoModeKey, value);
    });
  }

  bool get supportScreenSharing => _supportScreenSharing;
  set supportScreenSharing(bool value) {
    _supportScreenSharing = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_supportScreenSharingKey, value);
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

  Future<void> clear() async {
    roomIDList.value = ConferenceCache.defaultRoomIDList();

    _supportScreenSharing = true;
    _videoAspectFill = true;

    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_cacheRoomIDListKey);
    prefs.remove(_supportScreenSharingKey);
    prefs.remove(_supportVideoModeKey);
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
        : ConferenceCache.defaultRoomIDList();

    _supportScreenSharing =
        prefs.get(_supportScreenSharingKey) as bool? ?? true;
    _videoAspectFill = prefs.get(_supportVideoModeKey) as bool? ?? true;
  }

  static List<String> defaultRoomIDList() {
    return List<String>.generate(5, (index) => '${100 + index}');
  }

  final String _cacheRoomIDListKey = 'cache_cf_room_id_list';
  final String _supportScreenSharingKey = 'cache_cf_screen_sharing';
  final String _supportVideoModeKey = 'cache_ls_video_mode';

  bool _isLoaded = false;

  ConferenceCache._internal();

  factory ConferenceCache() => _instance;

  static final ConferenceCache _instance = ConferenceCache._internal();
}
