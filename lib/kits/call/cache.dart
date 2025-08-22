// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'invitation/history.dart';

class CallInvitationCache {
  final historyNotifier = ValueNotifier<List<CallRecord>>([]);

  int _timeoutSecond = 30;
  String _resourceID = "zego_data";

  /// missed call
  bool _supportMissedNotification = true;
  bool _supportMissedNotificationReDial = true;

  /// calling invitation
  bool _canInvitingInCalling = false;
  bool _onlyInitiatorCanInviteInCalling = false;

  bool _safeArea = false;

  bool _showVideoOnInvitationCall = true;
  bool _uiShowAvatar = true;
  bool _uiShowCentralName = true;
  bool _uiShowCallingText = true;
  bool _uiUseVideoViewAspectFill = false;
  bool _uiDefaultMicrophoneOn = true;
  bool _uiDefaultCameraOn = true;
  bool _uiShowMainButtonsText = false;
  bool _uiShowSubButtonsText = true;

  CallRecord? queryHistory(String callID) {
    final index = historyNotifier.value.indexWhere((e) => e.callID == callID);
    return -1 != index ? historyNotifier.value[index] : null;
  }

  void addHistory(CallRecord value) {
    historyNotifier.value = [
      ...historyNotifier.value,
      value,
    ];

    updateHistory();
  }

  void updateHistory({
    bool forceUpdate = false,
  }) {
    if (forceUpdate) {
      historyNotifier.value = [
        ...historyNotifier.value,
      ];
    }

    SharedPreferences.getInstance().then((prefs) {
      prefs.setStringList(
        _cacheHistoryKey,
        historyNotifier.value.map((e) => e.toJson()).toList(),
      );
    });
  }

  void removeHistory(String callID) {
    final oldValue = historyNotifier.value;
    oldValue.removeWhere((e) => e.callID == callID);
    historyNotifier.value = [...oldValue];

    updateHistory();
  }

  void clearHistory() {
    historyNotifier.value = [];

    SharedPreferences.getInstance().then((prefs) {
      prefs.remove(_cacheHistoryKey);
    });
  }

