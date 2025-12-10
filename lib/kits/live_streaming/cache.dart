// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

// Project imports:
import 'package:zego_uikits_demo/data/assets.dart';

class LiveStreamingCache {
  final roomIDList = ValueNotifier<List<String>>(
    LiveStreamingCache.defaultRoomIDList(),
  );
  final liveListMap = ValueNotifier<Map<String, String>>({});

  bool _pkAutoAccept = false;
  bool _useModulePrefix = false;

  String _mediaDefaultURL = '';
  bool _autoPlayMedia = true;

  bool _supportGift = true;
  bool _videoAspectFill = true;
  bool _showUserNameOnView = true;
  bool _showMicrophoneStateOnView = true;

  ZegoLiveStreamingStreamMode _streamMode =
      ZegoLiveStreamingStreamMode.preloaded;

  // CoHost configurations
  bool _stopCoHostingWhenMicCameraOff = false;
  bool _disableCoHostInvitationReceivedDialog = false;
  int _maxCoHostCount = 12;
  int _inviteTimeoutSecond = 60;

  // Signaling plugin configurations
  bool _signalingPluginUninitOnDispose = false;
  bool _signalingPluginLeaveRoomOnDispose = true;

  // Basic configurations
  bool _turnOnCameraWhenJoining = true;
  bool _useFrontFacingCamera = true;
  bool _turnOnMicrophoneWhenJoining = true;
  bool _useSpeakerWhenJoining = true;
  bool _rootNavigator = false;
  bool _markAsLargeRoom = false;
  bool _slideSurfaceToHide = true;
  bool _showBackgroundTips = false;
  bool _showToast = false;

  // AudioVideoView configurations
  bool _isVideoMirror = true;
  bool _showAvatarInAudioMode = true;
  bool _showSoundWavesInAudioMode = true;

  // TopMenuBar configurations
  bool _showCloseButton = true;

  // BottomMenuBar configurations
  bool _showInRoomMessageButton = true;
  int _bottomMenuBarMaxCount = 5;

  // MemberList configurations
  bool _showFakeUser = false;
  bool _notifyUserJoin = true;
  bool _notifyUserLeave = true;

  // InRoomMessage configurations
  bool _inRoomMessageVisible = true;
  bool _showFakeMessage = false;
  bool _inRoomMessageShowName = true;
  bool _inRoomMessageShowAvatar = true;
  double _inRoomMessageOpacity = 1.0;

  // Duration configurations
  bool _durationIsVisible = true;

  // Preview configurations
  bool _showPreviewForHost = true;
  bool _previewTopBarIsVisible = true;
  bool _previewBottomBarIsVisible = true;
  bool _previewBottomBarShowBeautyEffectButton = true;

  // PKBattle configurations
  int _pkBattleUserReconnectingSecond = 5;
  int _pkBattleUserDisconnectedSecond = 90;
  double? _pkBattleTopPadding;

  // ScreenSharing configurations
  int _screenSharingAutoStopInvalidCount = 3;
  bool _screenSharingDefaultFullScreen = false;

  // MediaPlayer configurations
  bool _mediaPlayerSupportTransparent = false;

  // PIP configurations
  int _pipAspectWidth = 9;
  int _pipAspectHeight = 16;

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

  bool get pkAutoAccept => _pkAutoAccept;

