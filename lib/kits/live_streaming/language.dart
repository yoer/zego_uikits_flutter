// Dart imports:
import 'dart:ui';

// Package imports:
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

// Project imports:
import 'package:zego_uikits_demo/data/translations.dart';

class LiveStreamingInnerText {
  static ZegoUIKitPrebuiltLiveStreamingInnerText current(Locale locale) {
    if (locale.languageCode == MyLocale.enUS.languageCode) {
      return LiveStreamingInnerText.english;
    } else if (locale.languageCode == MyLocale.zhCN.languageCode) {
      return LiveStreamingInnerText.chinese;
    } else if (locale.languageCode == MyLocale.hiIN.languageCode) {
      return LiveStreamingInnerText.hindi;
    }

    return LiveStreamingInnerText.english;
  }

  static ZegoUIKitPrebuiltLiveStreamingInnerText get english {
    var innerText = ZegoUIKitPrebuiltLiveStreamingInnerText();
    innerText.disagreeButton = "Disagree";
    innerText.agreeButton = "Agree";
    innerText.startLiveStreamingButton = "Start";
    innerText.endCoHostButton = "End";
    innerText.requestCoHostButton = "";
    innerText.cancelRequestCoHostButton = "Cancel";
    innerText.removeCoHostButton = "Remove the co-host";
    innerText.cancelMenuDialogButton = "Cancel";
    innerText.inviteCoHostButton =
        "Invite ${ZegoUIKitPrebuiltLiveStreamingInnerText.param_1} to co-host";
    innerText.removeUserMenuDialogButton =
        "Remove ${ZegoUIKitPrebuiltLiveStreamingInnerText.param_1} from the room";
    innerText.noHostOnline = "No host is online.";
    innerText.memberListTitle = "Audience.";
    innerText.memberListRoleYou = "You";
    innerText.memberListRoleHost = "Host";
    innerText.memberListRoleCoHost = "Co-host";
    innerText.sendRequestCoHostToast =
        "You are applying to be a co-host, please wait for confirmation.";
    innerText.requestCoHostFailedToast = "Failed to apply for connection.";
    innerText.hostRejectCoHostRequestToast =
        "Your request to co-host with the host has been refused.";
    innerText.inviteCoHostFailedToast =
        "Failed to connect with the co-host, please try again.";
    innerText.audienceRejectInvitationToast =
        "${ZegoUIKitPrebuiltLiveStreamingInnerText.param_1} refused to be a co-host.";
    innerText.repeatInviteCoHostFailedToast =
        "You've sent the invitation, please wait for confirmation.";
    innerText.messageEmptyToast = "Say something...";
    innerText.userEnter = "entered";
    innerText.userLeave = "left";

    /// Camera permission settings
    innerText.cameraPermissionSettingDialogInfo = ZegoLiveStreamingDialogInfo(
      title: "Can not use Camera!",
      message: "Please enable camera access in the system settings!",
      cancelButtonName: "Cancel",
      confirmButtonName: "Settings",
    );

    /// Microphone permission settings
    innerText.microphonePermissionSettingDialogInfo =
        ZegoLiveStreamingDialogInfo(
      title: "Can not use Microphone!",
      message: "Please enable microphone access in the system settings!",
      cancelButtonName: "Cancel",
      confirmButtonName: "Settings",
    );

    /// Co-host request dialog info
    innerText.receivedCoHostRequestDialogInfo = ZegoLiveStreamingDialogInfo(
      title: "Can not use Microphone!",
      message: "Please enable microphone access in the system settings!",
      cancelButtonName: "Cancel",
      confirmButtonName: "Settings",
    );

    /// Co-host invitation dialog info
    innerText.receivedCoHostInvitationDialogInfo = ZegoLiveStreamingDialogInfo(
      title: "Invitation",
      message: "The host is inviting you to co-host.",
      cancelButtonName: "Disagree",
      confirmButtonName: "Agree",
    );

    /// End connection dialog info
    innerText.endConnectionDialogInfo = ZegoLiveStreamingDialogInfo(
      title: "End the connection",
      message: "Do you want to end the cohosting?",
      cancelButtonName: "Cancel",
      confirmButtonName: "OK",
    );

    innerText.audioEffectTitle = "Audio effect";
    innerText.audioEffectReverbTitle = "Reverb";
    innerText.audioEffectVoiceChangingTitle = "Voice changing";
    innerText.beautyEffectTitle = "Face beautification";
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
    innerText.beautyEffectTypeWhitenTitle = "Whiten";
    innerText.beautyEffectTypeRosyTitle = "Rosy";
    innerText.beautyEffectTypeSmoothTitle = "Smooth";
    innerText.beautyEffectTypeSharpenTitle = "Sharpen";
    innerText.beautyEffectTypeNoneTitle = "None";

    /// PK battle dialog info
    innerText.incomingPKBattleRequestReceived = ZegoLiveStreamingDialogInfo(
      title: "PK Battle Request",
      message:
          "${ZegoUIKitPrebuiltLiveStreamingInnerText.param_1} sends a PK battle request to you.",
      cancelButtonName: "Reject",
      confirmButtonName: "Accept",
    );

    innerText.coHostEndCauseByHostStartPK = ZegoLiveStreamingDialogInfo(
      title: "Host Start PK Battle",
      message: "Your co-hosting ended.",
      cancelButtonName: "",
      confirmButtonName: "OK",
    );

    innerText.pkBattleEndedCauseByAnotherHost = ZegoLiveStreamingDialogInfo(
      title: "PK Battle Ended",
      message:
          "${ZegoUIKitPrebuiltLiveStreamingInnerText.param_1} ended the PK Battle.",
      cancelButtonName: "",
      confirmButtonName: "OK",
    );

    innerText.outgoingPKBattleRequestRejectedCauseByError =
        ZegoLiveStreamingDialogInfo(
      title: "PK Battle Initiate Failed",
      message: "code: ${ZegoUIKitPrebuiltLiveStreamingInnerText.param_1}.",
      cancelButtonName: "",
      confirmButtonName: "OK",
    );

    innerText.outgoingPKBattleRequestRejectedCauseByBusy =
        ZegoLiveStreamingDialogInfo(
      title: "PK Battle Initiate Failed",
      message: "The host is busy.",
      cancelButtonName: "",
      confirmButtonName: "OK",
    );

    innerText.outgoingPKBattleRequestRejectedCauseByLocalHostStateError =
        ZegoLiveStreamingDialogInfo(
      title: "PK Battle Initiate Failed",
      message:
          "You can only initiate the PK battle when the host has started a livestream.",
      cancelButtonName: "",
      confirmButtonName: "OK",
    );

    innerText.outgoingPKBattleRequestRejectedCauseByReject =
        ZegoLiveStreamingDialogInfo(
      title: "PK Battle Initiate Failed",
      message: "The host rejected your request.",
      cancelButtonName: "",
      confirmButtonName: "OK",
    );

    return innerText;
  }

