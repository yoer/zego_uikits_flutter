// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

class ConferenceCache {
  final roomIDList = ValueNotifier<List<String>>(
    ConferenceCache.defaultRoomIDList(),
  );

  bool _videoAspectFill = true;

  // Basic configurations
  bool _turnOnCameraWhenJoining = true;
  bool _useFrontFacingCamera = true;
  bool _turnOnMicrophoneWhenJoining = true;
  bool _useSpeakerWhenJoining = true;
  bool _rootNavigator = false;

  // AudioVideoViewConfig configurations
  bool _muteInvisible = true;
  bool _isVideoMirror = true;
  bool _showMicrophoneStateOnView = true;
  bool _showCameraStateOnView = false;
  bool _showUserNameOnView = true;
  bool _showAvatarInAudioMode = true;
  bool _showSoundWavesInAudioMode = true;

  // TopMenuBarConfig configurations
  bool _topMenuBarIsVisible = true;
  String _topMenuBarTitle = 'Conference';
  bool _topMenuBarHideAutomatically = true;
  bool _topMenuBarHideByClick = true;
  int _topMenuBarStyle = 1; // 0 = light, 1 = dark

  // BottomMenuBarConfig configurations
  bool _bottomMenuBarHideAutomatically = true;
  bool _bottomMenuBarHideByClick = true;
  int _bottomMenuBarMaxCount = 5;
  int _bottomMenuBarStyle = 1; // 0 = light, 1 = dark

  // MemberListConfig configurations
  bool _memberListShowMicrophoneState = true;
  bool _memberListShowCameraState = true;

  // NotificationViewConfig configurations
  bool _notificationViewNotifyUserLeave = true;

  // DurationConfig configurations
  bool _durationIsVisible = true;
  bool _durationCanSync = false;

