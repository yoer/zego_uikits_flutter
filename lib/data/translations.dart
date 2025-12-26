// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';

class MyLocale {
  static Locale enUS = const Locale('en', 'US');
  static Locale zhCN = const Locale('zh', 'CN');
  static Locale hiIN = const Locale('hi', 'IN');
}

class Translations {
  static TranslationsLogin login = TranslationsLogin();
  static TranslationsTips tips = TranslationsTips();
  static TranslationsIntro intro = TranslationsIntro();
  static TranslationsTab tab = TranslationsTab();
  static TranslationsSettings settings = TranslationsSettings();
  static TranslationsDrawer drawer = TranslationsDrawer();
  static TranslationsFeedback feedback = TranslationsFeedback();
  static TranslationsStreamTest streamTest = TranslationsStreamTest();
  static TranslationsGift gift = TranslationsGift();
  static TranslationsLiveStreaming liveStreaming = TranslationsLiveStreaming();
  static TranslationsCall call = TranslationsCall();
  static TranslationsConference conference = TranslationsConference();
  static TranslationsAudioRoom audioRoom = TranslationsAudioRoom();
  static TranslationsChat chat = TranslationsChat();
}

class TranslationsLogin {
  String get base => 'login.';

  String get signIn => tr('${base}sign_in');

  String get signOut => tr('${base}sign_out');

  String get id => tr('${base}id');

  String get name => tr('${base}name');

  String get unknown => tr('${base}unknown');

  String get success => tr('${base}success');
}

class TranslationsTips {
  String get base => 'tips.';

  String get loadFailed => tr('${base}load_failed');

  String get error => tr('${base}error');

  String get errorCode => tr('${base}error_code');

  String get errorMsg => tr('${base}error_msg');

  String get appIDSign => tr('${base}app_id_sign');

  String get confirm => tr('${base}confirm');

  String get cancel => tr('${base}cancel');

  String get ok => tr('${base}ok');

  String get start => tr('${base}start');

  String get join => tr('${base}join');

  String get clearCacheSuccess => tr('${base}clear_cache_success');
}

class TranslationsGift {
  String get base => 'gift.';

  String get categoryBase => 'gift.category.';

  String get give => tr('${base}give');

  String received(String name) => tr('${base}received', args: [name]);

  String get categoryNormal => tr('${categoryBase}normal');

  String get categorySport => tr('${categoryBase}sport');

  String get categoryChildren => tr('${categoryBase}children');
}

class TranslationsIntro {
  String get base => 'intro.';

  String get skip => tr('${base}skip');

  String get done => tr('${base}done');

  String get enter => tr('${base}enter');

  String get title1v1Call => tr('${base}title_call_1v1');

  String get body1v1Call => tr('${base}body_call_1v1');

  String get titleGroupCall => tr('${base}title_call_group');

  String get bodyGroupCall => tr('${base}body_call_group');

  String get titleLiveStreaming => tr('${base}title_live_streaming');

  String get bodyLiveStreaming => tr('${base}body_live_streaming');

  String get titleAudioRoom => tr('${base}title_audio_room');

  String get bodyAudioRoom => tr('${base}body_audio_room');

  String get titleConference => tr('${base}title_conference');

  String get bodyConference => tr('${base}body_conference');

  String get titleIMKit => tr('${base}title_imkit');

  String get bodyIMKit => tr('${base}body_imkit');
}

class TranslationsTab {
  String get base => 'tab.';

  String get call => tr('${base}call');

  String get liveStreaming => tr('${base}live_streaming');

  String get audioRoom => tr('${base}audio_room');

  String get conference => tr('${base}conference');

  String get im => tr('${base}im');

  String get swipeTips => tr('${base}swipe_tips');
}

class TranslationsSettings {
  String get base => 'settings.';

  String get title => tr('${base}title');

  String get optional => tr('${base}optional');

  String get common => tr('${base}common');

  String get useFirestore => tr('${base}use_firestore');

  String get showSplash => tr('${base}show_splash');

  String get save => tr('${base}save');

  String get consoleURLTips => tr('${base}console_url_tips');

  String get copied => tr('${base}copied');

  String get copyURL => tr('${base}copyURL');

  String get visible => tr('${base}visible');

  String get seconds => tr('${base}seconds');

  String get row => tr('${base}row');

  String get column => tr('${base}column');

  String get url => tr('${base}url');

  String get support => tr('${base}support');

  String get autoPlay => tr('${base}auto_play');

  String get idTips => tr('${base}id_tips');

  String get starTips => tr('${base}star_tips');

  String get screenSharing => tr('${base}screen_sharing');

