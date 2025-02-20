// Dart imports:
import 'dart:ui';

// Package imports:
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

// Project imports:
import 'package:zego_uikits_demo/data/translations.dart';

class CallInvitationInnerText {
  static ZegoCallInvitationInnerText current(Locale locale) {
    if (locale.languageCode == MyLocale.enUS.languageCode) {
      return CallInvitationInnerText.english;
    } else if (locale.languageCode == MyLocale.zhCN.languageCode) {
      return CallInvitationInnerText.chinese;
    } else if (locale.languageCode == MyLocale.hiIN.languageCode) {
      return CallInvitationInnerText.hindi;
    }

    return CallInvitationInnerText.english;
  }

  static ZegoCallInvitationInnerText get english {
    var innerText = ZegoCallInvitationInnerText();

    innerText.incomingVideoCallDialogTitle = param_1;
    innerText.incomingVideoCallDialogMessage = "Incoming video call...";
    innerText.incomingVoiceCallDialogTitle = param_1;
    innerText.incomingVoiceCallDialogMessage = "Incoming voice call...";
    innerText.incomingVideoCallPageTitle = param_1;
    innerText.incomingVideoCallPageMessage = "Incoming video call...";
    innerText.incomingVoiceCallPageTitle = param_1;
    innerText.incomingVoiceCallPageMessage = "Incoming voice call...";
    innerText.outgoingVideoCallPageTitle = param_1;
    innerText.outgoingVideoCallPageMessage = "Calling...";
    innerText.outgoingVoiceCallPageTitle = param_1;
    innerText.outgoingVoiceCallPageMessage = "Calling...";
    innerText.incomingGroupVideoCallDialogTitle = param_1;
    innerText.incomingGroupVideoCallDialogMessage =
        "Incoming group video call...";
    innerText.incomingGroupVoiceCallDialogTitle = param_1;
    innerText.incomingGroupVoiceCallDialogMessage =
        "Incoming group voice call...";
    innerText.incomingGroupVideoCallPageTitle = param_1;
    innerText.incomingGroupVideoCallPageMessage =
        "Incoming group video call...";
    innerText.incomingGroupVoiceCallPageTitle = param_1;
    innerText.incomingGroupVoiceCallPageMessage =
        "Incoming group voice call...";
    innerText.outgoingGroupVideoCallPageTitle = param_1;
    innerText.outgoingGroupVideoCallPageMessage = "Calling...";
    innerText.outgoingGroupVoiceCallPageTitle = param_1;
    innerText.outgoingGroupVoiceCallPageMessage = "Calling...";
    innerText.incomingCallPageDeclineButton = "Decline";
    innerText.incomingCallPageAcceptButton = "Accept";
    innerText.outgoingCallPageACancelButton = "Cancel";
    innerText.missedCallNotificationTitle = "Missed Call";
    innerText.missedGroupVideoCallNotificationContent = "Group Video Call";
    innerText.missedGroupAudioCallNotificationContent = "Group Audio Call";
    innerText.missedVideoCallNotificationContent = "Video Call";
    innerText.missedAudioCallNotificationContent = "Audio Call";
    innerText.permissionConfirmDialogTitle = 'Allow $param_1 to';
    innerText.permissionConfirmDialogAllowButton = "Allow";
    innerText.permissionConfirmDialogDenyButton = "Deny";

    return innerText;
  }

