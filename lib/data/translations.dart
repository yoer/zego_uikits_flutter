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
  String get mediaSharing => tr('${base}media_sharing');
  String get pip => tr('${base}pip');
  String get advanceBeauty => tr('${base}advance_beauty');
  String get videoAspectFill => tr('${base}video_aspect_fill');
  String get audioVideo => tr('${base}audio_video');
  String get showMicState => tr('${base}show_mic_state');
  String get showUserName => tr('${base}show_user_name');
  String get turnOnCameraWhenJoining =>
      tr('${base}turn_on_camera_when_joining');
  String get turnOnMicrophoneWhenJoining =>
      tr('${base}turn_on_mic_when_joining');
  String get useSpeakerWhenJoining => tr('${base}use_speaker_when_joining');

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

  String get liveListId => tr('${base}live_list_id');
  String get liveListIdTips => tr('${base}live_list_id.tips');
  String get liveListIdHostID => tr('${base}live_list_id.host_id');
  String get liveListIdLiveID => tr('${base}live_list_id.live_id');
  String get liveListAxis => tr('${base}live_list.axis');
  String get liveListAxisCount => tr('${base}live_list.axis_count');
  String get pk => tr('${base}pk');
  String get pkAutoAccept => tr('${base}pk.auto_accept');

  String get audioListId => tr('${base}audio_list_id');
  String get seat => tr('${base}seat');
  String get layoutMode => tr('${base}layout_mode');
  String get showBackground => tr('${base}show_background');
  String get showHostInfo => tr('${base}show_host_info');

  String get duration => tr('${base}duration');
  String get autoHangUp => tr('${base}duration.auto_hang_up');
  String get durationEndTips => tr('${base}duration.end_tips');
  String durationSecondTips(int seconds) => tr(
        '${base}duration.seconds_tips',
        args: [seconds.toString()],
      );

  String get conferenceListId => tr('${base}conference_list_id');
}

class TranslationsDrawer {
  String get base => 'drawer.';
  String get wallet => tr('${base}wallet');
  String get language => tr('${base}language');
  String get signOut => tr('${base}sign_out');
  String get about => tr('${base}about');
  String get feedback => tr('${base}feedback');
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

  String get mediaSharingTitle => tr('${base}media_sharing.title');
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