  bool get videoAspectFill => _videoAspectFill;
  set videoAspectFill(bool value) {
    _videoAspectFill = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_supportVideoModeKey, value);
    });
  }

  // Basic configurations
  bool get turnOnCameraWhenJoining => _turnOnCameraWhenJoining;
  set turnOnCameraWhenJoining(bool value) {
    _turnOnCameraWhenJoining = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_turnOnCameraWhenJoiningKey, value);
    });
  }

  bool get useFrontFacingCamera => _useFrontFacingCamera;
  set useFrontFacingCamera(bool value) {
    _useFrontFacingCamera = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_useFrontFacingCameraKey, value);
    });
  }

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

  // AudioVideoViewConfig configurations
  bool get muteInvisible => _muteInvisible;
  set muteInvisible(bool value) {
    _muteInvisible = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_muteInvisibleKey, value);
    });
  }

  bool get isVideoMirror => _isVideoMirror;
  set isVideoMirror(bool value) {
    _isVideoMirror = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_isVideoMirrorKey, value);
    });
  }

  bool get showMicrophoneStateOnView => _showMicrophoneStateOnView;
  set showMicrophoneStateOnView(bool value) {
    _showMicrophoneStateOnView = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_showMicrophoneStateOnViewKey, value);
    });
  }

  bool get showCameraStateOnView => _showCameraStateOnView;
  set showCameraStateOnView(bool value) {
    _showCameraStateOnView = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_showCameraStateOnViewKey, value);
    });
  }

  bool get showUserNameOnView => _showUserNameOnView;
  set showUserNameOnView(bool value) {
    _showUserNameOnView = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_showUserNameOnViewKey, value);
    });
  }

  bool get showAvatarInAudioMode => _showAvatarInAudioMode;
  set showAvatarInAudioMode(bool value) {
    _showAvatarInAudioMode = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_showAvatarInAudioModeKey, value);
    });
  }

  bool get showSoundWavesInAudioMode => _showSoundWavesInAudioMode;
  set showSoundWavesInAudioMode(bool value) {
    _showSoundWavesInAudioMode = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_showSoundWavesInAudioModeKey, value);
    });
  }

  // TopMenuBarConfig configurations
  bool get topMenuBarIsVisible => _topMenuBarIsVisible;
  set topMenuBarIsVisible(bool value) {
    _topMenuBarIsVisible = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_topMenuBarIsVisibleKey, value);
    });
  }

  String get topMenuBarTitle => _topMenuBarTitle;
  set topMenuBarTitle(String value) {
    _topMenuBarTitle = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString(_topMenuBarTitleKey, value);
    });
  }

  bool get topMenuBarHideAutomatically => _topMenuBarHideAutomatically;
  set topMenuBarHideAutomatically(bool value) {
    _topMenuBarHideAutomatically = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_topMenuBarHideAutomaticallyKey, value);
    });
  }

  bool get topMenuBarHideByClick => _topMenuBarHideByClick;
  set topMenuBarHideByClick(bool value) {
    _topMenuBarHideByClick = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_topMenuBarHideByClickKey, value);
    });
  }

  int get topMenuBarStyle => _topMenuBarStyle;
  set topMenuBarStyle(int value) {
    _topMenuBarStyle = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt(_topMenuBarStyleKey, value);
    });
  }

  // BottomMenuBarConfig configurations
  bool get bottomMenuBarHideAutomatically => _bottomMenuBarHideAutomatically;
  set bottomMenuBarHideAutomatically(bool value) {
    _bottomMenuBarHideAutomatically = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_bottomMenuBarHideAutomaticallyKey, value);
    });
  }

  bool get bottomMenuBarHideByClick => _bottomMenuBarHideByClick;
  set bottomMenuBarHideByClick(bool value) {
    _bottomMenuBarHideByClick = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_bottomMenuBarHideByClickKey, value);
    });
  }

  int get bottomMenuBarMaxCount => _bottomMenuBarMaxCount;
  set bottomMenuBarMaxCount(int value) {
    _bottomMenuBarMaxCount = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt(_bottomMenuBarMaxCountKey, value);
    });
  }

  int get bottomMenuBarStyle => _bottomMenuBarStyle;
  set bottomMenuBarStyle(int value) {
    _bottomMenuBarStyle = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt(_bottomMenuBarStyleKey, value);
    });
  }

  // MemberListConfig configurations
  bool get memberListShowMicrophoneState => _memberListShowMicrophoneState;
  set memberListShowMicrophoneState(bool value) {
    _memberListShowMicrophoneState = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_memberListShowMicrophoneStateKey, value);
    });
  }

  bool get memberListShowCameraState => _memberListShowCameraState;
  set memberListShowCameraState(bool value) {
    _memberListShowCameraState = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_memberListShowCameraStateKey, value);
    });
  }

  // NotificationViewConfig configurations
  bool get notificationViewNotifyUserLeave => _notificationViewNotifyUserLeave;
  set notificationViewNotifyUserLeave(bool value) {
    _notificationViewNotifyUserLeave = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_notificationViewNotifyUserLeaveKey, value);
    });
  }

  // DurationConfig configurations
  bool get durationIsVisible => _durationIsVisible;
  set durationIsVisible(bool value) {
    _durationIsVisible = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_durationIsVisibleKey, value);
    });
  }

  bool get durationCanSync => _durationCanSync;
  set durationCanSync(bool value) {
    _durationCanSync = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_durationCanSyncKey, value);
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

    _videoAspectFill = true;

    // Reset new configurations
    _turnOnCameraWhenJoining = true;
    _useFrontFacingCamera = true;
    _turnOnMicrophoneWhenJoining = true;
    _useSpeakerWhenJoining = true;
    _rootNavigator = false;
    _muteInvisible = true;
    _isVideoMirror = true;
    _showMicrophoneStateOnView = true;
    _showCameraStateOnView = false;
    _showUserNameOnView = true;
    _showAvatarInAudioMode = true;
    _showSoundWavesInAudioMode = true;
    _topMenuBarIsVisible = true;
    _topMenuBarTitle = 'Conference';
    _topMenuBarHideAutomatically = true;
    _topMenuBarHideByClick = true;
    _topMenuBarStyle = 1;
    _bottomMenuBarHideAutomatically = true;
    _bottomMenuBarHideByClick = true;
    _bottomMenuBarMaxCount = 5;
    _bottomMenuBarStyle = 1;
    _memberListShowMicrophoneState = true;
    _memberListShowCameraState = true;
    _notificationViewNotifyUserLeave = true;
    _durationIsVisible = true;
    _durationCanSync = false;

    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_cacheRoomIDListKey);
    prefs.remove(_supportScreenSharingKey);
    prefs.remove(_supportVideoModeKey);

    // Remove new keys
    prefs.remove(_turnOnCameraWhenJoiningKey);
    prefs.remove(_useFrontFacingCameraKey);
    prefs.remove(_turnOnMicrophoneWhenJoiningKey);
    prefs.remove(_useSpeakerWhenJoiningKey);
    prefs.remove(_rootNavigatorKey);
    prefs.remove(_muteInvisibleKey);
    prefs.remove(_isVideoMirrorKey);
    prefs.remove(_showMicrophoneStateOnViewKey);
    prefs.remove(_showCameraStateOnViewKey);
    prefs.remove(_showUserNameOnViewKey);
    prefs.remove(_showAvatarInAudioModeKey);
    prefs.remove(_showSoundWavesInAudioModeKey);
    prefs.remove(_topMenuBarIsVisibleKey);
    prefs.remove(_topMenuBarTitleKey);
    prefs.remove(_topMenuBarHideAutomaticallyKey);
    prefs.remove(_topMenuBarHideByClickKey);
    prefs.remove(_topMenuBarStyleKey);
    prefs.remove(_bottomMenuBarHideAutomaticallyKey);
    prefs.remove(_bottomMenuBarHideByClickKey);
    prefs.remove(_bottomMenuBarMaxCountKey);
    prefs.remove(_bottomMenuBarStyleKey);
    prefs.remove(_memberListShowMicrophoneStateKey);
    prefs.remove(_memberListShowCameraStateKey);
    prefs.remove(_notificationViewNotifyUserLeaveKey);
    prefs.remove(_durationIsVisibleKey);
    prefs.remove(_durationCanSyncKey);
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

    _videoAspectFill = prefs.get(_supportVideoModeKey) as bool? ?? true;

    // Load new configurations
    _turnOnCameraWhenJoining =
        prefs.get(_turnOnCameraWhenJoiningKey) as bool? ?? true;
    _useFrontFacingCamera =
        prefs.get(_useFrontFacingCameraKey) as bool? ?? true;
    _turnOnMicrophoneWhenJoining =
        prefs.get(_turnOnMicrophoneWhenJoiningKey) as bool? ?? true;
    _useSpeakerWhenJoining =
        prefs.get(_useSpeakerWhenJoiningKey) as bool? ?? true;
    _rootNavigator = prefs.get(_rootNavigatorKey) as bool? ?? false;
    _muteInvisible = prefs.get(_muteInvisibleKey) as bool? ?? true;
    _isVideoMirror = prefs.get(_isVideoMirrorKey) as bool? ?? true;
    _showMicrophoneStateOnView =
        prefs.get(_showMicrophoneStateOnViewKey) as bool? ?? true;
    _showCameraStateOnView =
        prefs.get(_showCameraStateOnViewKey) as bool? ?? false;
    _showUserNameOnView = prefs.get(_showUserNameOnViewKey) as bool? ?? true;
    _showAvatarInAudioMode =
        prefs.get(_showAvatarInAudioModeKey) as bool? ?? true;
    _showSoundWavesInAudioMode =
        prefs.get(_showSoundWavesInAudioModeKey) as bool? ?? true;
    _topMenuBarIsVisible = prefs.get(_topMenuBarIsVisibleKey) as bool? ?? true;
    _topMenuBarTitle =
        prefs.get(_topMenuBarTitleKey) as String? ?? 'Conference';
    _topMenuBarHideAutomatically =
        prefs.get(_topMenuBarHideAutomaticallyKey) as bool? ?? true;
    _topMenuBarHideByClick =
        prefs.get(_topMenuBarHideByClickKey) as bool? ?? true;
    _topMenuBarStyle = prefs.get(_topMenuBarStyleKey) as int? ?? 1;
    _bottomMenuBarHideAutomatically =
        prefs.get(_bottomMenuBarHideAutomaticallyKey) as bool? ?? true;
    _bottomMenuBarHideByClick =
        prefs.get(_bottomMenuBarHideByClickKey) as bool? ?? true;
    _bottomMenuBarMaxCount = prefs.get(_bottomMenuBarMaxCountKey) as int? ?? 5;
    _bottomMenuBarStyle = prefs.get(_bottomMenuBarStyleKey) as int? ?? 1;
    _memberListShowMicrophoneState =
        prefs.get(_memberListShowMicrophoneStateKey) as bool? ?? true;
    _memberListShowCameraState =
        prefs.get(_memberListShowCameraStateKey) as bool? ?? true;
    _notificationViewNotifyUserLeave =
        prefs.get(_notificationViewNotifyUserLeaveKey) as bool? ?? true;
    _durationIsVisible = prefs.get(_durationIsVisibleKey) as bool? ?? true;
    _durationCanSync = prefs.get(_durationCanSyncKey) as bool? ?? false;
  }

  static List<String> defaultRoomIDList() {
    return List<String>.generate(5, (index) => '${100 + index}');
  }

  final String _cacheRoomIDListKey = 'cache_cf_room_id_list';
  final String _supportScreenSharingKey = 'cache_cf_screen_sharing';
  final String _supportVideoModeKey = 'cache_ls_video_mode';

  // New keys
  final String _turnOnCameraWhenJoiningKey =
      'cache_cf_turn_on_camera_when_joining';
  final String _useFrontFacingCameraKey = 'cache_cf_use_front_facing_camera';
  final String _turnOnMicrophoneWhenJoiningKey =
      'cache_cf_turn_on_microphone_when_joining';
  final String _useSpeakerWhenJoiningKey = 'cache_cf_use_speaker_when_joining';
  final String _rootNavigatorKey = 'cache_cf_root_navigator';
  final String _muteInvisibleKey = 'cache_cf_mute_invisible';
  final String _isVideoMirrorKey = 'cache_cf_is_video_mirror';
  final String _showMicrophoneStateOnViewKey =
      'cache_cf_show_microphone_state_on_view';
  final String _showCameraStateOnViewKey = 'cache_cf_show_camera_state_on_view';
  final String _showUserNameOnViewKey = 'cache_cf_show_user_name_on_view';
  final String _showAvatarInAudioModeKey = 'cache_cf_show_avatar_in_audio_mode';
  final String _showSoundWavesInAudioModeKey =
      'cache_cf_show_sound_waves_in_audio_mode';
  final String _topMenuBarIsVisibleKey = 'cache_cf_top_menu_bar_is_visible';
  final String _topMenuBarTitleKey = 'cache_cf_top_menu_bar_title';
  final String _topMenuBarHideAutomaticallyKey =
      'cache_cf_top_menu_bar_hide_automatically';
  final String _topMenuBarHideByClickKey =
      'cache_cf_top_menu_bar_hide_by_click';
  final String _topMenuBarStyleKey = 'cache_cf_top_menu_bar_style';
  final String _bottomMenuBarHideAutomaticallyKey =
      'cache_cf_bottom_menu_bar_hide_automatically';
  final String _bottomMenuBarHideByClickKey =
      'cache_cf_bottom_menu_bar_hide_by_click';
  final String _bottomMenuBarMaxCountKey = 'cache_cf_bottom_menu_bar_max_count';
  final String _bottomMenuBarStyleKey = 'cache_cf_bottom_menu_bar_style';
  final String _memberListShowMicrophoneStateKey =
      'cache_cf_member_list_show_microphone_state';
  final String _memberListShowCameraStateKey =
      'cache_cf_member_list_show_camera_state';
  final String _notificationViewNotifyUserLeaveKey =
      'cache_cf_notification_view_notify_user_leave';
  final String _durationIsVisibleKey = 'cache_cf_duration_is_visible';
  final String _durationCanSyncKey = 'cache_cf_duration_can_sync';

  bool _isLoaded = false;

  ConferenceCache._internal();

  factory ConferenceCache() => _instance;

  static final ConferenceCache _instance = ConferenceCache._internal();
}