  static ZegoCallInvitationInnerText get chinese {
    var innerText = ZegoCallInvitationInnerText();

    innerText.incomingVideoCallDialogTitle = param_1;
    innerText.incomingVideoCallDialogMessage = "来电视频通话...";
    innerText.incomingVoiceCallDialogTitle = param_1;
    innerText.incomingVoiceCallDialogMessage = "来电语音通话...";
    innerText.incomingVideoCallPageTitle = param_1;
    innerText.incomingVideoCallPageMessage = "来电视频通话...";
    innerText.incomingVoiceCallPageTitle = param_1;
    innerText.incomingVoiceCallPageMessage = "来电语音通话...";
    innerText.outgoingVideoCallPageTitle = param_1;
    innerText.outgoingVideoCallPageMessage = "拨打中...";
    innerText.outgoingVoiceCallPageTitle = param_1;
    innerText.outgoingVoiceCallPageMessage = "拨打中...";
    innerText.incomingGroupVideoCallDialogTitle = param_1;
    innerText.incomingGroupVideoCallDialogMessage = "来电群组视频通话...";
    innerText.incomingGroupVoiceCallDialogTitle = param_1;
    innerText.incomingGroupVoiceCallDialogMessage = "来电群组语音通话...";
    innerText.incomingGroupVideoCallPageTitle = param_1;
    innerText.incomingGroupVideoCallPageMessage = "来电群组视频通话...";
    innerText.incomingGroupVoiceCallPageTitle = param_1;
    innerText.incomingGroupVoiceCallPageMessage = "来电群组语音通话...";
    innerText.outgoingGroupVideoCallPageTitle = param_1;
    innerText.outgoingGroupVideoCallPageMessage = "拨打中...";
    innerText.outgoingGroupVoiceCallPageTitle = param_1;
    innerText.outgoingGroupVoiceCallPageMessage = "拨打中...";
    innerText.incomingCallPageDeclineButton = "拒绝";
    innerText.incomingCallPageAcceptButton = "接受";
    innerText.outgoingCallPageACancelButton = "取消";
    innerText.missedCallNotificationTitle = "未接来电";
    innerText.missedGroupVideoCallNotificationContent = "群组视频通话";
    innerText.missedGroupAudioCallNotificationContent = "群组音频通话";
    innerText.missedVideoCallNotificationContent = "视频通话";
    innerText.missedAudioCallNotificationContent = "音频通话";
    innerText.permissionConfirmDialogTitle = '允许 $param_1 进行';
    innerText.permissionConfirmDialogAllowButton = "允许";
    innerText.permissionConfirmDialogDenyButton = "拒绝";

    return innerText;
  }

  static ZegoCallInvitationInnerText get hindi {
    var innerText = ZegoCallInvitationInnerText();

    innerText.incomingVideoCallDialogTitle = param_1;
    innerText.incomingVideoCallDialogMessage = "आ रहा है वीडियो कॉल...";
    innerText.incomingVoiceCallDialogTitle = param_1;
    innerText.incomingVoiceCallDialogMessage = "आ रहा है वॉयस कॉल...";
    innerText.incomingVideoCallPageTitle = param_1;
    innerText.incomingVideoCallPageMessage = "आ रहा है वीडियो कॉल...";
    innerText.incomingVoiceCallPageTitle = param_1;
    innerText.incomingVoiceCallPageMessage = "आ रहा है वॉयस कॉल...";
    innerText.outgoingVideoCallPageTitle = param_1;
    innerText.outgoingVideoCallPageMessage = "कॉल कर रहे हैं...";
    innerText.outgoingVoiceCallPageTitle = param_1;
    innerText.outgoingVoiceCallPageMessage = "कॉल कर रहे हैं...";
    innerText.incomingGroupVideoCallDialogTitle = param_1;
    innerText.incomingGroupVideoCallDialogMessage =
        "आ रहा है समूह वीडियो कॉल...";
    innerText.incomingGroupVoiceCallDialogTitle = param_1;
    innerText.incomingGroupVoiceCallDialogMessage = "आ रहा है समूह वॉयस कॉल...";
    innerText.incomingGroupVideoCallPageTitle = param_1;
    innerText.incomingGroupVideoCallPageMessage = "आ रहा है समूह वीडियो कॉल...";
    innerText.incomingGroupVoiceCallPageTitle = param_1;
    innerText.incomingGroupVoiceCallPageMessage = "आ रहा है समूह वॉयस कॉल...";
    innerText.outgoingGroupVideoCallPageTitle = param_1;
    innerText.outgoingGroupVideoCallPageMessage = "कॉल कर रहे हैं...";
    innerText.outgoingGroupVoiceCallPageTitle = param_1;
    innerText.outgoingGroupVoiceCallPageMessage = "कॉल कर रहे हैं...";
    innerText.incomingCallPageDeclineButton = "अस्वीकृत करें";
    innerText.incomingCallPageAcceptButton = "स्वीकार करें";
    innerText.outgoingCallPageACancelButton = "रद्द करें";
    innerText.missedCallNotificationTitle = "अनुपस्थित कॉल";
    innerText.missedGroupVideoCallNotificationContent = "समूह वीडियो कॉल";
    innerText.missedGroupAudioCallNotificationContent = "समूह ऑडियो कॉल";
    innerText.missedVideoCallNotificationContent = "वीडियो कॉल";
    innerText.missedAudioCallNotificationContent = "ऑडियो कॉल";
    innerText.permissionConfirmDialogTitle = 'अनुमति दें $param_1 को';
    innerText.permissionConfirmDialogAllowButton = "अनुमति दें";
    innerText.permissionConfirmDialogDenyButton = "अस्वीकृत करें";

    return innerText;
  }
}

