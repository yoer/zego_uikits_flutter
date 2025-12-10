// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
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

  String _mediaDefaultURL = '';
  bool _autoPlayMedia = true;

  // Basic configurations
  bool _turnOnMicrophoneWhenJoining = true;
  bool _useSpeakerWhenJoining = true;
  bool _rootNavigator = false;

  // Seat configurations
  bool _seatCloseWhenJoining = true;
  bool _seatShowSoundWaveInAudioMode = true;
  bool _seatKeepOriginalForeground = false;

  // BottomMenuBar configurations
  bool _bottomMenuBarVisible = true;
  bool _bottomMenuBarShowInRoomMessageButton = true;
  int _bottomMenuBarMaxCount = 5;

  // InRoomMessage configurations
  bool _inRoomMessageVisible = true;
  double? _inRoomMessageWidth;
  double? _inRoomMessageHeight;
  bool _inRoomMessageShowName = true;
  bool _inRoomMessageShowAvatar = true;
  double _inRoomMessageOpacity = 0.5;

  // Duration configurations
  bool _durationIsVisible = true;

  // PIP configurations
  int _pipAspectWidth = 1;
  int _pipAspectHeight = 1;
  bool _pipEnableWhenBackground = true;
  bool _pipAndroidShowUserName = true;

  // MediaPlayer configurations
  bool _mediaPlayerSupportTransparent = false;
  bool _mediaPlayerDefaultPlayerSupport = false;

  // BackgroundMedia configurations
  String? _backgroundMediaPath;
  bool _backgroundMediaEnableRepeat = true;

  // SignalingPlugin configurations
  bool _signalingPluginLeaveRoomOnDispose = true;
  bool _signalingPluginUninitOnDispose = true;

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

  // Basic configurations
  bool get turnOnMicrophoneWhenJoining => _turnOnMicrophoneWhenJoining;
  set turnOnMicrophoneWhenJoining(bool value) {
    _turnOnMicrophoneWhenJoining = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_turnOnMicrophoneWhenJoiningKey, value);
    });
  }

  bool get useSpeakerWhenJoining => _useSpeakerWhenJoining;
  set useSpeakerWhenJoining(bool value) {
    _useSpeakerWhenJoining = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_useSpeakerWhenJoiningKey, value);
    });
  }

  bool get rootNavigator => _rootNavigator;
  set rootNavigator(bool value) {
    _rootNavigator = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_rootNavigatorKey, value);
    });
  }

  // Seat configurations
  bool get seatCloseWhenJoining => _seatCloseWhenJoining;
  set seatCloseWhenJoining(bool value) {
    _seatCloseWhenJoining = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_seatCloseWhenJoiningKey, value);
    });
  }

  bool get seatShowSoundWaveInAudioMode => _seatShowSoundWaveInAudioMode;
  set seatShowSoundWaveInAudioMode(bool value) {
    _seatShowSoundWaveInAudioMode = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_seatShowSoundWaveInAudioModeKey, value);
    });
  }

  bool get seatKeepOriginalForeground => _seatKeepOriginalForeground;
  set seatKeepOriginalForeground(bool value) {
    _seatKeepOriginalForeground = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_seatKeepOriginalForegroundKey, value);
    });
  }

  // BottomMenuBar configurations
  bool get bottomMenuBarVisible => _bottomMenuBarVisible;
  set bottomMenuBarVisible(bool value) {
    _bottomMenuBarVisible = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_bottomMenuBarVisibleKey, value);
    });
  }

  bool get bottomMenuBarShowInRoomMessageButton =>
      _bottomMenuBarShowInRoomMessageButton;
  set bottomMenuBarShowInRoomMessageButton(bool value) {
    _bottomMenuBarShowInRoomMessageButton = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_bottomMenuBarShowInRoomMessageButtonKey, value);
    });
  }

  int get bottomMenuBarMaxCount => _bottomMenuBarMaxCount;
  set bottomMenuBarMaxCount(int value) {
    _bottomMenuBarMaxCount = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt(_bottomMenuBarMaxCountKey, value);
    });
  }

  // InRoomMessage configurations
  bool get inRoomMessageVisible => _inRoomMessageVisible;
  set inRoomMessageVisible(bool value) {
    _inRoomMessageVisible = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_inRoomMessageVisibleKey, value);
    });
  }

  double? get inRoomMessageWidth => _inRoomMessageWidth;
  set inRoomMessageWidth(double? value) {
    _inRoomMessageWidth = value;
    SharedPreferences.getInstance().then((prefs) {
      if (value != null) {
        prefs.setDouble(_inRoomMessageWidthKey, value);
      } else {
        prefs.remove(_inRoomMessageWidthKey);
      }
    });
  }

  double? get inRoomMessageHeight => _inRoomMessageHeight;
  set inRoomMessageHeight(double? value) {
    _inRoomMessageHeight = value;
    SharedPreferences.getInstance().then((prefs) {
      if (value != null) {
        prefs.setDouble(_inRoomMessageHeightKey, value);
      } else {
        prefs.remove(_inRoomMessageHeightKey);
      }
    });
  }

  bool get inRoomMessageShowName => _inRoomMessageShowName;
  set inRoomMessageShowName(bool value) {
    _inRoomMessageShowName = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_inRoomMessageShowNameKey, value);
    });
  }

  bool get inRoomMessageShowAvatar => _inRoomMessageShowAvatar;
  set inRoomMessageShowAvatar(bool value) {
    _inRoomMessageShowAvatar = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_inRoomMessageShowAvatarKey, value);
    });
  }

  double get inRoomMessageOpacity => _inRoomMessageOpacity;
  set inRoomMessageOpacity(double value) {
    _inRoomMessageOpacity = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setDouble(_inRoomMessageOpacityKey, value);
    });
  }

  // Duration configurations
  bool get durationIsVisible => _durationIsVisible;
  set durationIsVisible(bool value) {
    _durationIsVisible = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_durationIsVisibleKey, value);
    });
  }

  // PIP configurations
  int get pipAspectWidth => _pipAspectWidth;
  set pipAspectWidth(int value) {
    _pipAspectWidth = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt(_pipAspectWidthKey, value);
    });
  }

  int get pipAspectHeight => _pipAspectHeight;
  set pipAspectHeight(int value) {
    _pipAspectHeight = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt(_pipAspectHeightKey, value);
    });
  }

  bool get pipEnableWhenBackground => _pipEnableWhenBackground;
  set pipEnableWhenBackground(bool value) {
    _pipEnableWhenBackground = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_pipEnableWhenBackgroundKey, value);
    });
  }

  bool get pipAndroidShowUserName => _pipAndroidShowUserName;
  set pipAndroidShowUserName(bool value) {
    _pipAndroidShowUserName = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_pipAndroidShowUserNameKey, value);
    });
  }

  // MediaPlayer configurations
  bool get mediaPlayerSupportTransparent => _mediaPlayerSupportTransparent;
  set mediaPlayerSupportTransparent(bool value) {
    _mediaPlayerSupportTransparent = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_mediaPlayerSupportTransparentKey, value);
    });
  }

  bool get mediaPlayerDefaultPlayerSupport => _mediaPlayerDefaultPlayerSupport;
  set mediaPlayerDefaultPlayerSupport(bool value) {
    _mediaPlayerDefaultPlayerSupport = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_mediaPlayerDefaultPlayerSupportKey, value);
    });
  }

  // BackgroundMedia configurations
  String? get backgroundMediaPath => _backgroundMediaPath;
  set backgroundMediaPath(String? value) {
    _backgroundMediaPath = value;
    SharedPreferences.getInstance().then((prefs) {
      if (value != null) {
        prefs.setString(_backgroundMediaPathKey, value);
      } else {
        prefs.remove(_backgroundMediaPathKey);
      }
    });
  }

  bool get backgroundMediaEnableRepeat => _backgroundMediaEnableRepeat;
  set backgroundMediaEnableRepeat(bool value) {
    _backgroundMediaEnableRepeat = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_backgroundMediaEnableRepeatKey, value);
    });
  }

  // SignalingPlugin configurations
  bool get signalingPluginLeaveRoomOnDispose =>
      _signalingPluginLeaveRoomOnDispose;
  set signalingPluginLeaveRoomOnDispose(bool value) {
    _signalingPluginLeaveRoomOnDispose = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_signalingPluginLeaveRoomOnDisposeKey, value);
    });
  }

  bool get signalingPluginUninitOnDispose => _signalingPluginUninitOnDispose;
  set signalingPluginUninitOnDispose(bool value) {
    _signalingPluginUninitOnDispose = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_signalingPluginUninitOnDisposeKey, value);
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

    _autoPlayMedia = prefs.get(_supportMediaAutoPlayKey) as bool? ?? true;
    _mediaDefaultURL =
        prefs.get(_supportMediaDefURLKey) as String? ?? defaultMediaURL;

    // Load new configurations
    _turnOnMicrophoneWhenJoining =
        prefs.get(_turnOnMicrophoneWhenJoiningKey) as bool? ?? true;
    _useSpeakerWhenJoining =
        prefs.get(_useSpeakerWhenJoiningKey) as bool? ?? true;
    _rootNavigator = prefs.get(_rootNavigatorKey) as bool? ?? false;
    _seatCloseWhenJoining =
        prefs.get(_seatCloseWhenJoiningKey) as bool? ?? true;
    _seatShowSoundWaveInAudioMode =
        prefs.get(_seatShowSoundWaveInAudioModeKey) as bool? ?? true;
    _seatKeepOriginalForeground =
        prefs.get(_seatKeepOriginalForegroundKey) as bool? ?? false;
    _bottomMenuBarVisible =
        prefs.get(_bottomMenuBarVisibleKey) as bool? ?? true;
    _bottomMenuBarShowInRoomMessageButton =
        prefs.get(_bottomMenuBarShowInRoomMessageButtonKey) as bool? ?? true;
    _bottomMenuBarMaxCount = prefs.get(_bottomMenuBarMaxCountKey) as int? ?? 5;
    _inRoomMessageVisible =
        prefs.get(_inRoomMessageVisibleKey) as bool? ?? true;
    _inRoomMessageWidth = prefs.get(_inRoomMessageWidthKey) as double?;
    _inRoomMessageHeight = prefs.get(_inRoomMessageHeightKey) as double?;
    _inRoomMessageShowName =
        prefs.get(_inRoomMessageShowNameKey) as bool? ?? true;
    _inRoomMessageShowAvatar =
        prefs.get(_inRoomMessageShowAvatarKey) as bool? ?? true;
    _inRoomMessageOpacity =
        prefs.get(_inRoomMessageOpacityKey) as double? ?? 0.5;
    _durationIsVisible = prefs.get(_durationIsVisibleKey) as bool? ?? true;
    _pipAspectWidth = prefs.get(_pipAspectWidthKey) as int? ?? 1;
    _pipAspectHeight = prefs.get(_pipAspectHeightKey) as int? ?? 1;
    _pipEnableWhenBackground =
        prefs.get(_pipEnableWhenBackgroundKey) as bool? ?? true;
    _pipAndroidShowUserName =
        prefs.get(_pipAndroidShowUserNameKey) as bool? ?? true;
    _mediaPlayerSupportTransparent =
        prefs.get(_mediaPlayerSupportTransparentKey) as bool? ?? false;
    _mediaPlayerDefaultPlayerSupport =
        prefs.get(_mediaPlayerDefaultPlayerSupportKey) as bool? ?? false;
    _backgroundMediaPath = prefs.get(_backgroundMediaPathKey) as String?;
    _backgroundMediaEnableRepeat =
        prefs.get(_backgroundMediaEnableRepeatKey) as bool? ?? true;
    _signalingPluginLeaveRoomOnDispose =
        prefs.get(_signalingPluginLeaveRoomOnDisposeKey) as bool? ?? true;
    _signalingPluginUninitOnDispose =
        prefs.get(_signalingPluginUninitOnDisposeKey) as bool? ?? true;
  }

  Future<void> clear() async {
    roomIDList.value = AudioRoomCache.defaultRoomIDList();

    _showBackground = true;
    _showHostInfo = true;
    _layoutMode = AudioRoomLayoutMode.defaultLayout;

    _mediaDefaultURL = '';
    _autoPlayMedia = true;

    // Reset new configurations
    _turnOnMicrophoneWhenJoining = true;
    _useSpeakerWhenJoining = true;
    _rootNavigator = false;
    _seatCloseWhenJoining = true;
    _seatShowSoundWaveInAudioMode = true;
    _seatKeepOriginalForeground = false;
    _bottomMenuBarVisible = true;
    _bottomMenuBarShowInRoomMessageButton = true;
    _bottomMenuBarMaxCount = 5;
    _inRoomMessageVisible = true;
    _inRoomMessageWidth = null;
    _inRoomMessageHeight = null;
    _inRoomMessageShowName = true;
    _inRoomMessageShowAvatar = true;
    _inRoomMessageOpacity = 0.5;
    _durationIsVisible = true;
    _pipAspectWidth = 1;
    _pipAspectHeight = 1;
    _pipEnableWhenBackground = true;
    _pipAndroidShowUserName = true;
    _mediaPlayerSupportTransparent = false;
    _mediaPlayerDefaultPlayerSupport = false;
    _backgroundMediaPath = null;
    _backgroundMediaEnableRepeat = true;
    _signalingPluginLeaveRoomOnDispose = true;
    _signalingPluginUninitOnDispose = true;

    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_cacheRoomIDListKey);
    prefs.remove(_cacheShowBackgroundKey);
    prefs.remove(_cacheShowHostInfoKey);
    prefs.remove(_cacheLayoutModeKey);

    prefs.remove(_supportMediaDefURLKey);
    prefs.remove(_supportMediaAutoPlayKey);

    // Remove new keys
    prefs.remove(_turnOnMicrophoneWhenJoiningKey);
    prefs.remove(_useSpeakerWhenJoiningKey);
    prefs.remove(_rootNavigatorKey);
    prefs.remove(_seatCloseWhenJoiningKey);
    prefs.remove(_seatShowSoundWaveInAudioModeKey);
    prefs.remove(_seatKeepOriginalForegroundKey);
    prefs.remove(_bottomMenuBarVisibleKey);
    prefs.remove(_bottomMenuBarShowInRoomMessageButtonKey);
    prefs.remove(_bottomMenuBarMaxCountKey);
    prefs.remove(_inRoomMessageVisibleKey);
    prefs.remove(_inRoomMessageWidthKey);
    prefs.remove(_inRoomMessageHeightKey);
    prefs.remove(_inRoomMessageShowNameKey);
    prefs.remove(_inRoomMessageShowAvatarKey);
    prefs.remove(_inRoomMessageOpacityKey);
    prefs.remove(_durationIsVisibleKey);
    prefs.remove(_pipAspectWidthKey);
    prefs.remove(_pipAspectHeightKey);
    prefs.remove(_pipEnableWhenBackgroundKey);
    prefs.remove(_pipAndroidShowUserNameKey);
    prefs.remove(_mediaPlayerSupportTransparentKey);
    prefs.remove(_mediaPlayerDefaultPlayerSupportKey);
    prefs.remove(_backgroundMediaPathKey);
    prefs.remove(_backgroundMediaEnableRepeatKey);
    prefs.remove(_signalingPluginLeaveRoomOnDisposeKey);
    prefs.remove(_signalingPluginUninitOnDisposeKey);
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

  final String _supportMediaDefURLKey = 'cache_ar_media_def_url';
  final String _supportMediaAutoPlayKey = 'cache_ar_media_auto_play';

  // New keys
  final String _turnOnMicrophoneWhenJoiningKey =
      'cache_ar_turn_on_microphone_when_joining';
  final String _useSpeakerWhenJoiningKey = 'cache_ar_use_speaker_when_joining';
  final String _rootNavigatorKey = 'cache_ar_root_navigator';
  final String _seatCloseWhenJoiningKey = 'cache_ar_seat_close_when_joining';
  final String _seatShowSoundWaveInAudioModeKey =
      'cache_ar_seat_show_sound_wave_in_audio_mode';
  final String _seatKeepOriginalForegroundKey =
      'cache_ar_seat_keep_original_foreground';
  final String _bottomMenuBarVisibleKey = 'cache_ar_bottom_menu_bar_visible';
  final String _bottomMenuBarShowInRoomMessageButtonKey =
      'cache_ar_bottom_menu_bar_show_in_room_message_button';
  final String _bottomMenuBarMaxCountKey = 'cache_ar_bottom_menu_bar_max_count';
  final String _inRoomMessageVisibleKey = 'cache_ar_in_room_message_visible';
  final String _inRoomMessageWidthKey = 'cache_ar_in_room_message_width';
  final String _inRoomMessageHeightKey = 'cache_ar_in_room_message_height';
  final String _inRoomMessageShowNameKey = 'cache_ar_in_room_message_show_name';
  final String _inRoomMessageShowAvatarKey =
      'cache_ar_in_room_message_show_avatar';
  final String _inRoomMessageOpacityKey = 'cache_ar_in_room_message_opacity';
  final String _durationIsVisibleKey = 'cache_ar_duration_is_visible';
  final String _pipAspectWidthKey = 'cache_ar_pip_aspect_width';
  final String _pipAspectHeightKey = 'cache_ar_pip_aspect_height';
  final String _pipEnableWhenBackgroundKey =
      'cache_ar_pip_enable_when_background';
  final String _pipAndroidShowUserNameKey =
      'cache_ar_pip_android_show_user_name';
  final String _mediaPlayerSupportTransparentKey =
      'cache_ar_media_player_support_transparent';
  final String _mediaPlayerDefaultPlayerSupportKey =
      'cache_ar_media_player_default_player_support';
  final String _backgroundMediaPathKey = 'cache_ar_background_media_path';
  final String _backgroundMediaEnableRepeatKey =
      'cache_ar_background_media_enable_repeat';
  final String _signalingPluginLeaveRoomOnDisposeKey =
      'cache_ar_signaling_plugin_leave_room_on_dispose';
  final String _signalingPluginUninitOnDisposeKey =
      'cache_ar_signaling_plugin_uninit_on_dispose';
}