  set pkAutoAccept(bool value) {
    _pkAutoAccept = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_cachePKAutoAcceptKey, value);
    });
  }

  bool get useModulePrefix => _useModulePrefix;

  set useModulePrefix(bool value) {
    _useModulePrefix = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_cacheUseModulePrefixKey, value);
    });
  }

  ZegoLiveStreamingStreamMode get streamMode => _streamMode;

  set streamMode(ZegoLiveStreamingStreamMode value) {
    _streamMode = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setString(_cacheStreamModeKey, value.name);
    });
  }

  // CoHost configurations
  bool get stopCoHostingWhenMicCameraOff => _stopCoHostingWhenMicCameraOff;

  set stopCoHostingWhenMicCameraOff(bool value) {
    _stopCoHostingWhenMicCameraOff = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_cacheStopCoHostingWhenMicCameraOffKey, value);
    });
  }

  bool get disableCoHostInvitationReceivedDialog =>
      _disableCoHostInvitationReceivedDialog;

  set disableCoHostInvitationReceivedDialog(bool value) {
    _disableCoHostInvitationReceivedDialog = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_cacheDisableCoHostInvitationReceivedDialogKey, value);
    });
  }

  int get maxCoHostCount => _maxCoHostCount;

  set maxCoHostCount(int value) {
    _maxCoHostCount = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt(_cacheMaxCoHostCountKey, value);
    });
  }

  int get inviteTimeoutSecond => _inviteTimeoutSecond;

  set inviteTimeoutSecond(int value) {
    _inviteTimeoutSecond = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt(_cacheInviteTimeoutSecondKey, value);
    });
  }

  // Signaling plugin configurations
  bool get signalingPluginUninitOnDispose => _signalingPluginUninitOnDispose;

  set signalingPluginUninitOnDispose(bool value) {
    _signalingPluginUninitOnDispose = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_cacheSignalingPluginUninitOnDisposeKey, value);
    });
  }

  bool get signalingPluginLeaveRoomOnDispose =>
      _signalingPluginLeaveRoomOnDispose;

  set signalingPluginLeaveRoomOnDispose(bool value) {
    _signalingPluginLeaveRoomOnDispose = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_cacheSignalingPluginLeaveRoomOnDisposeKey, value);
    });
  }

  // Basic configurations
  bool get turnOnCameraWhenJoining => _turnOnCameraWhenJoining;

  set turnOnCameraWhenJoining(bool value) {
    _turnOnCameraWhenJoining = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_cacheTurnOnCameraWhenJoiningKey, value);
    });
  }

  bool get useFrontFacingCamera => _useFrontFacingCamera;

  set useFrontFacingCamera(bool value) {
    _useFrontFacingCamera = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_cacheUseFrontFacingCameraKey, value);
    });
  }

  bool get turnOnMicrophoneWhenJoining => _turnOnMicrophoneWhenJoining;

  set turnOnMicrophoneWhenJoining(bool value) {
    _turnOnMicrophoneWhenJoining = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_cacheTurnOnMicrophoneWhenJoiningKey, value);
    });
  }

  bool get useSpeakerWhenJoining => _useSpeakerWhenJoining;

  set useSpeakerWhenJoining(bool value) {
    _useSpeakerWhenJoining = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_cacheUseSpeakerWhenJoiningKey, value);
    });
  }

  bool get rootNavigator => _rootNavigator;

  set rootNavigator(bool value) {
    _rootNavigator = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_cacheRootNavigatorKey, value);
    });
  }

  bool get markAsLargeRoom => _markAsLargeRoom;

  set markAsLargeRoom(bool value) {
    _markAsLargeRoom = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_cacheMarkAsLargeRoomKey, value);
    });
  }

  bool get slideSurfaceToHide => _slideSurfaceToHide;

  set slideSurfaceToHide(bool value) {
    _slideSurfaceToHide = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_cacheSlideSurfaceToHideKey, value);
    });
  }

  bool get showBackgroundTips => _showBackgroundTips;

  set showBackgroundTips(bool value) {
    _showBackgroundTips = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_cacheShowBackgroundTipsKey, value);
    });
  }

  bool get showToast => _showToast;

  set showToast(bool value) {
    _showToast = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_cacheShowToastKey, value);
    });
  }

  // AudioVideoView configurations
  bool get isVideoMirror => _isVideoMirror;

  set isVideoMirror(bool value) {
    _isVideoMirror = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_cacheIsVideoMirrorKey, value);
    });
  }

  bool get showAvatarInAudioMode => _showAvatarInAudioMode;

  set showAvatarInAudioMode(bool value) {
    _showAvatarInAudioMode = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_cacheShowAvatarInAudioModeKey, value);
    });
  }

  bool get showSoundWavesInAudioMode => _showSoundWavesInAudioMode;

  set showSoundWavesInAudioMode(bool value) {
    _showSoundWavesInAudioMode = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_cacheShowSoundWavesInAudioModeKey, value);
    });
  }

  // TopMenuBar configurations
  bool get showCloseButton => _showCloseButton;

  set showCloseButton(bool value) {
    _showCloseButton = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_cacheShowCloseButtonKey, value);
    });
  }

  // BottomMenuBar configurations
  bool get showInRoomMessageButton => _showInRoomMessageButton;

  set showInRoomMessageButton(bool value) {
    _showInRoomMessageButton = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_cacheShowInRoomMessageButtonKey, value);
    });
  }

  int get bottomMenuBarMaxCount => _bottomMenuBarMaxCount;

  set bottomMenuBarMaxCount(int value) {
    _bottomMenuBarMaxCount = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt(_cacheBottomMenuBarMaxCountKey, value);
    });
  }

  // MemberList configurations
  bool get showFakeUser => _showFakeUser;

  set showFakeUser(bool value) {
    _showFakeUser = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_cacheShowFakeUserKey, value);
    });
  }

  bool get notifyUserJoin => _notifyUserJoin;

  set notifyUserJoin(bool value) {
    _notifyUserJoin = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_cacheNotifyUserJoinKey, value);
    });
  }

  bool get notifyUserLeave => _notifyUserLeave;

  set notifyUserLeave(bool value) {
    _notifyUserLeave = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_cacheNotifyUserLeaveKey, value);
    });
  }

  // InRoomMessage configurations
  bool get inRoomMessageVisible => _inRoomMessageVisible;

  set inRoomMessageVisible(bool value) {
    _inRoomMessageVisible = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_cacheInRoomMessageVisibleKey, value);
    });
  }

  bool get showFakeMessage => _showFakeMessage;

  set showFakeMessage(bool value) {
    _showFakeMessage = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_cacheShowFakeMessageKey, value);
    });
  }

  bool get inRoomMessageShowName => _inRoomMessageShowName;

  set inRoomMessageShowName(bool value) {
    _inRoomMessageShowName = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_cacheInRoomMessageShowNameKey, value);
    });
  }

  bool get inRoomMessageShowAvatar => _inRoomMessageShowAvatar;

  set inRoomMessageShowAvatar(bool value) {
    _inRoomMessageShowAvatar = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_cacheInRoomMessageShowAvatarKey, value);
    });
  }

  double get inRoomMessageOpacity => _inRoomMessageOpacity;

  set inRoomMessageOpacity(double value) {
    _inRoomMessageOpacity = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setDouble(_cacheInRoomMessageOpacityKey, value);
    });
  }

  // Duration configurations
  bool get durationIsVisible => _durationIsVisible;

  set durationIsVisible(bool value) {
    _durationIsVisible = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_cacheDurationIsVisibleKey, value);
    });
  }

  // Preview configurations
  bool get showPreviewForHost => _showPreviewForHost;

  set showPreviewForHost(bool value) {
    _showPreviewForHost = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_cacheShowPreviewForHostKey, value);
    });
  }

  bool get previewTopBarIsVisible => _previewTopBarIsVisible;

  set previewTopBarIsVisible(bool value) {
    _previewTopBarIsVisible = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_cachePreviewTopBarIsVisibleKey, value);
    });
  }

  bool get previewBottomBarIsVisible => _previewBottomBarIsVisible;

  set previewBottomBarIsVisible(bool value) {
    _previewBottomBarIsVisible = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_cachePreviewBottomBarIsVisibleKey, value);
    });
  }

  bool get previewBottomBarShowBeautyEffectButton =>
      _previewBottomBarShowBeautyEffectButton;

  set previewBottomBarShowBeautyEffectButton(bool value) {
    _previewBottomBarShowBeautyEffectButton = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_cachePreviewBottomBarShowBeautyEffectButtonKey, value);
    });
  }

  // PKBattle configurations
  int get pkBattleUserReconnectingSecond => _pkBattleUserReconnectingSecond;

  set pkBattleUserReconnectingSecond(int value) {
    _pkBattleUserReconnectingSecond = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt(_cachePKBattleUserReconnectingSecondKey, value);
    });
  }

  int get pkBattleUserDisconnectedSecond => _pkBattleUserDisconnectedSecond;

  set pkBattleUserDisconnectedSecond(int value) {
    _pkBattleUserDisconnectedSecond = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt(_cachePKBattleUserDisconnectedSecondKey, value);
    });
  }

  double? get pkBattleTopPadding => _pkBattleTopPadding;

  set pkBattleTopPadding(double? value) {
    _pkBattleTopPadding = value;

    SharedPreferences.getInstance().then((prefs) {
      if (value != null) {
        prefs.setDouble(_cachePKBattleTopPaddingKey, value);
      } else {
        prefs.remove(_cachePKBattleTopPaddingKey);
      }
    });
  }

  // ScreenSharing configurations
  int get screenSharingAutoStopInvalidCount =>
      _screenSharingAutoStopInvalidCount;

  set screenSharingAutoStopInvalidCount(int value) {
    _screenSharingAutoStopInvalidCount = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt(_cacheScreenSharingAutoStopInvalidCountKey, value);
    });
  }

  bool get screenSharingDefaultFullScreen => _screenSharingDefaultFullScreen;

  set screenSharingDefaultFullScreen(bool value) {
    _screenSharingDefaultFullScreen = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_cacheScreenSharingDefaultFullScreenKey, value);
    });
  }

  // MediaPlayer configurations
  bool get mediaPlayerSupportTransparent => _mediaPlayerSupportTransparent;

  set mediaPlayerSupportTransparent(bool value) {
    _mediaPlayerSupportTransparent = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_cacheMediaPlayerSupportTransparentKey, value);
    });
  }

  // PIP configurations
  int get pipAspectWidth => _pipAspectWidth;

  set pipAspectWidth(int value) {
    _pipAspectWidth = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt(_cachePipAspectWidthKey, value);
    });
  }

  int get pipAspectHeight => _pipAspectHeight;

  set pipAspectHeight(int value) {
    _pipAspectHeight = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt(_cachePipAspectHeightKey, value);
    });
  }

  Future<void> clear() async {
    roomIDList.value = LiveStreamingCache.defaultRoomIDList();
    liveListMap.value = {};

    _pkAutoAccept = false;
    _useModulePrefix = false;

    _mediaDefaultURL = '';
    _autoPlayMedia = true;

    _supportGift = true;
    _videoAspectFill = true;
    _showUserNameOnView = true;
    _showMicrophoneStateOnView = true;
    _streamMode = ZegoLiveStreamingStreamMode.preloaded;

    _stopCoHostingWhenMicCameraOff = false;
    _disableCoHostInvitationReceivedDialog = false;
    _maxCoHostCount = 12;
    _inviteTimeoutSecond = 60;
    _signalingPluginUninitOnDispose = false;
    _signalingPluginLeaveRoomOnDispose = true;

    // Basic configurations
    _turnOnCameraWhenJoining = true;
    _useFrontFacingCamera = true;
    _turnOnMicrophoneWhenJoining = true;
    _useSpeakerWhenJoining = true;
    _rootNavigator = false;
    _markAsLargeRoom = false;
    _slideSurfaceToHide = true;
    _showBackgroundTips = false;
    _showToast = false;

    // AudioVideoView configurations
    _isVideoMirror = true;
    _showAvatarInAudioMode = true;
    _showSoundWavesInAudioMode = true;

    // TopMenuBar configurations
    _showCloseButton = true;

    // BottomMenuBar configurations
    _showInRoomMessageButton = true;
    _bottomMenuBarMaxCount = 5;

    // MemberList configurations
    _showFakeUser = false;
    _notifyUserJoin = true;
    _notifyUserLeave = true;

    // InRoomMessage configurations
    _inRoomMessageVisible = true;
    _showFakeMessage = false;
    _inRoomMessageShowName = true;
    _inRoomMessageShowAvatar = true;
    _inRoomMessageOpacity = 1.0;

    // Duration configurations
    _durationIsVisible = true;

    // Preview configurations
    _showPreviewForHost = true;
    _previewTopBarIsVisible = true;
    _previewBottomBarIsVisible = true;
    _previewBottomBarShowBeautyEffectButton = true;

    // PKBattle configurations
    _pkBattleUserReconnectingSecond = 5;
    _pkBattleUserDisconnectedSecond = 90;
    _pkBattleTopPadding = null;

    // ScreenSharing configurations
    _screenSharingAutoStopInvalidCount = 3;
    _screenSharingDefaultFullScreen = false;

    // MediaPlayer configurations
    _mediaPlayerSupportTransparent = false;

    // PIP configurations
    _pipAspectWidth = 9;
    _pipAspectHeight = 16;

    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_cacheRoomIDListKey);
    prefs.remove(_cacheLiveListMapKey);

    prefs.remove(_cachePKAutoAcceptKey);
    prefs.remove(_cacheUseModulePrefixKey);

    prefs.remove(_supportShowUserNameKey);
    prefs.remove(_supportShowMicStateKey);
    prefs.remove(_supportMediaDefURLKey);
    prefs.remove(_supportMediaAutoPlayKey);
    prefs.remove(_supportVideoModeKey);
    prefs.remove(_supportGiftKey);
    prefs.remove(_cacheStreamModeKey);

    prefs.remove(_cacheStopCoHostingWhenMicCameraOffKey);
    prefs.remove(_cacheDisableCoHostInvitationReceivedDialogKey);
    prefs.remove(_cacheMaxCoHostCountKey);
    prefs.remove(_cacheInviteTimeoutSecondKey);
    prefs.remove(_cacheSignalingPluginUninitOnDisposeKey);
    prefs.remove(_cacheSignalingPluginLeaveRoomOnDisposeKey);

    // Basic configurations
    prefs.remove(_cacheTurnOnCameraWhenJoiningKey);
    prefs.remove(_cacheUseFrontFacingCameraKey);
    prefs.remove(_cacheTurnOnMicrophoneWhenJoiningKey);
    prefs.remove(_cacheUseSpeakerWhenJoiningKey);
    prefs.remove(_cacheRootNavigatorKey);
    prefs.remove(_cacheMarkAsLargeRoomKey);
    prefs.remove(_cacheSlideSurfaceToHideKey);
    prefs.remove(_cacheShowBackgroundTipsKey);
    prefs.remove(_cacheShowToastKey);

    // AudioVideoView configurations
    prefs.remove(_cacheIsVideoMirrorKey);
    prefs.remove(_cacheShowAvatarInAudioModeKey);
    prefs.remove(_cacheShowSoundWavesInAudioModeKey);

    // TopMenuBar configurations
    prefs.remove(_cacheShowCloseButtonKey);

    // BottomMenuBar configurations
    prefs.remove(_cacheShowInRoomMessageButtonKey);
    prefs.remove(_cacheBottomMenuBarMaxCountKey);

    // MemberList configurations
    prefs.remove(_cacheShowFakeUserKey);
    prefs.remove(_cacheNotifyUserJoinKey);
    prefs.remove(_cacheNotifyUserLeaveKey);

    // InRoomMessage configurations
    prefs.remove(_cacheInRoomMessageVisibleKey);
    prefs.remove(_cacheShowFakeMessageKey);
    prefs.remove(_cacheInRoomMessageShowNameKey);
    prefs.remove(_cacheInRoomMessageShowAvatarKey);
    prefs.remove(_cacheInRoomMessageOpacityKey);

    // Duration configurations
    prefs.remove(_cacheDurationIsVisibleKey);

    // Preview configurations
    prefs.remove(_cacheShowPreviewForHostKey);
    prefs.remove(_cachePreviewTopBarIsVisibleKey);
    prefs.remove(_cachePreviewBottomBarIsVisibleKey);
    prefs.remove(_cachePreviewBottomBarShowBeautyEffectButtonKey);

    // PKBattle configurations
    prefs.remove(_cachePKBattleUserReconnectingSecondKey);
    prefs.remove(_cachePKBattleUserDisconnectedSecondKey);
    prefs.remove(_cachePKBattleTopPaddingKey);

    // ScreenSharing configurations
    prefs.remove(_cacheScreenSharingAutoStopInvalidCountKey);
    prefs.remove(_cacheScreenSharingDefaultFullScreenKey);

    // MediaPlayer configurations
    prefs.remove(_cacheMediaPlayerSupportTransparentKey);

    // PIP configurations
    prefs.remove(_cachePipAspectWidthKey);
    prefs.remove(_cachePipAspectHeightKey);
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

    final liveListMapJson = prefs.get(_cacheLiveListMapKey) as String? ?? '';
    try {
      liveListMap.value = Map<String, String>.from(jsonDecode(liveListMapJson));
    } catch (e) {}

    _pkAutoAccept = prefs.get(_cachePKAutoAcceptKey) as bool? ?? false;
    _useModulePrefix = prefs.get(_cacheUseModulePrefixKey) as bool? ?? false;

    _autoPlayMedia = prefs.get(_supportMediaAutoPlayKey) as bool? ?? true;
    _mediaDefaultURL =
        prefs.get(_supportMediaDefURLKey) as String? ?? defaultMediaURL;

    _supportGift = prefs.get(_supportGiftKey) as bool? ?? true;
    _videoAspectFill = prefs.get(_supportVideoModeKey) as bool? ?? true;
    _showMicrophoneStateOnView =
        prefs.get(_supportShowMicStateKey) as bool? ?? true;
    _showUserNameOnView = prefs.get(_supportShowUserNameKey) as bool? ?? true;

    final streamModeString = prefs.get(_cacheStreamModeKey) as String?;
    if (streamModeString != null) {
      try {
        _streamMode = ZegoLiveStreamingStreamMode.values
            .firstWhere((e) => e.name == streamModeString);
      } catch (e) {
        _streamMode = ZegoLiveStreamingStreamMode.preloaded;
      }
    } else {
      _streamMode = ZegoLiveStreamingStreamMode.preloaded;
    }

    _stopCoHostingWhenMicCameraOff =
        prefs.get(_cacheStopCoHostingWhenMicCameraOffKey) as bool? ?? false;
    _disableCoHostInvitationReceivedDialog =
        prefs.get(_cacheDisableCoHostInvitationReceivedDialogKey) as bool? ??
            false;
    _maxCoHostCount = prefs.get(_cacheMaxCoHostCountKey) as int? ?? 12;
    _inviteTimeoutSecond =
        prefs.get(_cacheInviteTimeoutSecondKey) as int? ?? 60;
    _signalingPluginUninitOnDispose =
        prefs.get(_cacheSignalingPluginUninitOnDisposeKey) as bool? ?? false;
    _signalingPluginLeaveRoomOnDispose =
        prefs.get(_cacheSignalingPluginLeaveRoomOnDisposeKey) as bool? ?? true;

    // Basic configurations
    _turnOnCameraWhenJoining =
        prefs.get(_cacheTurnOnCameraWhenJoiningKey) as bool? ?? true;
    _useFrontFacingCamera =
        prefs.get(_cacheUseFrontFacingCameraKey) as bool? ?? true;
    _turnOnMicrophoneWhenJoining =
        prefs.get(_cacheTurnOnMicrophoneWhenJoiningKey) as bool? ?? true;
    _useSpeakerWhenJoining =
        prefs.get(_cacheUseSpeakerWhenJoiningKey) as bool? ?? true;
    _rootNavigator = prefs.get(_cacheRootNavigatorKey) as bool? ?? false;
    _markAsLargeRoom = prefs.get(_cacheMarkAsLargeRoomKey) as bool? ?? false;
    _slideSurfaceToHide =
        prefs.get(_cacheSlideSurfaceToHideKey) as bool? ?? true;
    _showBackgroundTips =
        prefs.get(_cacheShowBackgroundTipsKey) as bool? ?? false;
    _showToast = prefs.get(_cacheShowToastKey) as bool? ?? false;

    // AudioVideoView configurations
    _isVideoMirror = prefs.get(_cacheIsVideoMirrorKey) as bool? ?? true;
    _showAvatarInAudioMode =
        prefs.get(_cacheShowAvatarInAudioModeKey) as bool? ?? true;
    _showSoundWavesInAudioMode =
        prefs.get(_cacheShowSoundWavesInAudioModeKey) as bool? ?? true;

    // TopMenuBar configurations
    _showCloseButton = prefs.get(_cacheShowCloseButtonKey) as bool? ?? true;

    // BottomMenuBar configurations
    _showInRoomMessageButton =
        prefs.get(_cacheShowInRoomMessageButtonKey) as bool? ?? true;
    _bottomMenuBarMaxCount =
        prefs.get(_cacheBottomMenuBarMaxCountKey) as int? ?? 5;

    // MemberList configurations
    _showFakeUser = prefs.get(_cacheShowFakeUserKey) as bool? ?? false;
    _notifyUserJoin = prefs.get(_cacheNotifyUserJoinKey) as bool? ?? true;
    _notifyUserLeave = prefs.get(_cacheNotifyUserLeaveKey) as bool? ?? true;

    // InRoomMessage configurations
    _inRoomMessageVisible =
        prefs.get(_cacheInRoomMessageVisibleKey) as bool? ?? true;
    _showFakeMessage = prefs.get(_cacheShowFakeMessageKey) as bool? ?? false;
    _inRoomMessageShowName =
        prefs.get(_cacheInRoomMessageShowNameKey) as bool? ?? true;
    _inRoomMessageShowAvatar =
        prefs.get(_cacheInRoomMessageShowAvatarKey) as bool? ?? true;
    _inRoomMessageOpacity =
        prefs.get(_cacheInRoomMessageOpacityKey) as double? ?? 1.0;

    // Duration configurations
    _durationIsVisible = prefs.get(_cacheDurationIsVisibleKey) as bool? ?? true;

    // Preview configurations
    _showPreviewForHost =
        prefs.get(_cacheShowPreviewForHostKey) as bool? ?? true;
    _previewTopBarIsVisible =
        prefs.get(_cachePreviewTopBarIsVisibleKey) as bool? ?? true;
    _previewBottomBarIsVisible =
        prefs.get(_cachePreviewBottomBarIsVisibleKey) as bool? ?? true;
    _previewBottomBarShowBeautyEffectButton =
        prefs.get(_cachePreviewBottomBarShowBeautyEffectButtonKey) as bool? ??
            true;

    // PKBattle configurations
    _pkBattleUserReconnectingSecond =
        prefs.get(_cachePKBattleUserReconnectingSecondKey) as int? ?? 5;
    _pkBattleUserDisconnectedSecond =
        prefs.get(_cachePKBattleUserDisconnectedSecondKey) as int? ?? 90;
    _pkBattleTopPadding = prefs.get(_cachePKBattleTopPaddingKey) as double?;

    // ScreenSharing configurations
    _screenSharingAutoStopInvalidCount =
        prefs.get(_cacheScreenSharingAutoStopInvalidCountKey) as int? ?? 3;
    _screenSharingDefaultFullScreen =
        prefs.get(_cacheScreenSharingDefaultFullScreenKey) as bool? ?? false;

    // MediaPlayer configurations
    _mediaPlayerSupportTransparent =
        prefs.get(_cacheMediaPlayerSupportTransparentKey) as bool? ?? false;

    // PIP configurations
    _pipAspectWidth = prefs.get(_cachePipAspectWidthKey) as int? ?? 9;
    _pipAspectHeight = prefs.get(_cachePipAspectHeightKey) as int? ?? 16;
  }

  static List<String> defaultRoomIDList() {
    return List<String>.generate(5, (index) => '${100 + index}');
  }

  final String _cacheRoomIDListKey = 'cache_ls_room_id_list';
  final String _cacheLiveListMapKey = 'cache_ls_live_list_map';

  final String _cachePKAutoAcceptKey = 'cache_ls_pk_auto_accept';
  final String _cacheUseModulePrefixKey = 'cache_ls_use_module_prefix';

  final String _supportShowUserNameKey = 'cache_ls_show_user_name';
  final String _supportShowMicStateKey = 'cache_ls_show_mic_state';

  final String _supportMediaDefURLKey = 'cache_ls_media_def_url';
  final String _supportMediaAutoPlayKey = 'cache_ls_media_auto_play';

  final String _supportVideoModeKey = 'cache_ls_video_mode';
  final String _supportGiftKey = 'cache_ls_gift';
  final String _cacheStreamModeKey = 'cache_ls_stream_mode';

  final String _cacheStopCoHostingWhenMicCameraOffKey =
      'cache_ls_stop_co_hosting_when_mic_camera_off';
  final String _cacheDisableCoHostInvitationReceivedDialogKey =
      'cache_ls_disable_co_host_invitation_received_dialog';
  final String _cacheMaxCoHostCountKey = 'cache_ls_max_co_host_count';
  final String _cacheInviteTimeoutSecondKey = 'cache_ls_invite_timeout_second';
  final String _cacheSignalingPluginUninitOnDisposeKey =
      'cache_ls_signaling_plugin_uninit_on_dispose';
  final String _cacheSignalingPluginLeaveRoomOnDisposeKey =
      'cache_ls_signaling_plugin_leave_room_on_dispose';

  // Basic configurations keys
  final String _cacheTurnOnCameraWhenJoiningKey =
      'cache_ls_turn_on_camera_when_joining';
  final String _cacheUseFrontFacingCameraKey =
      'cache_ls_use_front_facing_camera';
  final String _cacheTurnOnMicrophoneWhenJoiningKey =
      'cache_ls_turn_on_microphone_when_joining';
  final String _cacheUseSpeakerWhenJoiningKey =
      'cache_ls_use_speaker_when_joining';
  final String _cacheRootNavigatorKey = 'cache_ls_root_navigator';
  final String _cacheMarkAsLargeRoomKey = 'cache_ls_mark_as_large_room';
  final String _cacheSlideSurfaceToHideKey = 'cache_ls_slide_surface_to_hide';
  final String _cacheShowBackgroundTipsKey = 'cache_ls_show_background_tips';
  final String _cacheShowToastKey = 'cache_ls_show_toast';

  // AudioVideoView configurations keys
  final String _cacheIsVideoMirrorKey = 'cache_ls_is_video_mirror';
  final String _cacheShowAvatarInAudioModeKey =
      'cache_ls_show_avatar_in_audio_mode';
  final String _cacheShowSoundWavesInAudioModeKey =
      'cache_ls_show_sound_waves_in_audio_mode';

  // TopMenuBar configurations keys
  final String _cacheShowCloseButtonKey = 'cache_ls_show_close_button';

  // BottomMenuBar configurations keys
  final String _cacheShowInRoomMessageButtonKey =
      'cache_ls_show_in_room_message_button';
  final String _cacheBottomMenuBarMaxCountKey =
      'cache_ls_bottom_menu_bar_max_count';

  // MemberList configurations keys
  final String _cacheShowFakeUserKey = 'cache_ls_show_fake_user';
  final String _cacheNotifyUserJoinKey = 'cache_ls_notify_user_join';
  final String _cacheNotifyUserLeaveKey = 'cache_ls_notify_user_leave';

  // InRoomMessage configurations keys
  final String _cacheInRoomMessageVisibleKey =
      'cache_ls_in_room_message_visible';
  final String _cacheShowFakeMessageKey = 'cache_ls_show_fake_message';
  final String _cacheInRoomMessageShowNameKey =
      'cache_ls_in_room_message_show_name';
  final String _cacheInRoomMessageShowAvatarKey =
      'cache_ls_in_room_message_show_avatar';
  final String _cacheInRoomMessageOpacityKey =
      'cache_ls_in_room_message_opacity';

  // Duration configurations keys
  final String _cacheDurationIsVisibleKey = 'cache_ls_duration_is_visible';

  // Preview configurations keys
  final String _cacheShowPreviewForHostKey = 'cache_ls_show_preview_for_host';
  final String _cachePreviewTopBarIsVisibleKey =
      'cache_ls_preview_top_bar_is_visible';
  final String _cachePreviewBottomBarIsVisibleKey =
      'cache_ls_preview_bottom_bar_is_visible';
  final String _cachePreviewBottomBarShowBeautyEffectButtonKey =
      'cache_ls_preview_bottom_bar_show_beauty_effect_button';

  // PKBattle configurations keys
  final String _cachePKBattleUserReconnectingSecondKey =
      'cache_ls_pk_battle_user_reconnecting_second';
  final String _cachePKBattleUserDisconnectedSecondKey =
      'cache_ls_pk_battle_user_disconnected_second';
  final String _cachePKBattleTopPaddingKey = 'cache_ls_pk_battle_top_padding';

  // ScreenSharing configurations keys
  final String _cacheScreenSharingAutoStopInvalidCountKey =
      'cache_ls_screen_sharing_auto_stop_invalid_count';
  final String _cacheScreenSharingDefaultFullScreenKey =
      'cache_ls_screen_sharing_default_full_screen';

  // MediaPlayer configurations keys
  final String _cacheMediaPlayerSupportTransparentKey =
      'cache_ls_media_player_support_transparent';

  // PIP configurations keys
  final String _cachePipAspectWidthKey = 'cache_ls_pip_aspect_width';
  final String _cachePipAspectHeightKey = 'cache_ls_pip_aspect_height';

  bool _isLoaded = false;

  LiveStreamingCache._internal();

  factory LiveStreamingCache() => _instance;

  static final LiveStreamingCache _instance = LiveStreamingCache._internal();
}