class CallInnerText {
  static ZegoUIKitPrebuiltCallInnerText current(Locale locale) {
    if (locale.languageCode == MyLocale.enUS.languageCode) {
      return CallInnerText.english;
    } else if (locale.languageCode == MyLocale.zhCN.languageCode) {
      return CallInnerText.chinese;
    } else if (locale.languageCode == MyLocale.hiIN.languageCode) {
      return CallInnerText.hindi;
    }

    return CallInnerText.english;
  }

  static ZegoUIKitPrebuiltCallInnerText get english {
    var innerText = ZegoUIKitPrebuiltCallInnerText();

    innerText.audioEffectTitle = "Audio effects";
    innerText.audioEffectReverbTitle = "Reverb";
    innerText.audioEffectVoiceChangingTitle = "Voice changing";
    innerText.voiceChangerNoneTitle = "None";
    innerText.voiceChangerLittleBoyTitle = "Little Boy";
    innerText.voiceChangerLittleGirlTitle = "Little Girl";
    innerText.voiceChangerDeepTitle = "Deep";
    innerText.voiceChangerCrystalClearTitle = "Crystal-clear";
    innerText.voiceChangerRobotTitle = "Robot";
    innerText.voiceChangerEtherealTitle = "Ethereal";
    innerText.voiceChangerFemaleTitle = "Female";
    innerText.voiceChangerMaleTitle = "Male";
    innerText.voiceChangerOptimusPrimeTitle = "Optimus Prime";
    innerText.voiceChangerCMajorTitle = "C Major";
    innerText.voiceChangerAMajorTitle = "A Major";
    innerText.voiceChangerHarmonicMinorTitle = "Harmonic minor";
    innerText.reverbTypeNoneTitle = "None";
    innerText.reverbTypeKTVTitle = "Karaoke";
    innerText.reverbTypeHallTitle = "Hall";
    innerText.reverbTypeConcertTitle = "Concert";
    innerText.reverbTypeRockTitle = "Rock";
    innerText.reverbTypeSmallRoomTitle = "Small room";
    innerText.reverbTypeLargeRoomTitle = "Large room";
    innerText.reverbTypeValleyTitle = "Valley";
    innerText.reverbTypeRecordingStudioTitle = "Recording studio";
    innerText.reverbTypeBasementTitle = "Basement";
    innerText.reverbTypePopularTitle = "Pop";
    innerText.reverbTypeGramophoneTitle = "Gramophone";

    return innerText;
  }

