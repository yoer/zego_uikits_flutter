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

    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_cacheSupportMissNotificationKey);
    prefs.remove(_cacheSupportMissNotificationReDialKey);
    prefs.remove(_cacheSupportInvitingInCallingKey);
    prefs.remove(_cacheOnlyInitiatorCanInviteInCallingKey);
    prefs.remove(_cacheTimeoutSecondKey);
    prefs.remove(_cacheResourceIDKey);
    prefs.remove(_cacheHistoryKey);
  }

  final String _cacheSupportMissNotificationKey = 'cache_call_i_s_miss_call';
  final String _cacheSupportMissNotificationReDialKey =
      'cache_call_i_s_miss_call_redial';

  final String _cacheSupportInvitingInCallingKey = 'cache_call_i_s_calling_can';
  final String _cacheOnlyInitiatorCanInviteInCallingKey =
      'cache_call_i_s_calling_can_only_invitor_can_invite';

  final String _cacheTimeoutSecondKey = 'cache_call_i_timeout';
  final String _cacheResourceIDKey = 'cache_call_i_resource_id';
  final String _cacheHistoryKey = 'cache_call_i_history';
}

class CallCache {
  List<String> dialInviteeIDs = [];
  final roomIDList = ValueNotifier<List<String>>(
    CallCache.defaultRoomIDList(),
  );

  var invitation = CallInvitationCache();

  bool _supportScreenSharing = true;
  bool _supportPIP = true;
  bool _supportAdvanceBeauty = true;
  bool _videoAspectFill = true;
  bool _turnOnCameraWhenJoining = true;
  bool _turnOnMicrophoneWhenJoining = true;
  bool _useSpeakerWhenJoining = true;

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

  bool get supportAdvanceBeauty => _supportAdvanceBeauty;
  set supportAdvanceBeauty(bool value) {
    _supportAdvanceBeauty = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_supportAdvanceBeautyKey, value);
    });
  }

  bool get supportPIP => _supportPIP;
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
    _supportScreenSharing = true;
    _supportPIP = true;
    _supportAdvanceBeauty = true;
    _videoAspectFill = true;

    _turnOnCameraWhenJoining = true;
    _turnOnMicrophoneWhenJoining = true;
    _useSpeakerWhenJoining = true;

    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_cacheRoomIDListKey);
    prefs.remove(_supportScreenSharingKey);
    prefs.remove(_supportPIPKey);
    prefs.remove(_supportAdvanceBeautyKey);
    prefs.remove(_supportVideoModeKey);
    prefs.remove(_turnOnCameraWhenJoiningKey);
    prefs.remove(_turnOnMicrophoneWhenJoiningKey);
    prefs.remove(_useSpeakerWhenJoiningKey);

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

    _supportScreenSharing =
        prefs.get(_supportScreenSharingKey) as bool? ?? true;
    _supportPIP = prefs.get(_supportPIPKey) as bool? ?? true;
    _supportAdvanceBeauty =
        prefs.get(_supportAdvanceBeautyKey) as bool? ?? true;
    _videoAspectFill = prefs.get(_supportVideoModeKey) as bool? ?? true;

    _turnOnCameraWhenJoining =
        prefs.get(_turnOnCameraWhenJoiningKey) as bool? ?? true;
    _turnOnMicrophoneWhenJoining =
        prefs.get(_turnOnMicrophoneWhenJoiningKey) as bool? ?? true;
    _useSpeakerWhenJoining =
        prefs.get(_useSpeakerWhenJoiningKey) as bool? ?? true;

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
  final String _supportScreenSharingKey = 'cache_call_screen_sharing';
  final String _supportPIPKey = 'cache_call_pip';
  final String _supportAdvanceBeautyKey = 'cache_call_advance_beauty';
  final String _supportVideoModeKey = 'cache_call_video_mode';
  final String _turnOnCameraWhenJoiningKey =
      'cache_call_turn_on_camera_when_joining';
  final String _turnOnMicrophoneWhenJoiningKey =
      'cache_call_turn_on_mic_when_joining';
  final String _useSpeakerWhenJoiningKey =
      'cache_call_use_speaker_when_joining';
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