  String get calling => tr('${base}calling');

  String get inCall => tr('${base}in_call');

  String get mediaSharing => tr('${base}media_sharing');

  String get pip => tr('${base}pip');

  String get advanceBeauty => tr('${base}advance_beauty');

  String get videoAspectFill => tr('${base}video_aspect_fill');

  String get audioVideo => tr('${base}audio_video');

  String get showMicState => tr('${base}show_mic_state');

  String get showUserName => tr('${base}show_user_name');

  String get showVideoOnInviteeCall => tr('${base}show_video_on_invitee_call');

  String get uiShowAvatar => tr('${base}ui_show_avatar');

  String get uiShowCentralName => tr('${base}ui_show_central_name');

  String get uiShowCallingText => tr('${base}ui_show_calling_text');

  String get uiUseVideoViewAspectFill =>
      tr('${base}ui_use_video_view_aspect_fill');

  String get uiDefaultMicrophoneOn => tr('${base}ui_default_microphone_on');

  String get uiDefaultCameraOn => tr('${base}ui_default_camera_on');

  String get uiDefaultSpeakerOn => tr('${base}ui_default_speaker_on');

  String get uiShowMainButtonsText => tr('${base}ui_show_main_buttons_text');

  String get uiShowSubButtonsText => tr('${base}ui_show_sub_buttons_text');

  // minimized settings
  String get uiInviterMinimizedCancelButtonVisible =>
      tr('${base}ui_inviter_minimized_cancel_button_visible');

  String get uiInviterMinimizedShowTips =>
      tr('${base}ui_inviter_minimized_show_tips');

  String get uiInviteeMinimizedAcceptButtonVisible =>
      tr('${base}ui_invitee_minimized_accept_button_visible');

  String get uiInviteeMinimizedDeclineButtonVisible =>
      tr('${base}ui_invitee_minimized_decline_button_visible');

  String get uiInviteeMinimizedShowTips =>
      tr('${base}ui_invitee_minimized_show_tips');

  String get callListId => tr('${base}call_list_id');

  String get invitationAbout => tr('${base}invitation_about');

  String get invitationTimeout => tr('${base}invitation_timeout');

  String get resourceId => tr('${base}resource_id');

  String get missedNotification => tr('${base}missed_notification');

  String get missedNotificationRedial =>
      tr('${base}missed_notification_redial');

  String get callInCalling => tr('${base}call_in_calling');

  String get onlyInvitorCanInviteInCalling =>
      tr('${base}only_invitor_can_invite_in_calling');

  String get safeArea => tr('${base}safe_area');

  String get liveListId => tr('${base}live_list_id');

  String get liveListIdTips => tr('${base}live_list_id.tips');

  String get liveListIdHostID => tr('${base}live_list_id.host_id');

  String get liveListIdLiveID => tr('${base}live_list_id.live_id');

  String get liveListAxis => tr('${base}live_list.axis');

  String get liveListAxisCount => tr('${base}live_list.axis_count');

  String get pk => tr('${base}pk');

  String get pkAutoAccept => tr('${base}pk.auto_accept');

  String get useModulePrefix => tr('${base}use_module_prefix');

  String get streamMode => tr('${base}stream_mode');

  String get coHost => tr('${base}co_host');

  String get stopCoHostingWhenMicCameraOff =>
      tr('${base}co_host.stop_co_hosting_when_mic_camera_off');

  String get disableCoHostInvitationReceivedDialog =>
      tr('${base}co_host.disable_invitation_received_dialog');

  String get maxCoHostCount => tr('${base}co_host.max_co_host_count');

  String get inviteTimeoutSecond => tr('${base}co_host.invite_timeout_second');

  String get signalingPlugin => tr('${base}signaling_plugin');

  String get signalingPluginUninitOnDispose =>
      tr('${base}signaling_plugin.uninit_on_dispose');

  String get signalingPluginLeaveRoomOnDispose =>
      tr('${base}signaling_plugin.leave_room_on_dispose');

  // Basic configurations
  String get basic => tr('${base}basic');

  String get turnOnCameraWhenJoining =>
      tr('${base}turn_on_camera_when_joining');

  String get useFrontFacingCamera => tr('${base}use_front_facing_camera');

  String get turnOnMicrophoneWhenJoining =>
      tr('${base}turn_on_microphone_when_joining');

  String get useSpeakerWhenJoining => tr('${base}use_speaker_when_joining');

  String get rootNavigator => tr('${base}root_navigator');

  String get enableAccidentalTouchPrevention =>
      tr('${base}enable_accidental_touch_prevention');