  static ZegoUIKitPrebuiltCallInnerText get chinese {
    var innerText = ZegoUIKitPrebuiltCallInnerText();

    innerText.audioEffectTitle = "音效";
    innerText.audioEffectReverbTitle = "混响";
    innerText.audioEffectVoiceChangingTitle = "变声";
    innerText.voiceChangerNoneTitle = "无";
    innerText.voiceChangerLittleBoyTitle = "小男孩";
    innerText.voiceChangerLittleGirlTitle = "小女孩";
    innerText.voiceChangerDeepTitle = "低沉";
    innerText.voiceChangerCrystalClearTitle = "清晰";
    innerText.voiceChangerRobotTitle = "机器人";
    innerText.voiceChangerEtherealTitle = "空灵";
    innerText.voiceChangerFemaleTitle = "女性";
    innerText.voiceChangerMaleTitle = "男性";
    innerText.voiceChangerOptimusPrimeTitle = "擎天柱";
    innerText.voiceChangerCMajorTitle = "C大调";
    innerText.voiceChangerAMajorTitle = "A大调";
    innerText.voiceChangerHarmonicMinorTitle = "和声小调";
    innerText.reverbTypeNoneTitle = "无";
    innerText.reverbTypeKTVTitle = "KTV";
    innerText.reverbTypeHallTitle = "大厅";
    innerText.reverbTypeConcertTitle = "音乐会";
    innerText.reverbTypeRockTitle = "摇滚";
    innerText.reverbTypeSmallRoomTitle = "小房间";
    innerText.reverbTypeLargeRoomTitle = "大房间";
    innerText.reverbTypeValleyTitle = "山谷";
    innerText.reverbTypeRecordingStudioTitle = "录音室";
    innerText.reverbTypeBasementTitle = "地下室";
    innerText.reverbTypePopularTitle = "流行";
    innerText.reverbTypeGramophoneTitle = "留声机";

    return innerText;
  }

  static ZegoUIKitPrebuiltCallInnerText get hindi {
    var innerText = ZegoUIKitPrebuiltCallInnerText();

    innerText.audioEffectTitle = "ऑडियो प्रभाव";
    innerText.audioEffectReverbTitle = "गूंज";
    innerText.audioEffectVoiceChangingTitle = "स्वर परिवर्तन";
    innerText.voiceChangerNoneTitle = "कोई नहीं";
    innerText.voiceChangerLittleBoyTitle = "छोटा लड़का";
    innerText.voiceChangerLittleGirlTitle = "छोटी लड़की";
    innerText.voiceChangerDeepTitle = "गहरा";
    innerText.voiceChangerCrystalClearTitle = "स्पष्ट";
    innerText.voiceChangerRobotTitle = "रोबोट";
    innerText.voiceChangerEtherealTitle = "एथेरियल";
    innerText.voiceChangerFemaleTitle = "महिला";
    innerText.voiceChangerMaleTitle = "पुरुष";
    innerText.voiceChangerOptimusPrimeTitle = "ऑप्टिमस प्राइम";
    innerText.voiceChangerCMajorTitle = "C मेजर";
    innerText.voiceChangerAMajorTitle = "A मेजर";
    innerText.voiceChangerHarmonicMinorTitle = "हार्मोनिक माइनर";
    innerText.reverbTypeNoneTitle = "कोई नहीं";
    innerText.reverbTypeKTVTitle = "KTV";
    innerText.reverbTypeHallTitle = "हॉल";
    innerText.reverbTypeConcertTitle = "कॉन्सर्ट";
    innerText.reverbTypeRockTitle = "रॉक";
    innerText.reverbTypeSmallRoomTitle = "छोटा कमरा";
    innerText.reverbTypeLargeRoomTitle = "बड़ा कमरा";
    innerText.reverbTypeValleyTitle = "घाटी";
    innerText.reverbTypeRecordingStudioTitle = "रिकॉर्डिंग स्टूडियो";
    innerText.reverbTypeBasementTitle = "बेसमेंट";
    innerText.reverbTypePopularTitle = "पॉप";
    innerText.reverbTypeGramophoneTitle = "ग्रामोफोन";

    return innerText;
  }
}
