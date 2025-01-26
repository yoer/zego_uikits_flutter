// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

import 'package:zego_uikits_demo/data/assets.dart';

class LiveStreamingCache {
  final roomIDList = ValueNotifier<List<String>>(
    LiveStreamingCache.defaultRoomIDList(),
  );
  final liveListMap = ValueNotifier<Map<String, String>>({});
  bool _liveListHorizontal = false;
  int _liveListAxisCount = 2;

  bool _pkAutoAccept = false;

  String _mediaDefaultURL = '';
  bool _autoPlayMedia = true;

  bool _supportScreenSharing = true;
  bool _supportPIP = true;
  bool _supportGift = true;
  bool _supportAdvanceBeauty = true;
  bool _videoAspectFill = true;
  bool _showUserNameOnView = true;
  bool _showMicrophoneStateOnView = true;

  bool get showMicrophoneStateOnView => _showMicrophoneStateOnView;
  set showMicrophoneStateOnView(bool value) {
    _showMicrophoneStateOnView = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_supportShowMicStateKey, value);
    });
  }

  bool get showUserNameOnView => _showUserNameOnView;
  set showUserNameOnView(bool value) {
    _showUserNameOnView = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_supportShowUserNameKey, value);
    });
  }

  bool get supportAdvanceBeauty => _supportAdvanceBeauty;
  set supportAdvanceBeauty(bool value) {
    _supportAdvanceBeauty = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_supportAdvanceBeautyKey, value);
    });
  }

  bool get videoAspectFill => _videoAspectFill;
  set videoAspectFill(bool value) {
    _videoAspectFill = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_supportVideoModeKey, value);
    });
  }

  bool get supportGift => _supportGift;
  set supportGift(bool value) {
    _supportGift = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_supportGiftKey, value);
    });
  }

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

  void addLiveList(String hostID, String liveID) {
    final currentValue = Map<String, String>.from(liveListMap.value);
    currentValue[hostID] = liveID;
    liveListMap.value = currentValue;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setString(_cacheLiveListMapKey, jsonEncode(liveListMap.value));
    });
  }

  void updateLiveList(String hostID, String liveID) {
    final currentValue = Map<String, String>.from(liveListMap.value);
    currentValue[hostID] = liveID;
    liveListMap.value = currentValue;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setString(_cacheLiveListMapKey, jsonEncode(liveListMap.value));
    });
  }

  void removeLiveList(String hostID) {
    final currentValue = Map<String, String>.from(liveListMap.value);
    currentValue.removeWhere((k, v) => k == hostID);
    liveListMap.value = currentValue;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setString(_cacheLiveListMapKey, jsonEncode(liveListMap.value));
    });
  }

  bool get liveListHorizontal => _liveListHorizontal;
  set liveListHorizontal(bool value) {
    _liveListHorizontal = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_cacheLiveListAxisKey, value);
    });
  }

  int get liveListAxisCount => _liveListAxisCount;
  set liveListAxisCount(int value) {
    _liveListAxisCount = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt(_cacheLiveListAxisCountKey, value);
    });
  }

  bool get pkAutoAccept => _pkAutoAccept;
  set pkAutoAccept(bool value) {
    pkAutoAccept = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_cachePKAutoAcceptKey, value);
    });
  }

  Future<void> clear() async {
    roomIDList.value = LiveStreamingCache.defaultRoomIDList();
    liveListMap.value = {};

    _liveListHorizontal = false;
    _liveListAxisCount = 2;

    _pkAutoAccept = false;

    _mediaDefaultURL = '';
    _autoPlayMedia = true;

    _supportScreenSharing = true;
    _supportPIP = true;
    _supportGift = true;
    _supportAdvanceBeauty = true;
    _videoAspectFill = true;
    _showUserNameOnView = true;
    _showMicrophoneStateOnView = true;

    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_cacheRoomIDListKey);
    prefs.remove(_cacheLiveListMapKey);
    prefs.remove(_cacheLiveListAxisKey);
    prefs.remove(_cacheLiveListAxisCountKey);

    prefs.remove(_cachePKAutoAcceptKey);

    prefs.remove(_supportScreenSharingKey);
    prefs.remove(_supportAdvanceBeautyKey);
    prefs.remove(_supportShowUserNameKey);
    prefs.remove(_supportShowMicStateKey);
    prefs.remove(_supportMediaDefURLKey);
    prefs.remove(_supportMediaAutoPlayKey);
    prefs.remove(_supportVideoModeKey);
    prefs.remove(_supportPIPKey);
    prefs.remove(_supportGiftKey);
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
        : LiveStreamingCache.defaultRoomIDList();

    _liveListHorizontal = prefs.get(_cacheLiveListAxisKey) as bool? ?? false;
    _liveListAxisCount = prefs.get(_cacheLiveListAxisCountKey) as int? ?? 2;

    final liveListMapJson = prefs.get(_cacheLiveListMapKey) as String? ?? '';
    try {
      liveListMap.value = Map<String, String>.from(jsonDecode(liveListMapJson));
    } catch (e) {}

    _pkAutoAccept = prefs.get(_cachePKAutoAcceptKey) as bool? ?? false;

    _autoPlayMedia = prefs.get(_supportMediaAutoPlayKey) as bool? ?? true;
    _mediaDefaultURL =
        prefs.get(_supportMediaDefURLKey) as String? ?? defaultMediaURL;

    _supportScreenSharing =
        prefs.get(_supportScreenSharingKey) as bool? ?? true;
    _supportPIP = prefs.get(_supportPIPKey) as bool? ?? true;
    _supportGift = prefs.get(_supportGiftKey) as bool? ?? true;
    _supportAdvanceBeauty =
        prefs.get(_supportAdvanceBeautyKey) as bool? ?? true;
    _videoAspectFill = prefs.get(_supportVideoModeKey) as bool? ?? true;
    _showMicrophoneStateOnView =
        prefs.get(_supportShowMicStateKey) as bool? ?? true;
    _showUserNameOnView = prefs.get(_supportShowUserNameKey) as bool? ?? true;
  }

  static List<String> defaultRoomIDList() {
    return List<String>.generate(5, (index) => '${100 + index}');
  }

  final String _cacheRoomIDListKey = 'cache_ls_room_id_list';
  final String _cacheLiveListMapKey = 'cache_ls_live_list_map';
  final String _cacheLiveListAxisKey = 'cache_ls_live_list_axis';
  final String _cacheLiveListAxisCountKey = 'cache_ls_live_list_axis_count';

  final String _cachePKAutoAcceptKey = 'cache_ls_pk_auto_accept';

  final String _supportScreenSharingKey = 'cache_ls_screen_sharing';
  final String _supportAdvanceBeautyKey = 'cache_ls_advance_beauty';
  final String _supportShowUserNameKey = 'cache_ls_show_user_name';
  final String _supportShowMicStateKey = 'cache_ls_show_mic_state';

  final String _supportMediaDefURLKey = 'cache_ls_media_def_url';
  final String _supportMediaAutoPlayKey = 'cache_ls_media_auto_play';

  final String _supportVideoModeKey = 'cache_ls_video_mode';
  final String _supportPIPKey = 'cache_ls_pip';
  final String _supportGiftKey = 'cache_ls_gift';

  bool _isLoaded = false;

  LiveStreamingCache._internal();

  factory LiveStreamingCache() => _instance;

  static final LiveStreamingCache _instance = LiveStreamingCache._internal();
}
