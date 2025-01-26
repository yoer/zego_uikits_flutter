// Dart imports:
import 'dart:ui';

// Package imports:
import 'package:zego_uikit_prebuilt_live_audio_room/zego_uikit_prebuilt_live_audio_room.dart';

// Project imports:
import 'package:zego_uikits_demo/data/translations.dart';

class AudioRoomInnerText {
  static ZegoUIKitPrebuiltLiveAudioRoomInnerText current(Locale locale) {
    if (locale.languageCode == MyLocale.enUS.languageCode) {
      return AudioRoomInnerText.english;
    } else if (locale.languageCode == MyLocale.zhCN.languageCode) {
      return AudioRoomInnerText.chinese;
    } else if (locale.languageCode == MyLocale.hiIN.languageCode) {
      return AudioRoomInnerText.hindi;
    }

    return AudioRoomInnerText.english;
  }

  static ZegoLiveAudioRoomDialogInfo currentConfirmDialogInfo(Locale locale) {
    if (locale.languageCode == MyLocale.zhCN.languageCode) {
      return ZegoLiveAudioRoomDialogInfo(
        title: '',
        message: '确认离开房间?',
        cancelButtonName: '取消',
        confirmButtonName: '离开',
      );
    } else if (locale.languageCode == MyLocale.hiIN.languageCode) {
      return ZegoLiveAudioRoomDialogInfo(
        title: '',
        message: 'क्या आप कमरे छोड़ने की पुष्टि करते हैं?',
        cancelButtonName: 'रद्द करें',
        confirmButtonName: 'छोड़ें',
      );
    }

    return ZegoLiveAudioRoomDialogInfo(
      title: '',
      message: 'Are you sure to leave the room?',
      cancelButtonName: 'Cancel',
      confirmButtonName: 'OK',
    );
  }