  String get markAsLargeRoom => tr('${base}mark_as_large_room');

  String get slideSurfaceToHide => tr('${base}slide_surface_to_hide');

  String get showBackgroundTips => tr('${base}show_background_tips');

  String get showToast => tr('${base}show_toast');

  // AudioVideoView configurations
  String get isVideoMirror => tr('${base}is_video_mirror');

  String get showMicrophoneStateOnView =>
      tr('${base}show_microphone_state_on_view');

  String get showCameraStateOnView => tr('${base}show_camera_state_on_view');

  String get showUserNameOnView => tr('${base}show_user_name_on_view');

  String get showOnlyCameraMicrophoneOpened =>
      tr('${base}show_only_camera_microphone_opened');

  String get showLocalUser => tr('${base}show_local_user');

  String get showWaitingCallAcceptAudioVideoView =>
      tr('${base}show_waiting_call_accept_audio_video_view');

  String get showAvatarInAudioMode => tr('${base}show_avatar_in_audio_mode');

  String get showSoundWavesInAudioMode =>
      tr('${base}show_sound_waves_in_audio_mode');

  // TopMenuBar configurations
  String get topMenuBar => tr('${base}top_menu_bar');

  String get hideAutomatically => tr('${base}hide_automatically');

  String get hideByClick => tr('${base}hide_by_click');

  String get showCloseButton => tr('${base}show_close_button');

  // BottomMenuBar configurations
  String get bottomMenuBar => tr('${base}bottom_menu_bar');

  String get showInRoomMessageButton =>
      tr('${base}show_in_room_message_button');

  String get bottomMenuBarMaxCount => tr('${base}bottom_menu_bar_max_count');

  // MemberList configurations
  String get memberList => tr('${base}member_list');

  String get showCameraState => tr('${base}show_camera_state');

  String get showFakeUser => tr('${base}show_fake_user');

  String get notifyUserJoin => tr('${base}notify_user_join');

  String get notifyUserLeave => tr('${base}notify_user_leave');

  // InRoomMessage configurations
  String get inRoomMessage => tr('${base}in_room_message');

  String get inRoomMessageVisible => tr('${base}in_room_message.visible');

  String get showFakeMessage => tr('${base}in_room_message.show_fake_message');

  String get inRoomMessageShowName => tr('${base}in_room_message.show_name');

  String get inRoomMessageShowAvatar =>
      tr('${base}in_room_message.show_avatar');

  String get inRoomMessageOpacity => tr('${base}in_room_message.opacity');

  // Duration configurations
  String get durationIsVisible => tr('${base}duration.is_visible');

  // Preview configurations
  String get preview => tr('${base}preview');

  String get showPreviewForHost => tr('${base}preview.show_preview_for_host');

  String get previewTopBarIsVisible => tr('${base}preview.top_bar_is_visible');

  String get previewBottomBarIsVisible =>
      tr('${base}preview.bottom_bar_is_visible');

  String get previewBottomBarShowBeautyEffectButton =>
      tr('${base}preview.bottom_bar_show_beauty_effect_button');

  // PKBattle configurations
  String get pkBattleUserReconnectingSecond =>
      tr('${base}pk.user_reconnecting_second');

  String get pkBattleUserDisconnectedSecond =>
      tr('${base}pk.user_disconnected_second');

  String get pkBattleTopPadding => tr('${base}pk.top_padding');

  String get pkCustomLayout => tr('${base}pk.custom_layout');

  // ScreenSharing configurations
  String get screenSharingAutoStopInvalidCount =>
      tr('${base}screen_sharing.auto_stop_invalid_count');

  String get screenSharingDefaultFullScreen =>
      tr('${base}screen_sharing.default_full_screen');

  // MediaPlayer configurations
  String get mediaPlayer => tr('${base}media_player');

  String get mediaPlayerSupportTransparent =>
      tr('${base}media_player.support_transparent');

  // PIP configurations
  String get pipAspectWidth => tr('${base}pip.aspect_width');

  String get pipAspectHeight => tr('${base}pip.aspect_height');

  String get pipEnableWhenBackground => tr('${base}pip.enable_when_background');

  String get pipIOSSupport => tr('${base}pip.ios_support');

  String get audioListId => tr('${base}audio_list_id');

  String get seat => tr('${base}seat');

  String get layoutMode => tr('${base}layout_mode');

  String get showBackground => tr('${base}show_background');

  String get showHostInfo => tr('${base}show_host_info');

  String get duration => tr('${base}duration');

  String get autoHangUp => tr('${base}duration.auto_hang_up');