  static ZegoUIKitPrebuiltLiveStreamingInnerText get chinese {
    var innerText = ZegoUIKitPrebuiltLiveStreamingInnerText();
    innerText.disagreeButton = "不同意";
    innerText.agreeButton = "同意";
    innerText.startLiveStreamingButton = "开始";
    innerText.endCoHostButton = "结束";
    innerText.requestCoHostButton = "";
    innerText.cancelRequestCoHostButton = "取消";
    innerText.removeCoHostButton = "移除共同主持";
    innerText.cancelMenuDialogButton = "取消";
    innerText.inviteCoHostButton =
        "邀请 ${ZegoUIKitPrebuiltLiveStreamingInnerText.param_1} 共同主持";
    innerText.removeUserMenuDialogButton =
        "将 ${ZegoUIKitPrebuiltLiveStreamingInnerText.param_1} 从房间移除";
    innerText.noHostOnline = "没有主持人在线";
    innerText.memberListTitle = "观众";
    innerText.memberListRoleYou = "你";
    innerText.memberListRoleHost = "主持人";
    innerText.memberListRoleCoHost = "共同主持";
    innerText.sendRequestCoHostToast = "您正在申请共同主持，请等待确认";
    innerText.requestCoHostFailedToast = "申请连接失败";
    innerText.hostRejectCoHostRequestToast = "您与主持人共同主持的请求被拒绝";
    innerText.inviteCoHostFailedToast = "与共同主持的连接失败，请重试";
    innerText.audienceRejectInvitationToast =
        "${ZegoUIKitPrebuiltLiveStreamingInnerText.param_1} 拒绝成为共同主持";
    innerText.repeatInviteCoHostFailedToast = "您已发送邀请，请等待确认";
    innerText.messageEmptyToast = "说点什么...";
    innerText.userEnter = "进入";
    innerText.userLeave = "离开";

    /// 摄像头权限设置
    innerText.cameraPermissionSettingDialogInfo = ZegoLiveStreamingDialogInfo(
      title: "无法使用摄像头！",
      message: "请在系统设置中启用摄像头访问！",
      cancelButtonName: "取消",
      confirmButtonName: "设置",
    );

    /// 麦克风权限设置
    innerText.microphonePermissionSettingDialogInfo =
        ZegoLiveStreamingDialogInfo(
      title: "无法使用麦克风！",
      message: "请在系统设置中启用麦克风访问！",
      cancelButtonName: "取消",
      confirmButtonName: "设置",
    );

    /// 共同主持请求对话框信息
    innerText.receivedCoHostRequestDialogInfo = ZegoLiveStreamingDialogInfo(
      title: "无法使用麦克风！",
      message: "请在系统设置中启用麦克风访问！",
      cancelButtonName: "取消",
      confirmButtonName: "设置",
    );

    /// 共同主持邀请对话框信息
    innerText.receivedCoHostInvitationDialogInfo = ZegoLiveStreamingDialogInfo(
      title: "邀请",
      message: "主持人邀请您共同主持",
      cancelButtonName: "不同意",
      confirmButtonName: "同意",
    );

    /// 结束连接对话框信息
    innerText.endConnectionDialogInfo = ZegoLiveStreamingDialogInfo(
      title: "结束连接",
      message: "您想结束共同主持吗？",
      cancelButtonName: "取消",
      confirmButtonName: "确定",
    );

    innerText.audioEffectTitle = "音效";
    innerText.audioEffectReverbTitle = "混响";
    innerText.audioEffectVoiceChangingTitle = "变声";
    innerText.beautyEffectTitle = "美颜";
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
    innerText.beautyEffectTypeWhitenTitle = "美白";
    innerText.beautyEffectTypeRosyTitle = "红润";
    innerText.beautyEffectTypeSmoothTitle = "光滑";
    innerText.beautyEffectTypeSharpenTitle = "锐化";
    innerText.beautyEffectTypeNoneTitle = "无";

    /// PK对战对话框信息
    innerText.incomingPKBattleRequestReceived = ZegoLiveStreamingDialogInfo(
      title: "PK对战请求",
      message: "${ZegoUIKitPrebuiltLiveStreamingInnerText.param_1} 向您发送了PK对战请求",
      cancelButtonName: "拒绝",
      confirmButtonName: "接受",
    );

    innerText.coHostEndCauseByHostStartPK = ZegoLiveStreamingDialogInfo(
      title: "主持人开始PK对战",
      message: "您的共同主持已结束",
      cancelButtonName: "",
      confirmButtonName: "确定",
    );

    innerText.pkBattleEndedCauseByAnotherHost = ZegoLiveStreamingDialogInfo(
      title: "PK对战结束",
      message: "${ZegoUIKitPrebuiltLiveStreamingInnerText.param_1} 结束了PK对战",
      cancelButtonName: "",
      confirmButtonName: "确定",
    );

    innerText.outgoingPKBattleRequestRejectedCauseByError =
        ZegoLiveStreamingDialogInfo(
      title: "PK对战发起失败",
      message: "代码: ${ZegoUIKitPrebuiltLiveStreamingInnerText.param_1}",
      cancelButtonName: "",
      confirmButtonName: "确定",
    );

    innerText.outgoingPKBattleRequestRejectedCauseByBusy =
        ZegoLiveStreamingDialogInfo(
      title: "PK对战发起失败",
      message: "主持人忙碌中",
      cancelButtonName: "",
      confirmButtonName: "确定",
    );

    innerText.outgoingPKBattleRequestRejectedCauseByLocalHostStateError =
        ZegoLiveStreamingDialogInfo(
      title: "PK对战发起失败",
      message: "只有在主持人开始直播时才能发起PK对战",
      cancelButtonName: "",
      confirmButtonName: "确定",
    );

    innerText.outgoingPKBattleRequestRejectedCauseByReject =
        ZegoLiveStreamingDialogInfo(
      title: "PK对战发起失败",
      message: "主持人拒绝了您的请求",
      cancelButtonName: "",
      confirmButtonName: "确定",
    );

    return innerText;
  }

