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

  bool _endCallWhenInitiatorLeave = false;
  bool _offlineAutoEnterAcceptedOfflineCall = true;

  bool _showVideoOnInvitationCall = true;
  bool _uiShowAvatar = true;
  bool _uiShowCentralName = true;
  bool _uiShowCallingText = true;
  bool _uiUseVideoViewAspectFill = false;
  bool _uiDefaultMicrophoneOn = true;
  bool _uiDefaultCameraOn = true;
  bool _uiDefaultSpeakerOn = true;
  bool _uiShowMainButtonsText = false;
  bool _uiShowSubButtonsText = true;

  // minimized settings for inviter
  bool _uiInviterMinimizedCancelButtonVisible = false;
  bool _uiInviterMinimizedShowTips = true;

  // minimized settings for invitee
  bool _uiInviteeMinimizedAcceptButtonVisible = false;
  bool _uiInviteeMinimizedDeclineButtonVisible = false;
  bool _uiInviteeMinimizedShowTips = true;

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

  bool get endCallWhenInitiatorLeave => _endCallWhenInitiatorLeave;
  set endCallWhenInitiatorLeave(bool value) {
    _endCallWhenInitiatorLeave = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_endCallWhenInitiatorLeaveKey, value);
    });
  }

  bool get offlineAutoEnterAcceptedOfflineCall =>
      _offlineAutoEnterAcceptedOfflineCall;
  set offlineAutoEnterAcceptedOfflineCall(bool value) {
    _offlineAutoEnterAcceptedOfflineCall = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_offlineAutoEnterAcceptedOfflineCallKey, value);
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

  bool get uiDefaultSpeakerOn => _uiDefaultSpeakerOn;
  set uiDefaultSpeakerOn(bool value) {
    _uiDefaultSpeakerOn = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_uiDefaultSpeakerOnKey, value);
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

  // inviter minimized settings
  bool get uiInviterMinimizedCancelButtonVisible =>
      _uiInviterMinimizedCancelButtonVisible;
  set uiInviterMinimizedCancelButtonVisible(bool value) {
    _uiInviterMinimizedCancelButtonVisible = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_uiInviterMinimizedCancelButtonVisibleKey, value);
    });
  }

  bool get uiInviterMinimizedShowTips => _uiInviterMinimizedShowTips;
  set uiInviterMinimizedShowTips(bool value) {
    _uiInviterMinimizedShowTips = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_uiInviterMinimizedShowTipsKey, value);
    });
  }

  // invitee minimized settings
  bool get uiInviteeMinimizedAcceptButtonVisible =>
      _uiInviteeMinimizedAcceptButtonVisible;
  set uiInviteeMinimizedAcceptButtonVisible(bool value) {
    _uiInviteeMinimizedAcceptButtonVisible = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_uiInviteeMinimizedAcceptButtonVisibleKey, value);
    });
  }

  bool get uiInviteeMinimizedDeclineButtonVisible =>
      _uiInviteeMinimizedDeclineButtonVisible;
  set uiInviteeMinimizedDeclineButtonVisible(bool value) {
    _uiInviteeMinimizedDeclineButtonVisible = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_uiInviteeMinimizedDeclineButtonVisibleKey, value);
    });
  }

  bool get uiInviteeMinimizedShowTips => _uiInviteeMinimizedShowTips;
  set uiInviteeMinimizedShowTips(bool value) {
    _uiInviteeMinimizedShowTips = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_uiInviteeMinimizedShowTipsKey, value);
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
    _endCallWhenInitiatorLeave =
        (prefs.getBool(_endCallWhenInitiatorLeaveKey) ?? false);
    _offlineAutoEnterAcceptedOfflineCall =
        (prefs.getBool(_offlineAutoEnterAcceptedOfflineCallKey) ?? true);

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
    _uiDefaultSpeakerOn = prefs.get(_uiDefaultSpeakerOnKey) as bool? ?? true;
    _uiShowMainButtonsText =
        prefs.get(_uiShowMainButtonsTextKey) as bool? ?? false;
    _uiShowSubButtonsText =
        prefs.get(_uiShowSubButtonsTextKey) as bool? ?? true;

    // load minimized settings
    _uiInviterMinimizedCancelButtonVisible =
        prefs.get(_uiInviterMinimizedCancelButtonVisibleKey) as bool? ?? false;
    _uiInviterMinimizedShowTips =
        prefs.get(_uiInviterMinimizedShowTipsKey) as bool? ?? true;
    _uiInviteeMinimizedAcceptButtonVisible =
        prefs.get(_uiInviteeMinimizedAcceptButtonVisibleKey) as bool? ?? false;
    _uiInviteeMinimizedDeclineButtonVisible =
        prefs.get(_uiInviteeMinimizedDeclineButtonVisibleKey) as bool? ?? false;
    _uiInviteeMinimizedShowTips =
        prefs.get(_uiInviteeMinimizedShowTipsKey) as bool? ?? true;

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
    _endCallWhenInitiatorLeave = false;
    _offlineAutoEnterAcceptedOfflineCall = true;

    _showVideoOnInvitationCall = true;
    _uiShowAvatar = true;
    _uiShowCentralName = true;
    _uiShowCallingText = true;
    _uiUseVideoViewAspectFill = false;
    _uiDefaultMicrophoneOn = true;
    _uiDefaultCameraOn = true;
    _uiShowMainButtonsText = false;
    _uiShowSubButtonsText = true;

    // reset minimized settings
    _uiInviterMinimizedCancelButtonVisible = false;
    _uiInviterMinimizedShowTips = true;
    _uiInviteeMinimizedAcceptButtonVisible = false;
    _uiInviteeMinimizedDeclineButtonVisible = false;
    _uiInviteeMinimizedShowTips = true;

    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_cacheSupportMissNotificationKey);
    prefs.remove(_cacheSupportMissNotificationReDialKey);
    prefs.remove(_cacheSupportInvitingInCallingKey);
    prefs.remove(_cacheOnlyInitiatorCanInviteInCallingKey);
    prefs.remove(_safeAreaKey);
    prefs.remove(_endCallWhenInitiatorLeaveKey);
    prefs.remove(_offlineAutoEnterAcceptedOfflineCallKey);
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
    prefs.remove(_uiDefaultSpeakerOnKey);
    prefs.remove(_uiShowMainButtonsTextKey);
    prefs.remove(_uiShowSubButtonsTextKey);

    // remove minimized settings
    prefs.remove(_uiInviterMinimizedCancelButtonVisibleKey);
    prefs.remove(_uiInviterMinimizedShowTipsKey);
    prefs.remove(_uiInviteeMinimizedAcceptButtonVisibleKey);
    prefs.remove(_uiInviteeMinimizedDeclineButtonVisibleKey);
    prefs.remove(_uiInviteeMinimizedShowTipsKey);
  }

  final String _cacheSupportMissNotificationKey = 'cache_call_i_s_miss_call';
  final String _cacheSupportMissNotificationReDialKey =
      'cache_call_i_s_miss_call_redial';

  final String _cacheSupportInvitingInCallingKey = 'cache_call_i_s_calling_can';
  final String _cacheOnlyInitiatorCanInviteInCallingKey =
      'cache_call_i_s_calling_can_only_invitor_can_invite';

  final String _safeAreaKey = 'cache_call_i_s_safe_area';
  final String _endCallWhenInitiatorLeaveKey =
      'cache_call_i_end_call_when_initiator_leave';
  final String _offlineAutoEnterAcceptedOfflineCallKey =
      'cache_call_i_offline_auto_enter_accepted_offline_call';

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
  final String _uiDefaultSpeakerOnKey = 'cache_call_ui_default_speaker_on';
  final String _uiShowMainButtonsTextKey =
      'cache_call_ui_show_main_buttons_text';
  final String _uiShowSubButtonsTextKey = 'cache_call_ui_show_sub_buttons_text';

  // minimized settings keys
  final String _uiInviterMinimizedCancelButtonVisibleKey =
      'cache_call_ui_inviter_minimized_cancel_button_visible';
  final String _uiInviterMinimizedShowTipsKey =
      'cache_call_ui_inviter_minimized_show_tips';
  final String _uiInviteeMinimizedAcceptButtonVisibleKey =
      'cache_call_ui_invitee_minimized_accept_button_visible';
  final String _uiInviteeMinimizedDeclineButtonVisibleKey =
      'cache_call_ui_invitee_minimized_decline_button_visible';
  final String _uiInviteeMinimizedShowTipsKey =
      'cache_call_ui_invitee_minimized_show_tips';
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

  // Basic configurations
  bool _useFrontCameraWhenJoining = true;
  bool _rootNavigator = false;
  bool _enableAccidentalTouchPrevention = true;

  // AudioVideoView configurations
  bool _isVideoMirror = true;
  bool _showMicrophoneStateOnView = true;
  bool _showCameraStateOnView = false;
  bool _showUserNameOnView = true;
  bool _showOnlyCameraMicrophoneOpened = false;
  bool _showLocalUser = true;
  bool _showWaitingCallAcceptAudioVideoView = true;
  bool _showAvatarInAudioMode = true;
  bool _showSoundWavesInAudioMode = true;

  // TopMenuBar configurations
  bool _topMenuBarIsVisible = true;
  String _topMenuBarTitle = '';
  bool _topMenuBarHideAutomatically = true;
  bool _topMenuBarHideByClick = true;

  // BottomMenuBar configurations
  bool _bottomMenuBarIsVisible = true;
  bool _bottomMenuBarHideAutomatically = true;
  bool _bottomMenuBarHideByClick = true;
  int _bottomMenuBarMaxCount = 5;

  // MemberList configurations
  bool _memberListShowMicrophoneState = true;
  bool _memberListShowCameraState = true;

  // ScreenSharing configurations
  int _screenSharingAutoStopInvalidCount = 3;
  bool _screenSharingDefaultFullScreen = false;

  // PIP configurations
  int _pipAspectWidth = 9;
  int _pipAspectHeight = 16;
  bool _pipEnableWhenBackground = true;
  bool _pipIOSSupport = true;

  // RequiredUser configurations
  bool _requiredUserEnabled = false;
  int _requiredUserDetectSeconds = 5;
  bool _requiredUserDetectInDebugMode = false;

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

  // Basic configurations
  bool get useFrontCameraWhenJoining => _useFrontCameraWhenJoining;
  set useFrontCameraWhenJoining(bool value) {
    _useFrontCameraWhenJoining = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_useFrontCameraWhenJoiningKey, value);
    });
  }

  bool get rootNavigator => _rootNavigator;
  set rootNavigator(bool value) {
    _rootNavigator = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_rootNavigatorKey, value);
    });
  }

  bool get enableAccidentalTouchPrevention => _enableAccidentalTouchPrevention;
  set enableAccidentalTouchPrevention(bool value) {
    _enableAccidentalTouchPrevention = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_enableAccidentalTouchPreventionKey, value);
    });
  }

  // AudioVideoView configurations
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

  bool get showOnlyCameraMicrophoneOpened => _showOnlyCameraMicrophoneOpened;
  set showOnlyCameraMicrophoneOpened(bool value) {
    _showOnlyCameraMicrophoneOpened = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_showOnlyCameraMicrophoneOpenedKey, value);
    });
  }

  bool get showLocalUser => _showLocalUser;
  set showLocalUser(bool value) {
    _showLocalUser = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_showLocalUserKey, value);
    });
  }

  bool get showWaitingCallAcceptAudioVideoView =>
      _showWaitingCallAcceptAudioVideoView;
  set showWaitingCallAcceptAudioVideoView(bool value) {
    _showWaitingCallAcceptAudioVideoView = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_showWaitingCallAcceptAudioVideoViewKey, value);
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

  // TopMenuBar configurations
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

  // BottomMenuBar configurations
  bool get bottomMenuBarIsVisible => _bottomMenuBarIsVisible;
  set bottomMenuBarIsVisible(bool value) {
    _bottomMenuBarIsVisible = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_bottomMenuBarIsVisibleKey, value);
    });
  }

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

  // MemberList configurations
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

  // ScreenSharing configurations
  int get screenSharingAutoStopInvalidCount =>
      _screenSharingAutoStopInvalidCount;
  set screenSharingAutoStopInvalidCount(int value) {
    _screenSharingAutoStopInvalidCount = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt(_screenSharingAutoStopInvalidCountKey, value);
    });
  }

  bool get screenSharingDefaultFullScreen => _screenSharingDefaultFullScreen;
  set screenSharingDefaultFullScreen(bool value) {
    _screenSharingDefaultFullScreen = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_screenSharingDefaultFullScreenKey, value);
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

  bool get pipIOSSupport => _pipIOSSupport;
  set pipIOSSupport(bool value) {
    _pipIOSSupport = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_pipIOSSupportKey, value);
    });
  }

  // RequiredUser configurations
  bool get requiredUserEnabled => _requiredUserEnabled;
  set requiredUserEnabled(bool value) {
    _requiredUserEnabled = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_requiredUserEnabledKey, value);
    });
  }

  int get requiredUserDetectSeconds => _requiredUserDetectSeconds;
  set requiredUserDetectSeconds(int value) {
    _requiredUserDetectSeconds = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt(_requiredUserDetectSecondsKey, value);
    });
  }

  bool get requiredUserDetectInDebugMode => _requiredUserDetectInDebugMode;
  set requiredUserDetectInDebugMode(bool value) {
    _requiredUserDetectInDebugMode = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_requiredUserDetectInDebugModeKey, value);
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

    // Basic configurations
    _useFrontCameraWhenJoining = true;
    _rootNavigator = false;
    _enableAccidentalTouchPrevention = true;

    // AudioVideoView configurations
    _isVideoMirror = true;
    _showMicrophoneStateOnView = true;
    _showCameraStateOnView = false;
    _showUserNameOnView = true;
    _showOnlyCameraMicrophoneOpened = false;
    _showLocalUser = true;
    _showWaitingCallAcceptAudioVideoView = true;
    _showAvatarInAudioMode = true;
    _showSoundWavesInAudioMode = true;

    // TopMenuBar configurations
    _topMenuBarIsVisible = true;
    _topMenuBarTitle = '';
    _topMenuBarHideAutomatically = true;
    _topMenuBarHideByClick = true;

    // BottomMenuBar configurations
    _bottomMenuBarIsVisible = true;
    _bottomMenuBarHideAutomatically = true;
    _bottomMenuBarHideByClick = true;
    _bottomMenuBarMaxCount = 5;

    // MemberList configurations
    _memberListShowMicrophoneState = true;
    _memberListShowCameraState = true;

    // ScreenSharing configurations
    _screenSharingAutoStopInvalidCount = 3;
    _screenSharingDefaultFullScreen = false;

    // PIP configurations
    _pipAspectWidth = 9;
    _pipAspectHeight = 16;
    _pipEnableWhenBackground = true;
    _pipIOSSupport = true;

    // RequiredUser configurations
    _requiredUserEnabled = false;
    _requiredUserDetectSeconds = 5;
    _requiredUserDetectInDebugMode = false;

    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_cacheRoomIDListKey);
    prefs.remove(_supportVideoModeKey);
    prefs.remove(_turnOnCameraWhenJoiningKey);
    prefs.remove(_turnOnMicrophoneWhenJoiningKey);
    prefs.remove(_useSpeakerWhenJoiningKey);
    prefs.remove(_supportChatKey);
    prefs.remove(_supportDurationVisibleKey);
    prefs.remove(_supportDurationAutoHangUpKey);
    prefs.remove(_supportDurationAutoHangUpSecondKey);

    // Remove new keys
    prefs.remove(_useFrontCameraWhenJoiningKey);
    prefs.remove(_rootNavigatorKey);
    prefs.remove(_enableAccidentalTouchPreventionKey);
    prefs.remove(_isVideoMirrorKey);
    prefs.remove(_showMicrophoneStateOnViewKey);
    prefs.remove(_showCameraStateOnViewKey);
    prefs.remove(_showUserNameOnViewKey);
    prefs.remove(_showOnlyCameraMicrophoneOpenedKey);
    prefs.remove(_showLocalUserKey);
    prefs.remove(_showWaitingCallAcceptAudioVideoViewKey);
    prefs.remove(_showAvatarInAudioModeKey);
    prefs.remove(_showSoundWavesInAudioModeKey);
    prefs.remove(_topMenuBarIsVisibleKey);
    prefs.remove(_topMenuBarTitleKey);
    prefs.remove(_topMenuBarHideAutomaticallyKey);
    prefs.remove(_topMenuBarHideByClickKey);
    prefs.remove(_bottomMenuBarIsVisibleKey);
    prefs.remove(_bottomMenuBarHideAutomaticallyKey);
    prefs.remove(_bottomMenuBarHideByClickKey);
    prefs.remove(_bottomMenuBarMaxCountKey);
    prefs.remove(_memberListShowMicrophoneStateKey);
    prefs.remove(_memberListShowCameraStateKey);
    prefs.remove(_screenSharingAutoStopInvalidCountKey);
    prefs.remove(_screenSharingDefaultFullScreenKey);
    prefs.remove(_pipAspectWidthKey);
    prefs.remove(_pipAspectHeightKey);
    prefs.remove(_pipEnableWhenBackgroundKey);
    prefs.remove(_pipIOSSupportKey);
    prefs.remove(_requiredUserEnabledKey);
    prefs.remove(_requiredUserDetectSecondsKey);
    prefs.remove(_requiredUserDetectInDebugModeKey);

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

    // Load new configurations
    _useFrontCameraWhenJoining =
        prefs.get(_useFrontCameraWhenJoiningKey) as bool? ?? true;
    _rootNavigator = prefs.get(_rootNavigatorKey) as bool? ?? false;
    _enableAccidentalTouchPrevention =
        prefs.get(_enableAccidentalTouchPreventionKey) as bool? ?? true;
    _isVideoMirror = prefs.get(_isVideoMirrorKey) as bool? ?? true;
    _showMicrophoneStateOnView =
        prefs.get(_showMicrophoneStateOnViewKey) as bool? ?? true;
    _showCameraStateOnView =
        prefs.get(_showCameraStateOnViewKey) as bool? ?? false;
    _showUserNameOnView = prefs.get(_showUserNameOnViewKey) as bool? ?? true;
    _showOnlyCameraMicrophoneOpened =
        prefs.get(_showOnlyCameraMicrophoneOpenedKey) as bool? ?? false;
    _showLocalUser = prefs.get(_showLocalUserKey) as bool? ?? true;
    _showWaitingCallAcceptAudioVideoView =
        prefs.get(_showWaitingCallAcceptAudioVideoViewKey) as bool? ?? true;
    _showAvatarInAudioMode =
        prefs.get(_showAvatarInAudioModeKey) as bool? ?? true;
    _showSoundWavesInAudioMode =
        prefs.get(_showSoundWavesInAudioModeKey) as bool? ?? true;
    _topMenuBarIsVisible = prefs.get(_topMenuBarIsVisibleKey) as bool? ?? true;
    _topMenuBarTitle = prefs.get(_topMenuBarTitleKey) as String? ?? '';
    _topMenuBarHideAutomatically =
        prefs.get(_topMenuBarHideAutomaticallyKey) as bool? ?? true;
    _topMenuBarHideByClick =
        prefs.get(_topMenuBarHideByClickKey) as bool? ?? true;
    _bottomMenuBarIsVisible =
        prefs.get(_bottomMenuBarIsVisibleKey) as bool? ?? true;
    _bottomMenuBarHideAutomatically =
        prefs.get(_bottomMenuBarHideAutomaticallyKey) as bool? ?? true;
    _bottomMenuBarHideByClick =
        prefs.get(_bottomMenuBarHideByClickKey) as bool? ?? true;
    _bottomMenuBarMaxCount = prefs.get(_bottomMenuBarMaxCountKey) as int? ?? 5;
    _memberListShowMicrophoneState =
        prefs.get(_memberListShowMicrophoneStateKey) as bool? ?? true;
    _memberListShowCameraState =
        prefs.get(_memberListShowCameraStateKey) as bool? ?? true;
    _screenSharingAutoStopInvalidCount =
        prefs.get(_screenSharingAutoStopInvalidCountKey) as int? ?? 3;
    _screenSharingDefaultFullScreen =
        prefs.get(_screenSharingDefaultFullScreenKey) as bool? ?? false;
    _pipAspectWidth = prefs.get(_pipAspectWidthKey) as int? ?? 9;
    _pipAspectHeight = prefs.get(_pipAspectHeightKey) as int? ?? 16;
    _pipEnableWhenBackground =
        prefs.get(_pipEnableWhenBackgroundKey) as bool? ?? true;
    _pipIOSSupport = prefs.get(_pipIOSSupportKey) as bool? ?? true;
    _requiredUserEnabled = prefs.get(_requiredUserEnabledKey) as bool? ?? false;
    _requiredUserDetectSeconds =
        prefs.get(_requiredUserDetectSecondsKey) as int? ?? 5;
    _requiredUserDetectInDebugMode =
        prefs.get(_requiredUserDetectInDebugModeKey) as bool? ?? false;
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

  // New keys
  final String _useFrontCameraWhenJoiningKey =
      'cache_call_use_front_camera_when_joining';
  final String _rootNavigatorKey = 'cache_call_root_navigator';
  final String _enableAccidentalTouchPreventionKey =
      'cache_call_enable_accidental_touch_prevention';
  final String _isVideoMirrorKey = 'cache_call_is_video_mirror';
  final String _showMicrophoneStateOnViewKey =
      'cache_call_show_microphone_state_on_view';
  final String _showCameraStateOnViewKey =
      'cache_call_show_camera_state_on_view';
  final String _showUserNameOnViewKey = 'cache_call_show_user_name_on_view';
  final String _showOnlyCameraMicrophoneOpenedKey =
      'cache_call_show_only_camera_microphone_opened';
  final String _showLocalUserKey = 'cache_call_show_local_user';
  final String _showWaitingCallAcceptAudioVideoViewKey =
      'cache_call_show_waiting_call_accept_audio_video_view';
  final String _showAvatarInAudioModeKey =
      'cache_call_show_avatar_in_audio_mode';
  final String _showSoundWavesInAudioModeKey =
      'cache_call_show_sound_waves_in_audio_mode';
  final String _topMenuBarIsVisibleKey = 'cache_call_top_menu_bar_is_visible';
  final String _topMenuBarTitleKey = 'cache_call_top_menu_bar_title';
  final String _topMenuBarHideAutomaticallyKey =
      'cache_call_top_menu_bar_hide_automatically';
  final String _topMenuBarHideByClickKey =
      'cache_call_top_menu_bar_hide_by_click';
  final String _bottomMenuBarIsVisibleKey =
      'cache_call_bottom_menu_bar_is_visible';
  final String _bottomMenuBarHideAutomaticallyKey =
      'cache_call_bottom_menu_bar_hide_automatically';
  final String _bottomMenuBarHideByClickKey =
      'cache_call_bottom_menu_bar_hide_by_click';
  final String _bottomMenuBarMaxCountKey =
      'cache_call_bottom_menu_bar_max_count';
  final String _memberListShowMicrophoneStateKey =
      'cache_call_member_list_show_microphone_state';
  final String _memberListShowCameraStateKey =
      'cache_call_member_list_show_camera_state';
  final String _screenSharingAutoStopInvalidCountKey =
      'cache_call_screen_sharing_auto_stop_invalid_count';
  final String _screenSharingDefaultFullScreenKey =
      'cache_call_screen_sharing_default_full_screen';
  final String _pipAspectWidthKey = 'cache_call_pip_aspect_width';
  final String _pipAspectHeightKey = 'cache_call_pip_aspect_height';
  final String _pipEnableWhenBackgroundKey =
      'cache_call_pip_enable_when_background';
  final String _pipIOSSupportKey = 'cache_call_pip_ios_support';
  final String _requiredUserEnabledKey = 'cache_call_required_user_enabled';
  final String _requiredUserDetectSecondsKey =
      'cache_call_required_user_detect_seconds';
  final String _requiredUserDetectInDebugModeKey =
      'cache_call_required_user_detect_in_debug_mode';

  bool _isLoaded = false;

  ///
  final durationCountDownNotifier = ValueNotifier<int>(-1);

  CallCache._internal();

  factory CallCache() => _instance;

  static final CallCache _instance = CallCache._internal();
}