  bool get supportMissedNotificationReDial => _supportMissedNotificationReDial;
  set supportMissedNotificationReDial(bool value) {
    _supportMissedNotificationReDial = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_cacheSupportMissNotificationReDialKey, value);
    });
  }

  bool get supportMissedNotification => _supportMissedNotification;
  set supportMissedNotification(bool value) {
    _supportMissedNotification = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_cacheSupportMissNotificationKey, value);
    });
  }

  bool get canInvitingInCalling => _canInvitingInCalling;
  set canInvitingInCalling(bool value) {
    _canInvitingInCalling = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_cacheSupportInvitingInCallingKey, value);
    });
  }

  bool get onlyInitiatorCanInviteInCalling => _onlyInitiatorCanInviteInCalling;
  set onlyInitiatorCanInviteInCalling(bool value) {
    _onlyInitiatorCanInviteInCalling = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_cacheOnlyInitiatorCanInviteInCallingKey, value);
    });
  }

  bool get safeArea => _safeArea;
  set safeArea(bool value) {
    _safeArea = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_safeAreaKey, value);
    });
  }

  int get timeoutSecond => _timeoutSecond;
  set timeoutSecond(int value) {
    _timeoutSecond = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt(_cacheTimeoutSecondKey, value);
    });
  }

  String get resourceID => _resourceID;
  set resourceID(String value) {
    _resourceID = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setString(_cacheResourceIDKey, value);
    });
  }

  bool get uiShowAvatar => _uiShowAvatar;
  set uiShowAvatar(bool value) {
    _uiShowAvatar = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_uiShowAvatarKey, value);
    });
  }

  bool get uiShowCentralName => _uiShowCentralName;
  set uiShowCentralName(bool value) {
    _uiShowCentralName = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_uiShowCentralNameKey, value);
    });
  }

  bool get uiShowCallingText => _uiShowCallingText;
  set uiShowCallingText(bool value) {
    _uiShowCallingText = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_uiShowCallingTextKey, value);
    });
  }

  bool get uiUseVideoViewAspectFill => _uiUseVideoViewAspectFill;
  set uiUseVideoViewAspectFill(bool value) {
    _uiUseVideoViewAspectFill = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_uiUseVideoViewAspectFillKey, value);
    });
  }

  bool get uiDefaultMicrophoneOn => _uiDefaultMicrophoneOn;
  set uiDefaultMicrophoneOn(bool value) {
    _uiDefaultMicrophoneOn = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_uiDefaultMicrophoneOnKey, value);
    });
  }

  bool get uiDefaultCameraOn => _uiDefaultCameraOn;
  set uiDefaultCameraOn(bool value) {
    _uiDefaultCameraOn = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_uiDefaultCameraOnKey, value);
    });
  }

  bool get uiShowMainButtonsText => _uiShowMainButtonsText;
  set uiShowMainButtonsText(bool value) {
    _uiShowMainButtonsText = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_uiShowMainButtonsTextKey, value);
    });
  }

  bool get uiShowSubButtonsText => _uiShowSubButtonsText;
  set uiShowSubButtonsText(bool value) {
    _uiShowSubButtonsText = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_uiShowSubButtonsTextKey, value);
    });
  }

  bool get showVideoOnInvitationCall => _showVideoOnInvitationCall;
  set showVideoOnInvitationCall(bool value) {
    _showVideoOnInvitationCall = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_showVideoOnInvitationCallKey, value);
    });
  }

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();

    _supportMissedNotification =
        (prefs.getBool(_cacheSupportMissNotificationKey) ?? true);
    _supportMissedNotificationReDial =
        (prefs.getBool(_cacheSupportMissNotificationReDialKey) ?? false);
    _resourceID = (prefs.getString(_cacheResourceIDKey) ?? "zego_data");
    _timeoutSecond = (prefs.getInt(_cacheTimeoutSecondKey) ?? 30);
    _canInvitingInCalling =
        (prefs.getBool(_cacheSupportInvitingInCallingKey) ?? false);
    _onlyInitiatorCanInviteInCalling =
        (prefs.getBool(_cacheOnlyInitiatorCanInviteInCallingKey) ?? false);

    _safeArea = (prefs.getBool(_safeAreaKey) ?? false);

    _showVideoOnInvitationCall =
        prefs.get(_showVideoOnInvitationCallKey) as bool? ?? true;
    _uiShowAvatar = prefs.get(_uiShowAvatarKey) as bool? ?? true;
    _uiShowCentralName = prefs.get(_uiShowCentralNameKey) as bool? ?? true;
    _uiShowCallingText = prefs.get(_uiShowCallingTextKey) as bool? ?? true;
    _uiUseVideoViewAspectFill =
        prefs.get(_uiUseVideoViewAspectFillKey) as bool? ?? false;
    _uiDefaultMicrophoneOn =
        prefs.get(_uiDefaultMicrophoneOnKey) as bool? ?? true;
    _uiDefaultCameraOn = prefs.get(_uiDefaultCameraOnKey) as bool? ?? true;
    _uiShowMainButtonsText =
        prefs.get(_uiShowMainButtonsTextKey) as bool? ?? false;
    _uiShowSubButtonsText =
        prefs.get(_uiShowSubButtonsTextKey) as bool? ?? true;

    historyNotifier.value = (prefs.getStringList(_cacheHistoryKey) ?? [])
        .map((e) => CallRecord.fromJson(e))
        .toList();
  }

  Future<void> clear() async {
    _timeoutSecond = 30;
    _resourceID = "zego_data";
    _supportMissedNotification = true;
    _supportMissedNotificationReDial = true;
    _canInvitingInCalling = false;
    _onlyInitiatorCanInviteInCalling = false;
    _safeArea = false;

    _showVideoOnInvitationCall = true;
    _uiShowAvatar = true;
    _uiShowCentralName = true;
    _uiShowCallingText = true;
    _uiUseVideoViewAspectFill = false;
    _uiDefaultMicrophoneOn = true;
    _uiDefaultCameraOn = true;
    _uiShowMainButtonsText = false;
    _uiShowSubButtonsText = true;

    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_cacheSupportMissNotificationKey);
    prefs.remove(_cacheSupportMissNotificationReDialKey);
    prefs.remove(_cacheSupportInvitingInCallingKey);
    prefs.remove(_cacheOnlyInitiatorCanInviteInCallingKey);
    prefs.remove(_safeAreaKey);
    prefs.remove(_cacheTimeoutSecondKey);
    prefs.remove(_cacheResourceIDKey);
    prefs.remove(_cacheHistoryKey);

    prefs.remove(_showVideoOnInvitationCallKey);
    prefs.remove(_uiShowAvatarKey);
    prefs.remove(_uiShowCentralNameKey);
    prefs.remove(_uiShowCallingTextKey);
    prefs.remove(_uiUseVideoViewAspectFillKey);
    prefs.remove(_uiDefaultMicrophoneOnKey);
    prefs.remove(_uiDefaultCameraOnKey);
    prefs.remove(_uiShowMainButtonsTextKey);
    prefs.remove(_uiShowSubButtonsTextKey);
  }

  final String _cacheSupportMissNotificationKey = 'cache_call_i_s_miss_call';
  final String _cacheSupportMissNotificationReDialKey =
      'cache_call_i_s_miss_call_redial';

  final String _cacheSupportInvitingInCallingKey = 'cache_call_i_s_calling_can';
  final String _cacheOnlyInitiatorCanInviteInCallingKey =
      'cache_call_i_s_calling_can_only_invitor_can_invite';

  final String _safeAreaKey = 'cache_call_i_s_safe_area';

  final String _cacheTimeoutSecondKey = 'cache_call_i_timeout';
  final String _cacheResourceIDKey = 'cache_call_i_resource_id';
  final String _cacheHistoryKey = 'cache_call_i_history';

  final String _showVideoOnInvitationCallKey =
      'cache_call_show_video_on_invitee_call';
  final String _uiShowAvatarKey = 'cache_call_ui_show_avatar';
  final String _uiShowCentralNameKey = 'cache_call_ui_show_central_name';
  final String _uiShowCallingTextKey = 'cache_call_ui_show_calling_text';
  final String _uiUseVideoViewAspectFillKey =
      'cache_call_ui_use_video_view_aspect_fill';
  final String _uiDefaultMicrophoneOnKey =
      'cache_call_ui_default_microphone_on';
  final String _uiDefaultCameraOnKey = 'cache_call_ui_default_camera_on';
  final String _uiShowMainButtonsTextKey =
      'cache_call_ui_show_main_buttons_text';
  final String _uiShowSubButtonsTextKey = 'cache_call_ui_show_sub_buttons_text';
}

