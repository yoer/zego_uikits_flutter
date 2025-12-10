// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

// Project imports:
import 'package:zego_uikits_demo/common/settings.dart';
import 'package:zego_uikits_demo/common/string_list_editor.dart';
import 'package:zego_uikits_demo/common/string_list_list_editor.dart';
import 'package:zego_uikits_demo/data/translations.dart';
import 'package:zego_uikits_demo/kits/live_streaming/cache.dart';

class LiveStreamingPageSettings extends StatefulWidget {
  const LiveStreamingPageSettings({super.key});

  @override
  State<LiveStreamingPageSettings> createState() {
    return _LiveStreamingPageSettingsState();
  }
}

class _LiveStreamingPageSettingsState extends State<LiveStreamingPageSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Translations.settings.title),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            settingsGroup(
              Translations.settings.liveListId,
              [
                liveIDEditor(),
                settingsCheckBox(
                  title: Translations.settings.useModulePrefix,
                  value: LiveStreamingCache().useModulePrefix,
                  onChanged: (value) {
                    setState(() {
                      LiveStreamingCache().useModulePrefix = value ?? false;
                    });
                  },
                ),
              ],
            ),
            settingsGroup(
              Translations.settings.mediaSharing,
              [
                settingsEditor(
                  tips: Translations.settings.url,
                  value: LiveStreamingCache().mediaDefaultURL,
                  onChanged: (String value) {
                    LiveStreamingCache().mediaDefaultURL = value;
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.autoPlay,
                  value: LiveStreamingCache().autoPlayMedia,
                  onChanged: (value) {
                    setState(() {
                      LiveStreamingCache().autoPlayMedia = value ?? true;
                    });
                  },
                ),
              ],
            ),
            settingsGroup(
              Translations.settings.audioVideo,
              [
                settingsCheckBox(
                  title: Translations.settings.videoAspectFill,
                  value: LiveStreamingCache().videoAspectFill,
                  onChanged: (value) {
                    setState(() {
                      LiveStreamingCache().videoAspectFill = value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.showMicState,
                  value: LiveStreamingCache().showMicrophoneStateOnView,
                  onChanged: (value) {
                    setState(() {
                      LiveStreamingCache().showMicrophoneStateOnView =
                          value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.showUserName,
                  value: LiveStreamingCache().showUserNameOnView,
                  onChanged: (value) {
                    setState(() {
                      LiveStreamingCache().showUserNameOnView = value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.isVideoMirror,
                  value: LiveStreamingCache().isVideoMirror,
                  onChanged: (value) {
                    setState(() {
                      LiveStreamingCache().isVideoMirror = value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.showAvatarInAudioMode,
                  value: LiveStreamingCache().showAvatarInAudioMode,
                  onChanged: (value) {
                    setState(() {
                      LiveStreamingCache().showAvatarInAudioMode =
                          value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.showSoundWavesInAudioMode,
                  value: LiveStreamingCache().showSoundWavesInAudioMode,
                  onChanged: (value) {
                    setState(() {
                      LiveStreamingCache().showSoundWavesInAudioMode =
                          value ?? true;
                    });
                  },
                ),
              ],
            ),
            settingsGroup(
              Translations.settings.basic,
              [
                settingsCheckBox(
                  title: Translations.settings.turnOnCameraWhenJoining,
                  value: LiveStreamingCache().turnOnCameraWhenJoining,
                  onChanged: (value) {
                    setState(() {
                      LiveStreamingCache().turnOnCameraWhenJoining =
                          value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.useFrontFacingCamera,
                  value: LiveStreamingCache().useFrontFacingCamera,
                  onChanged: (value) {
                    setState(() {
                      LiveStreamingCache().useFrontFacingCamera = value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.turnOnMicrophoneWhenJoining,
                  value: LiveStreamingCache().turnOnMicrophoneWhenJoining,
                  onChanged: (value) {
                    setState(() {
                      LiveStreamingCache().turnOnMicrophoneWhenJoining =
                          value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.useSpeakerWhenJoining,
                  value: LiveStreamingCache().useSpeakerWhenJoining,
                  onChanged: (value) {
                    setState(() {
                      LiveStreamingCache().useSpeakerWhenJoining =
                          value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.rootNavigator,
                  value: LiveStreamingCache().rootNavigator,
                  onChanged: (value) {
                    setState(() {
                      LiveStreamingCache().rootNavigator = value ?? false;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.markAsLargeRoom,
                  value: LiveStreamingCache().markAsLargeRoom,
                  onChanged: (value) {
                    setState(() {
                      LiveStreamingCache().markAsLargeRoom = value ?? false;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.slideSurfaceToHide,
                  value: LiveStreamingCache().slideSurfaceToHide,
                  onChanged: (value) {
                    setState(() {
                      LiveStreamingCache().slideSurfaceToHide = value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.showBackgroundTips,
                  value: LiveStreamingCache().showBackgroundTips,
                  onChanged: (value) {
                    setState(() {
                      LiveStreamingCache().showBackgroundTips = value ?? false;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.showToast,
                  value: LiveStreamingCache().showToast,
                  onChanged: (value) {
                    setState(() {
                      LiveStreamingCache().showToast = value ?? false;
                    });
                  },
                ),
              ],
            ),
            settingsGroup(
              Translations.settings.topMenuBar,
              [
                settingsCheckBox(
                  title: Translations.settings.showCloseButton,
                  value: LiveStreamingCache().showCloseButton,
                  onChanged: (value) {
                    setState(() {
                      LiveStreamingCache().showCloseButton = value ?? true;
                    });
                  },
                ),
              ],
            ),
            settingsGroup(
              Translations.settings.bottomMenuBar,
              [
                settingsCheckBox(
                  title: Translations.settings.showInRoomMessageButton,
                  value: LiveStreamingCache().showInRoomMessageButton,
                  onChanged: (value) {
                    setState(() {
                      LiveStreamingCache().showInRoomMessageButton =
                          value ?? true;
                    });
                  },
                ),
                settingsIntEditor(
                  tips: Translations.settings.bottomMenuBarMaxCount,
                  value: LiveStreamingCache().bottomMenuBarMaxCount,
                  onChanged: (value) {
                    setState(() {
                      LiveStreamingCache().bottomMenuBarMaxCount = value;
                    });
                  },
                ),
              ],
            ),
            settingsGroup(
              Translations.settings.memberList,
              [
                settingsCheckBox(
                  title: Translations.settings.showFakeUser,
                  value: LiveStreamingCache().showFakeUser,
                  onChanged: (value) {
                    setState(() {
                      LiveStreamingCache().showFakeUser = value ?? false;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.notifyUserJoin,
                  value: LiveStreamingCache().notifyUserJoin,
                  onChanged: (value) {
                    setState(() {
                      LiveStreamingCache().notifyUserJoin = value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.notifyUserLeave,
                  value: LiveStreamingCache().notifyUserLeave,
                  onChanged: (value) {
                    setState(() {
                      LiveStreamingCache().notifyUserLeave = value ?? true;
                    });
                  },
                ),
              ],
            ),
            settingsGroup(
              Translations.settings.inRoomMessage,
              [
                settingsCheckBox(
                  title: Translations.settings.inRoomMessageVisible,
                  value: LiveStreamingCache().inRoomMessageVisible,
                  onChanged: (value) {
                    setState(() {
                      LiveStreamingCache().inRoomMessageVisible = value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.showFakeMessage,
                  value: LiveStreamingCache().showFakeMessage,
                  onChanged: (value) {
                    setState(() {
                      LiveStreamingCache().showFakeMessage = value ?? false;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.inRoomMessageShowName,
                  value: LiveStreamingCache().inRoomMessageShowName,
                  onChanged: (value) {
                    setState(() {
                      LiveStreamingCache().inRoomMessageShowName =
                          value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.inRoomMessageShowAvatar,
                  value: LiveStreamingCache().inRoomMessageShowAvatar,
                  onChanged: (value) {
                    setState(() {
                      LiveStreamingCache().inRoomMessageShowAvatar =
                          value ?? true;
                    });
                  },
                ),
                settingsDoubleEditor(
                  tips: Translations.settings.inRoomMessageOpacity,
                  value: LiveStreamingCache().inRoomMessageOpacity,
                  onChanged: (value) {
                    setState(() {
                      LiveStreamingCache().inRoomMessageOpacity = value;
                    });
                  },
                ),
              ],
            ),
            settingsGroup(
              Translations.settings.duration,
              [
                settingsCheckBox(
                  title: Translations.settings.durationIsVisible,
                  value: LiveStreamingCache().durationIsVisible,
                  onChanged: (value) {
                    setState(() {
                      LiveStreamingCache().durationIsVisible = value ?? true;
                    });
                  },
                ),
              ],
            ),
            settingsGroup(
              Translations.settings.preview,
              [
                settingsCheckBox(
                  title: Translations.settings.showPreviewForHost,
                  value: LiveStreamingCache().showPreviewForHost,
                  onChanged: (value) {
                    setState(() {
                      LiveStreamingCache().showPreviewForHost = value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.previewTopBarIsVisible,
                  value: LiveStreamingCache().previewTopBarIsVisible,
                  onChanged: (value) {
                    setState(() {
                      LiveStreamingCache().previewTopBarIsVisible =
                          value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.previewBottomBarIsVisible,
                  value: LiveStreamingCache().previewBottomBarIsVisible,
                  onChanged: (value) {
                    setState(() {
                      LiveStreamingCache().previewBottomBarIsVisible =
                          value ?? true;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations
                      .settings.previewBottomBarShowBeautyEffectButton,
                  value: LiveStreamingCache()
                      .previewBottomBarShowBeautyEffectButton,
                  onChanged: (value) {
                    setState(() {
                      LiveStreamingCache()
                              .previewBottomBarShowBeautyEffectButton =
                          value ?? true;
                    });
                  },
                ),
              ],
            ),
            settingsGroup(
              Translations.liveStreaming.liveListTitle,
              [
                liveListEditor(),
                liveListStreamMode(),
              ],
            ),
            settingsGroup(Translations.settings.pk, [
              settingsCheckBox(
                title: Translations.settings.pkAutoAccept,
                value: LiveStreamingCache().pkAutoAccept,
                onChanged: (value) {
                  setState(() {
                    LiveStreamingCache().pkAutoAccept = value ?? false;
                  });
                },
              ),
              settingsIntEditor(
                tips: Translations.settings.pkBattleUserReconnectingSecond,
                value: LiveStreamingCache().pkBattleUserReconnectingSecond,
                onChanged: (value) {
                  setState(() {
                    LiveStreamingCache().pkBattleUserReconnectingSecond = value;
                  });
                },
              ),
              settingsIntEditor(
                tips: Translations.settings.pkBattleUserDisconnectedSecond,
                value: LiveStreamingCache().pkBattleUserDisconnectedSecond,
                onChanged: (value) {
                  setState(() {
                    LiveStreamingCache().pkBattleUserDisconnectedSecond = value;
                  });
                },
              ),
              settingsDoubleEditor(
                tips: Translations.settings.pkBattleTopPadding,
                value: LiveStreamingCache().pkBattleTopPadding ?? 0.0,
                onChanged: (value) {
                  setState(() {
                    LiveStreamingCache().pkBattleTopPadding = value;
                  });
                },
              ),
            ]),
            settingsGroup(
              Translations.settings.screenSharing,
              [
                settingsIntEditor(
                  tips: Translations.settings.screenSharingAutoStopInvalidCount,
                  value: LiveStreamingCache().screenSharingAutoStopInvalidCount,
                  onChanged: (value) {
                    setState(() {
                      LiveStreamingCache().screenSharingAutoStopInvalidCount =
                          value;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations.settings.screenSharingDefaultFullScreen,
                  value: LiveStreamingCache().screenSharingDefaultFullScreen,
                  onChanged: (value) {
                    setState(() {
                      LiveStreamingCache().screenSharingDefaultFullScreen =
                          value ?? false;
                    });
                  },
                ),
              ],
            ),
            settingsGroup(
              Translations.settings.mediaPlayer,
              [
                settingsCheckBox(
                  title: Translations.settings.mediaPlayerSupportTransparent,
                  value: LiveStreamingCache().mediaPlayerSupportTransparent,
                  onChanged: (value) {
                    setState(() {
                      LiveStreamingCache().mediaPlayerSupportTransparent =
                          value ?? false;
                    });
                  },
                ),
              ],
            ),
            settingsGroup(
              Translations.settings.coHost,
              [
                settingsCheckBox(
                  title: Translations.settings.stopCoHostingWhenMicCameraOff,
                  value: LiveStreamingCache().stopCoHostingWhenMicCameraOff,
                  onChanged: (value) {
                    setState(() {
                      LiveStreamingCache().stopCoHostingWhenMicCameraOff =
                          value ?? false;
                    });
                  },
                ),
                settingsCheckBox(
                  title: Translations
                      .settings.disableCoHostInvitationReceivedDialog,
                  value: LiveStreamingCache()
                      .disableCoHostInvitationReceivedDialog,
                  onChanged: (value) {
                    setState(() {
                      LiveStreamingCache()
                              .disableCoHostInvitationReceivedDialog =
                          value ?? false;
                    });
                  },
                ),
                settingsIntEditor(
                  tips: Translations.settings.maxCoHostCount,
                  value: LiveStreamingCache().maxCoHostCount,
                  onChanged: (value) {
                    setState(() {
                      LiveStreamingCache().maxCoHostCount = value;
                    });
                  },
                ),
                settingsIntEditor(
                  tips: Translations.settings.inviteTimeoutSecond,
                  value: LiveStreamingCache().inviteTimeoutSecond,
                  onChanged: (value) {
                    setState(() {
                      LiveStreamingCache().inviteTimeoutSecond = value;
                    });
                  },
                ),
              ],
            ),
            settingsGroup(
              Translations.settings.signalingPlugin,
              [
                settingsCheckBox(
                  title: Translations.settings.signalingPluginUninitOnDispose,
                  value: LiveStreamingCache().signalingPluginUninitOnDispose,
                  onChanged: (value) {
                    setState(() {
                      LiveStreamingCache().signalingPluginUninitOnDispose =
                          value ?? false;
                    });
                  },
                ),
                settingsCheckBox(
                  title:
                      Translations.settings.signalingPluginLeaveRoomOnDispose,
                  value: LiveStreamingCache().signalingPluginLeaveRoomOnDispose,
                  onChanged: (value) {
                    setState(() {
                      LiveStreamingCache().signalingPluginLeaveRoomOnDispose =
                          value ?? true;
                    });
                  },
                ),
              ],
            ),
            settingsGroup(
              Translations.settings.pip,
              [
                settingsIntEditor(
                  tips: Translations.settings.pipAspectWidth,
                  value: LiveStreamingCache().pipAspectWidth,
                  onChanged: (value) {
                    setState(() {
                      LiveStreamingCache().pipAspectWidth = value;
                    });
                  },
                ),
                settingsIntEditor(
                  tips: Translations.settings.pipAspectHeight,
                  value: LiveStreamingCache().pipAspectHeight,
                  onChanged: (value) {
                    setState(() {
                      LiveStreamingCache().pipAspectHeight = value;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget liveIDEditor() {
    return StringListTextEditor(
      tips: Translations.settings.idTips,
      fontSize: 20.r,
      defaultValues: LiveStreamingCache().roomIDList.value,
      onAdd: (String roomID) {
        LiveStreamingCache().addRoomID(roomID);
      },
      onDelete: (String roomID) {
        LiveStreamingCache().removeRoomID(roomID);
      },
    );
  }

  Widget liveListStreamMode() {
    return settingSwitchDropList<ZegoLiveStreamingStreamMode>(
      title: Translations.settings.streamMode,
      defaultValue: LiveStreamingCache().streamMode,
      itemValues: [
        ZegoLiveStreamingStreamMode.preloaded,
        ZegoLiveStreamingStreamMode.economy,
      ],
      onChanged: (streamMode) {
        setState(() {
          LiveStreamingCache().streamMode = streamMode;
        });
      },
      widgetBuilder: (streamMode) {
        return Text(
          streamMode.name,
          style: settingsTextStyle,
        );
      },
    );
  }

  Widget liveListEditor() {
    return ValueListenableBuilder<List<String>>(
      valueListenable: LiveStreamingCache().roomIDList,
      builder: (context, roomIDList, _) {
        return ValueListenableBuilder(
            valueListenable: LiveStreamingCache().liveListMap,
            builder: (context, liveList, _) {
              return StringListListTextEditor(
                tips: Translations.settings.liveListIdTips,
                fontSize: 20.r,
                leftHeader: Translations.settings.liveListIdHostID,
                rightHeader: Translations.settings.liveListIdLiveID,
                defaultLeftValues: liveList.keys.toList(),
                defaultLeftRightMap: liveList,
                defaultRightValues: roomIDList,
                onAdd: (String hostID, String liveID) {
                  LiveStreamingCache().addLiveList(hostID, liveID);
                },
                onUpdate: (String hostID, String liveID) {
                  setState(() {
                    LiveStreamingCache().addLiveList(hostID, liveID);
                  });
                },
                onDelete: (String hostID) {
                  LiveStreamingCache().removeLiveList(hostID);
                },
              );
            });
      },
    );
  }
}