  static ZegoUIKitPrebuiltLiveAudioRoomInnerText get english {
    var innerText = ZegoUIKitPrebuiltLiveAudioRoomInnerText();

    innerText.takeSeatMenuButton = "Take the seat";
    innerText.switchSeatMenuButton = "Switch the seat";
    innerText.removeSpeakerMenuDialogButton =
        "Remove ${innerText.param_1} from seat";
    innerText.muteSpeakerMenuDialogButton = "Mute ${innerText.param_1}";
    innerText.cancelMenuDialogButton = "Cancel";
    innerText.removeUserMenuDialogButton =
        "Remove ${innerText.param_1} from the room";
    innerText.memberListTitle = "Audience";
    innerText.memberListRoleYou = "You";
    innerText.memberListRoleHost = "Host";
    innerText.memberListRoleSpeaker = "Speaker";
    innerText.removeSpeakerFailedToast =
        "Failed to remove ${innerText.param_1} from seat";
    innerText.messageEmptyToast = "Say something...";
    innerText.cameraPermissionSettingDialogInfo = ZegoLiveAudioRoomDialogInfo(
      title: "Can not use Camera!",
      message: "Please enable camera access in the system settings!",
      cancelButtonName: "Cancel",
      confirmButtonName: "Settings",
    );
    innerText.microphonePermissionSettingDialogInfo =
        ZegoLiveAudioRoomDialogInfo(
      title: "Can not use Microphone!",
      message: "Please enable microphone access in the system settings!",
      cancelButtonName: "Cancel",
      confirmButtonName: "Settings",
    );
    innerText.removeFromSeatDialogInfo = ZegoLiveAudioRoomDialogInfo(
      title: "Remove the speaker",
      message: "Are you sure to remove ${innerText.param_1} from the seat?",
      cancelButtonName: "Cancel",
      confirmButtonName: "OK",
    );
    innerText.leaveSeatDialogInfo = ZegoLiveAudioRoomDialogInfo(
      title: "Leave the seat",
      message: "Are you sure to leave seat?",
      cancelButtonName: "Cancel",
      confirmButtonName: "OK",
    );
    innerText.applyToTakeSeatButton = "Apply to take seat";
    innerText.cancelTheTakeSeatApplicationButton = "Cancel";
    innerText.memberListAgreeButton = "Agree";
    innerText.memberListDisagreeButton = "Disagree";
    innerText.inviteToTakeSeatMenuDialogButton =
        "Invite ${innerText.param_1} to take seat";
    innerText.hostInviteTakeSeatDialog = ZegoLiveAudioRoomDialogInfo(
      title: "Invitation",
      message: "The host is inviting you to take seat",
      cancelButtonName: "Disagree",
      confirmButtonName: "Agree",
    );
    innerText.assignAsCoHostMenuDialogButton =
        "Assign ${innerText.param_1} as Co-Host";
    innerText.revokeCoHostPrivilegesMenuDialogButton =
        "Revoke ${innerText.param_1}'s Co-Host Privileges";
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

  static ZegoUIKitPrebuiltLiveAudioRoomInnerText get chinese {
    var innerText = ZegoUIKitPrebuiltLiveAudioRoomInnerText();

    innerText.takeSeatMenuButton = "占座";
    innerText.switchSeatMenuButton = "切换座位";
    innerText.removeSpeakerMenuDialogButton = "将${innerText.param_1}移出座位";
    innerText.muteSpeakerMenuDialogButton = "静音${innerText.param_1}";
    innerText.cancelMenuDialogButton = "取消";
    innerText.removeUserMenuDialogButton = "将${innerText.param_1}移出房间";
    innerText.memberListTitle = "观众";
    innerText.memberListRoleYou = "你";
    innerText.memberListRoleHost = "主持人";
    innerText.memberListRoleSpeaker = "发言人";
    innerText.removeSpeakerFailedToast = "移除${innerText.param_1}出座位失败";
    innerText.messageEmptyToast = "说点什么...";
    innerText.cameraPermissionSettingDialogInfo = ZegoLiveAudioRoomDialogInfo(
      title: "无法使用相机！",
      message: "请在系统设置中启用相机访问权限！",
      cancelButtonName: "取消",
      confirmButtonName: "设置",
    );
    innerText.microphonePermissionSettingDialogInfo =
        ZegoLiveAudioRoomDialogInfo(
      title: "无法使用麦克风！",
      message: "请在系统设置中启用麦克风访问权限！",
      cancelButtonName: "取消",
      confirmButtonName: "设置",
    );
    innerText.removeFromSeatDialogInfo = ZegoLiveAudioRoomDialogInfo(
      title: "移除发言人",
      message: "确定要将${innerText.param_1}移出座位吗？",
      cancelButtonName: "取消",
      confirmButtonName: "确定",
    );
    innerText.leaveSeatDialogInfo = ZegoLiveAudioRoomDialogInfo(
      title: "离开座位",
      message: "确定要离开座位吗？",
      cancelButtonName: "取消",
      confirmButtonName: "确定",
    );
    innerText.applyToTakeSeatButton = "申请占座";
    innerText.cancelTheTakeSeatApplicationButton = "取消";
    innerText.memberListAgreeButton = "同意";
    innerText.memberListDisagreeButton = "不同意";
    innerText.inviteToTakeSeatMenuDialogButton = "邀请${innerText.param_1}占座";
    innerText.hostInviteTakeSeatDialog = ZegoLiveAudioRoomDialogInfo(
      title: "邀请",
      message: "主持人邀请你占座",
      cancelButtonName: "不同意",
      confirmButtonName: "同意",
    );
    innerText.assignAsCoHostMenuDialogButton = "将${innerText.param_1}指定为副主持人";
    innerText.revokeCoHostPrivilegesMenuDialogButton =
        "撤销${innerText.param_1}的副主持人权限";
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

  static ZegoUIKitPrebuiltLiveAudioRoomInnerText get hindi {
    var innerText = ZegoUIKitPrebuiltLiveAudioRoomInnerText();

    innerText.takeSeatMenuButton = "सीट लें";
    innerText.switchSeatMenuButton = "सीट बदलें";
    innerText.removeSpeakerMenuDialogButton =
        "${innerText.param_1} को सीट से हटाएं";
    innerText.muteSpeakerMenuDialogButton = "म्यूट करें ${innerText.param_1}";
    innerText.cancelMenuDialogButton = "रद्द करें";
    innerText.removeUserMenuDialogButton =
        "${innerText.param_1} को कमरे से हटाएं";
    innerText.memberListTitle = "दर्शक";
    innerText.memberListRoleYou = "आप";
    innerText.memberListRoleHost = "होस्ट";
    innerText.memberListRoleSpeaker = "स्पीकर";
    innerText.removeSpeakerFailedToast =
        "${innerText.param_1} को सीट से हटाने में विफल";
    innerText.messageEmptyToast = "कुछ कहें...";
    innerText.cameraPermissionSettingDialogInfo = ZegoLiveAudioRoomDialogInfo(
      title: "कैमरा का उपयोग नहीं कर सकते!",
      message: "कृपया सिस्टम सेटिंग्स में कैमरा एक्सेस सक्षम करें!",
      cancelButtonName: "रद्द करें",
      confirmButtonName: "सेटिंग",
    );
    innerText.microphonePermissionSettingDialogInfo =
        ZegoLiveAudioRoomDialogInfo(
      title: "माइक्रोफोन का उपयोग नहीं कर सकते!",
      message: "कृपया सिस्टम सेटिंग्स में माइक्रोफोन एक्सेस सक्षम करें!",
      cancelButtonName: "रद्द करें",
      confirmButtonName: "सेटिंग",
    );
    innerText.removeFromSeatDialogInfo = ZegoLiveAudioRoomDialogInfo(
      title: "स्पीकर को हटाएं",
      message:
          "क्या आप निश्चित हैं कि ${innerText.param_1} को सीट से हटाना है?",
      cancelButtonName: "रद्द करें",
      confirmButtonName: "ठीक है",
    );
    innerText.leaveSeatDialogInfo = ZegoLiveAudioRoomDialogInfo(
      title: "सीट छोड़ें",
      message: "क्या आप निश्चित हैं कि सीट छोड़ना है?",
      cancelButtonName: "रद्द करें",
      confirmButtonName: "ठीक है",
    );
    innerText.applyToTakeSeatButton = "सीट लेने के लिए आवेदन करें";
    innerText.cancelTheTakeSeatApplicationButton = "रद्द करें";
    innerText.memberListAgreeButton = "सहमत";
    innerText.memberListDisagreeButton = "असहमत";
    innerText.inviteToTakeSeatMenuDialogButton =
        "${innerText.param_1} को सीट लेने के लिए आमंत्रित करें";
    innerText.hostInviteTakeSeatDialog = ZegoLiveAudioRoomDialogInfo(
      title: "निमंत्रण",
      message: "होस्ट आपको सीट लेने के लिए आमंत्रित कर रहा है",
      cancelButtonName: "असहमत",
      confirmButtonName: "सहमत",
    );
    innerText.assignAsCoHostMenuDialogButton =
        "${innerText.param_1} को सह-होस्ट के रूप में नियुक्त करें";
    innerText.revokeCoHostPrivilegesMenuDialogButton =
        "${innerText.param_1} के सह-होस्ट विशेषाधिकार रद्द करें";
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