class CallCache {
  List<String> dialInviteeIDs = [];
  final roomIDList = ValueNotifier<List<String>>(
    CallCache.defaultRoomIDList(),
  );

  var invitation = CallInvitationCache();

  bool _videoAspectFill = true;
  bool _turnOnCameraWhenJoining = true;
  bool _turnOnMicrophoneWhenJoining = true;
  bool _useSpeakerWhenJoining = true;

  bool _supportChat = false;

  bool _durationVisible = true;
  bool _durationAutoHangUp = false;
  int _durationAutoHangUpSeconds = -1;

  bool get durationVisible => _durationVisible;
  set durationVisible(bool value) {
    _durationVisible = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_supportDurationVisibleKey, value);
    });
  }

  bool get durationAutoHangUp => _durationAutoHangUp;
  set durationAutoHangUp(bool value) {
    _durationAutoHangUp = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_supportDurationAutoHangUpKey, value);
    });
  }

  int get durationAutoHangUpSeconds => _durationAutoHangUpSeconds;
  set durationAutoHangUpSeconds(int value) {
    _durationAutoHangUpSeconds = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt(_supportDurationAutoHangUpSecondKey, value);
    });
  }

  bool get videoAspectFill => _videoAspectFill;
  set videoAspectFill(bool value) {
    _videoAspectFill = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_supportVideoModeKey, value);
    });
  }

  bool get turnOnCameraWhenJoining => _turnOnCameraWhenJoining;
  set turnOnCameraWhenJoining(bool value) {
    _turnOnCameraWhenJoining = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_turnOnCameraWhenJoiningKey, value);
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

  bool get supportChat => _supportChat;
  set supportChat(bool value) {
    _supportChat = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_supportChatKey, value);
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
    roomIDList.value = CallCache.defaultRoomIDList();
    dialInviteeIDs = [];
    _videoAspectFill = true;

    _turnOnCameraWhenJoining = true;
    _turnOnMicrophoneWhenJoining = true;
    _useSpeakerWhenJoining = true;

    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_cacheRoomIDListKey);
    prefs.remove(_supportVideoModeKey);
    prefs.remove(_turnOnCameraWhenJoiningKey);
    prefs.remove(_turnOnMicrophoneWhenJoiningKey);
    prefs.remove(_useSpeakerWhenJoiningKey);
    prefs.remove(_supportChatKey);

    invitation.clear();
  }

  Future<void> load() async {
    if (_isLoaded) {
      return;
    }
    _isLoaded = true;

    invitation.load();

    final prefs = await SharedPreferences.getInstance();

    final cacheRoomIDList =
        (prefs.get(_cacheRoomIDListKey) as List<Object?>? ?? [])
            .map((e) => e as String)
            .toList();
    roomIDList.value = cacheRoomIDList.isNotEmpty
        ? cacheRoomIDList
        : CallCache.defaultRoomIDList();

    _videoAspectFill = prefs.get(_supportVideoModeKey) as bool? ?? true;

    _turnOnCameraWhenJoining =
        prefs.get(_turnOnCameraWhenJoiningKey) as bool? ?? true;
    _turnOnMicrophoneWhenJoining =
        prefs.get(_turnOnMicrophoneWhenJoiningKey) as bool? ?? true;
    _useSpeakerWhenJoining =
        prefs.get(_useSpeakerWhenJoiningKey) as bool? ?? true;

    _supportChat = prefs.get(_supportChatKey) as bool? ?? true;

    _durationVisible = prefs.get(_supportDurationVisibleKey) as bool? ?? true;
    _durationAutoHangUp =
        prefs.get(_supportDurationAutoHangUpKey) as bool? ?? false;
    _durationAutoHangUpSeconds =
        prefs.get(_supportDurationAutoHangUpSecondKey) as int? ?? -1;
  }

  static List<String> defaultRoomIDList() {
    return List<String>.generate(5, (index) => '${100 + index}');
  }

  final String _cacheRoomIDListKey = 'cache_call_room_id_list';
  final String _supportVideoModeKey = 'cache_call_video_mode';
  final String _turnOnCameraWhenJoiningKey =
      'cache_call_turn_on_camera_when_joining';
  final String _turnOnMicrophoneWhenJoiningKey =
      'cache_call_turn_on_mic_when_joining';
  final String _useSpeakerWhenJoiningKey =
      'cache_call_use_speaker_when_joining';

  final String _supportChatKey = 'cache_call_support_chat';
  final String _supportDurationVisibleKey = 'cache_call_duration_visible';
  final String _supportDurationAutoHangUpKey =
      'cache_call_duration_auto_hangup';
  final String _supportDurationAutoHangUpSecondKey =
      'cache_call_duration_auto_hangup_sec';

  bool _isLoaded = false;

  ///
  final durationCountDownNotifier = ValueNotifier<int>(-1);

  CallCache._internal();

  factory CallCache() => _instance;

  static final CallCache _instance = CallCache._internal();
}
