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
            ]),
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