  static ZegoUIKitPrebuiltLiveStreamingInnerText get hindi {
    var innerText = ZegoUIKitPrebuiltLiveStreamingInnerText();
    innerText.disagreeButton = "असहमत";
    innerText.agreeButton = "सहमति";
    innerText.startLiveStreamingButton = "शुरू करें";
    innerText.endCoHostButton = "समाप्त करें";
    innerText.requestCoHostButton = "";
    innerText.cancelRequestCoHostButton = "रद्द करें";
    innerText.removeCoHostButton = "को-होस्ट हटाएँ";
    innerText.cancelMenuDialogButton = "रद्द करें";
    innerText.inviteCoHostButton =
        "को-होस्ट के लिए ${ZegoUIKitPrebuiltLiveStreamingInnerText.param_1} को आमंत्रित करें";
    innerText.removeUserMenuDialogButton =
        "${ZegoUIKitPrebuiltLiveStreamingInnerText.param_1} को कमरे से हटाएँ";
    innerText.noHostOnline = "कोई होस्ट ऑनलाइन नहीं है।";
    innerText.memberListTitle = "दर्शक।";
    innerText.memberListRoleYou = "आप";
    innerText.memberListRoleHost = "होस्ट";
    innerText.memberListRoleCoHost = "को-होस्ट";
    innerText.sendRequestCoHostToast =
        "आप को-होस्ट के लिए आवेदन कर रहे हैं, कृपया पुष्टि के लिए प्रतीक्षा करें।";
    innerText.requestCoHostFailedToast = "कनेक्शन के लिए आवेदन विफल।";
    innerText.hostRejectCoHostRequestToast =
        "आपका को-होस्ट के साथ होस्ट करने का अनुरोध अस्वीकृत कर दिया गया।";
    innerText.inviteCoHostFailedToast =
        "को-होस्ट के साथ कनेक्शन विफल, कृपया पुनः प्रयास करें।";
    innerText.audienceRejectInvitationToast =
        "${ZegoUIKitPrebuiltLiveStreamingInnerText.param_1} ने को-होस्ट बनने से मना कर दिया।";
    innerText.repeatInviteCoHostFailedToast =
        "आपने निमंत्रण भेजा है, कृपया पुष्टि के लिए प्रतीक्षा करें।";
    innerText.messageEmptyToast = "कुछ कहें...";
    innerText.userEnter = "प्रवेश किया";
    innerText.userLeave = "छोड़ दिया";

    /// कैमरा अनुमति सेटिंग्स
    innerText.cameraPermissionSettingDialogInfo = ZegoLiveStreamingDialogInfo(
      title: "कैमरा का उपयोग नहीं कर सकते!",
      message: "कृपया सिस्टम सेटिंग्स में कैमरा एक्सेस सक्षम करें!",
      cancelButtonName: "रद्द करें",
      confirmButtonName: "सेटिंग्स",
    );

    /// माइक्रोफोन अनुमति सेटिंग्स
    innerText.microphonePermissionSettingDialogInfo =
        ZegoLiveStreamingDialogInfo(
      title: "माइक्रोफोन का उपयोग नहीं कर सकते!",
      message: "कृपया सिस्टम सेटिंग्स में माइक्रोफोन एक्सेस सक्षम करें!",
      cancelButtonName: "रद्द करें",
      confirmButtonName: "सेटिंग्स",
    );

    /// को-होस्ट अनुरोध संवाद जानकारी
    innerText.receivedCoHostRequestDialogInfo = ZegoLiveStreamingDialogInfo(
      title: "माइक्रोफोन का उपयोग नहीं कर सकते!",
      message: "कृपया सिस्टम सेटिंग्स में माइक्रोफोन एक्सेस सक्षम करें!",
      cancelButtonName: "रद्द करें",
      confirmButtonName: "सेटिंग्स",
    );

    /// को-होस्ट निमंत्रण संवाद जानकारी
    innerText.receivedCoHostInvitationDialogInfo = ZegoLiveStreamingDialogInfo(
      title: "निमंत्रण",
      message: "होस्ट आपको को-होस्ट करने के लिए आमंत्रित कर रहा है।",
      cancelButtonName: "असहमत",
      confirmButtonName: "सहमति",
    );

    /// कनेक्शन समाप्त करने की संवाद जानकारी
    innerText.endConnectionDialogInfo = ZegoLiveStreamingDialogInfo(
      title: "कनेक्शन समाप्त करें",
      message: "क्या आप को-होस्टिंग समाप्त करना चाहते हैं?",
      cancelButtonName: "रद्द करें",
      confirmButtonName: "ठीक है",
    );

    innerText.audioEffectTitle = "ऑडियो प्रभाव";
    innerText.audioEffectReverbTitle = "गूंज";
    innerText.audioEffectVoiceChangingTitle = "स्वर परिवर्तन";
    innerText.beautyEffectTitle = "चेहरा सुंदरता";
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
    innerText.beautyEffectTypeWhitenTitle = "सफेद";
    innerText.beautyEffectTypeRosyTitle = "गुलाबी";
    innerText.beautyEffectTypeSmoothTitle = "मुलायम";
    innerText.beautyEffectTypeSharpenTitle = "तीखा";
    innerText.beautyEffectTypeNoneTitle = "कोई नहीं";

    /// PK युद्ध संवाद जानकारी
    innerText.incomingPKBattleRequestReceived = ZegoLiveStreamingDialogInfo(
      title: "PK युद्ध अनुरोध",
      message:
          "${ZegoUIKitPrebuiltLiveStreamingInnerText.param_1} ने आपको PK युद्ध का अनुरोध भेजा।",
      cancelButtonName: "अस्वीकृत करें",
      confirmButtonName: "स्वीकृत करें",
    );

    innerText.coHostEndCauseByHostStartPK = ZegoLiveStreamingDialogInfo(
      title: "होस्ट ने PK युद्ध शुरू किया",
      message: "आपकी को-होस्टिंग समाप्त हो गई है।",
      cancelButtonName: "",
      confirmButtonName: "ठीक है",
    );

    innerText.pkBattleEndedCauseByAnotherHost = ZegoLiveStreamingDialogInfo(
      title: "PK युद्ध समाप्त",
      message:
          "${ZegoUIKitPrebuiltLiveStreamingInnerText.param_1} ने PK युद्ध समाप्त किया।",
      cancelButtonName: "",
      confirmButtonName: "ठीक है",
    );

    innerText.outgoingPKBattleRequestRejectedCauseByError =
        ZegoLiveStreamingDialogInfo(
      title: "PK युद्ध आरंभ विफल",
      message: "कोड: ${ZegoUIKitPrebuiltLiveStreamingInnerText.param_1}।",
      cancelButtonName: "",
      confirmButtonName: "ठीक है",
    );

    innerText.outgoingPKBattleRequestRejectedCauseByBusy =
        ZegoLiveStreamingDialogInfo(
      title: "PK युद्ध आरंभ विफल",
      message: "होस्ट व्यस्त है।",
      cancelButtonName: "",
      confirmButtonName: "ठीक है",
    );

    innerText.outgoingPKBattleRequestRejectedCauseByLocalHostStateError =
        ZegoLiveStreamingDialogInfo(
      title: "PK युद्ध आरंभ विफल",
      message:
          "आप केवल तब PK युद्ध आरंभ कर सकते हैं जब होस्ट ने लाइवस्ट्रीम शुरू किया हो।",
      cancelButtonName: "",
      confirmButtonName: "ठीक है",
    );

    innerText.outgoingPKBattleRequestRejectedCauseByReject =
        ZegoLiveStreamingDialogInfo(
      title: "PK युद्ध आरंभ विफल",
      message: "होस्ट ने आपके अनुरोध को अस्वीकृत कर दिया।",
      cancelButtonName: "",
      confirmButtonName: "ठीक है",
    );

    return innerText;
  }
}