  String get durationEndTips => tr('${base}duration.end_tips');

  String durationSecondTips(int seconds) =>
      tr('${base}duration.seconds_tips', args: [seconds.toString()]);

  String get conferenceListId => tr('${base}conference_list_id');

  String get others => tr('${base}others');

  String get enableDebugToast => tr('${base}enable_debug_toast');

  String get enableDebugMode => tr('${base}enable_debug_mode');

  String get audioRouteChanged => tr('${base}audio_route_changed');

  // RequiredUser configurations
  String get requiredUser => tr('${base}required_user');

  String get requiredUserEnabled => tr('${base}required_user.enabled');

  String get requiredUserDetectSeconds =>
      tr('${base}required_user.detect_seconds');

  String get requiredUserDetectInDebugMode =>
      tr('${base}required_user.detect_in_debug_mode');

  // Invitation configurations
  String get endCallWhenInitiatorLeave =>
      tr('${base}end_call_when_initiator_leave');

  String get offlineAutoEnterAcceptedOfflineCall =>
      tr('${base}offline_auto_enter_accepted_offline_call');

  // AudioRoom Seat configurations
  String get seatCloseWhenJoining => tr('${base}seat.close_when_joining');

  String get seatShowSoundWaveInAudioMode =>
      tr('${base}seat.show_sound_wave_in_audio_mode');

  String get seatKeepOriginalForeground =>
      tr('${base}seat.keep_original_foreground');

  // AudioRoom InRoomMessage configurations
  String get inRoomMessageWidth => tr('${base}in_room_message.width');

  String get inRoomMessageHeight => tr('${base}in_room_message.height');

  // AudioRoom PIP configurations
  String get pipAndroidShowUserName => tr('${base}pip.android_show_user_name');

  // AudioRoom MediaPlayer configurations
  String get mediaPlayerDefaultPlayerSupport =>
      tr('${base}media_player.default_player_support');

  // AudioRoom BackgroundMedia configurations
  String get backgroundMedia => tr('${base}background_media');

  String get backgroundMediaPath => tr('${base}background_media.path');

  String get backgroundMediaEnableRepeat =>
      tr('${base}background_media.enable_repeat');

  // Conference AudioVideoViewConfig configurations
  String get muteInvisible => tr('${base}mute_invisible');

  // Conference TopMenuBarConfig configurations
  String get topMenuBarTitle => tr('${base}top_menu_bar.title');

  String get topMenuBarStyle => tr('${base}top_menu_bar.style');

  // Conference BottomMenuBarConfig configurations
  String get bottomMenuBarStyle => tr('${base}bottom_menu_bar.style');

  // Conference MemberListConfig configurations
  String get memberListShowMicrophoneState =>
      tr('${base}member_list.show_microphone_state');

  String get memberListShowCameraState =>
      tr('${base}member_list.show_camera_state');

  // Conference NotificationViewConfig configurations
  String get notificationView => tr('${base}notification_view');

  String get notificationViewNotifyUserLeave =>
      tr('${base}notification_view.notify_user_leave');

  // Conference DurationConfig configurations
  String get durationCanSync => tr('${base}duration.can_sync');
}

class TranslationsDrawer {
  String get base => 'drawer.';

  String get wallet => tr('${base}wallet');

  String get language => tr('${base}language');

  String get signOut => tr('${base}sign_out');

  String get about => tr('${base}about');

  String get feedback => tr('${base}feedback');

  String get shareLogs => tr('${base}share_logs');

  String get streamTest => tr('${base}stream_test');

  String get clear => tr('${base}clear');
}

class TranslationsFeedback {
  String get base => 'feedback.';

  String get title => tr('${base}title');

  String get content => tr('${base}content');

  String get contact => tr('${base}contact');

  String get addLogs => tr('${base}addLogs');

  String get button => tr('${base}button');

  String get thankYou => tr('${base}thankYou');

  String get sent => tr('${base}sent');

  String get sendMethod => tr('${base}send_method');

  String get systemShare => tr('${base}system_share');

  String get systemShareDesc => tr('${base}system_share_desc');

  String get emailSend => tr('${base}email_send');

  String get emailSendDesc => tr('${base}email_send_desc');

  String get shareFeedback => tr('${base}share_feedback');

  String get sendEmail => tr('${base}send_email');

  String get shareFailed => tr('${base}share_failed');

  String get feedbackDefault => tr('${base}feedback_default');

  String logsWithParts(int parts) =>
      tr('${base}logs_with_parts', args: [parts.toString()]);
}

class TranslationsStreamTest {
  String get base => 'stream_test.';

  String get title => tr('${base}title');

  String get roomSettings => tr('${base}room_settings');

  String get roomId => tr('${base}room_id');

  String get userId => tr('${base}user_id');

  String get userName => tr('${base}user_name');

  String get streamId => tr('${base}stream_id');

  String get joinRoom => tr('${base}join_room');

  String get pleaseFillFields => tr('${base}please_fill_fields');

  String get roomInfo => tr('${base}room_info');

  String get userInfo => tr('${base}user_info');

  String get streamInfo => tr('${base}stream_info');

  String get joinedSuccessfully => tr('${base}joined_successfully');

  String get failedToJoin => tr('${base}failed_to_join');

  String get leftSuccessfully => tr('${base}left_successfully');

  String get failedToLeave => tr('${base}failed_to_leave');

  String get cameraSettings => tr('${base}camera_settings');

  String get microphoneSettings => tr('${base}microphone_settings');

  String get turnOnCamera => tr('${base}turn_on_camera');

  String get turnOnMicrophone => tr('${base}turn_on_microphone');

  String get localStream => tr('${base}local_stream');

  String get remoteStream => tr('${base}remote_stream');

  String get localUserId => tr('${base}local_user_id');

  String get localUserName => tr('${base}local_user_name');

  String get localStreamId => tr('${base}local_stream_id');

  String get remoteUserId => tr('${base}remote_user_id');

  String get remoteUserName => tr('${base}remote_user_name');

  String get remoteStreamId => tr('${base}remote_stream_id');
}

class TranslationsLiveStreaming {
  String get base => 'live.';

  String get enterLive => tr('${base}enter_live');

  String get title => tr('${base}title');

  String get roomListEmptyTips => tr('${base}room_list.empty_tips');

  String get liveListTitle => tr('${base}live_list.title');

  String get liveListEmptyTips => tr('${base}live_list.empty_tips');

  String get swipingTitle => tr('${base}swiping.title');

  String swipingJoinTips(String liveID) =>
      tr('${base}swiping.join_tips', args: [liveID]);

  String get pkTitle => tr('${base}pk.title');

  String get hostListTitle => tr('${base}pk.host_list_title');

  String get pkHostEmptyTips => tr('${base}pk.host_empty_tips');

  String get endPK => tr('${base}pk.end');

  String get quitPK => tr('${base}pk.quit');

  String get invitePK => tr('${base}pk.invite');

  String get manualInputTips => tr('${base}pk.manual_input_tips');

  String get hostIdPlaceholder => tr('${base}pk.host_id_placeholder');

  String get sendInvite => tr('${base}pk.send_invite');

  String get inviteSent => tr('${base}pk.invite_sent');

  String get pleaseEnterHostId => tr('${base}pk.please_enter_host_id');

  String get mediaSharingTitle => tr('${base}media_sharing.title');

  String get clickToEnterLive => tr('${base}click_to_enter_live');

  String get living => tr('${base}living');
}

class TranslationsCall {
  String get base => 'call.';

  String get invitationTitle => tr('${base}invitation.title');

  String get oneOnOneTitle => tr('${base}one_on_one.title');

  String get groupTitle => tr('${base}group.title');

  String get contactsTitle => tr('${base}contacts.title');

  String get contactsEmptyTips => tr('${base}contacts.empty_tips');
}

class TranslationsConference {
  String get base => 'conference.';

  String get title => tr('${base}title');
}

class TranslationsAudioRoom {
  String get base => 'audio_room.';

  String get title => tr('${base}title');

  String get mediaSharingTitle => tr('${base}media_sharing.title');
}

class TranslationsChat {
  String get base => 'chat.';

  String get title => tr('${base}title');

  String get addMember => tr('${base}add_member');

  String get removeMember => tr('${base}remove_member');

  String get memberList => tr('${base}member_list');

  String get leaveGroup => tr('${base}leave_group');

  String get disbandGroup => tr('${base}disband_group');

  String get leaveTips => tr('${base}leave_tips');

  String get delete => tr('${base}delete');

  String get revoke => tr('${base}revoke');

  String get newChat => tr('${base}new_chat');

  String get newGroup => tr('${base}new_group');

  String get joinGroup => tr('${base}join_group');

  String get deleteAll => tr('${base}delete_all');

  String get removeUser => tr('${base}remove_user');

  String get groupName => tr('${base}group_name');

  String get groupIdPlaceHolder => tr('${base}group_id_place_holder');

  String get userIdsPlaceHolder => tr('${base}user_ids_place_holder');

  String get userIdsTips => tr('${base}user_ids_tips');
}
