// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_prebuilt_live_audio_room/zego_uikit_prebuilt_live_audio_room.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';
import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

// Project imports:
import 'package:zego_uikits_demo/common/logo.dart';
import 'package:zego_uikits_demo/data/translations.dart';

class AboutsPage extends StatefulWidget {
  const AboutsPage({super.key});

  @override
  State<AboutsPage> createState() {
    return _AboutsPagePageState();
  }
}

class _AboutsPagePageState extends State<AboutsPage> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: Scaffold(
        appBar: AppBar(
          title: Text(Translations.drawer.about),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.0.r),
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0.r),
              child: Column(
                children: [
                  uikitsLogo(MediaQuery.of(context).size.width * 0.8),
                  SizedBox(height: 8.h),
                  logo(),
                  SizedBox(height: 80.r),
                  kitsInfo(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget kitsInfo() {
    return Table(
      border: TableBorder.all(),
      children: [
        const TableRow(children: [
          TableCell(child: Center(child: Text('Kit'))),
          TableCell(child: Center(child: Text('Version'))),
        ]),

        /// beta api
        // TableRow(children: [
        //   const TableCell(child: Center(child: Text('Call'))),
        //   TableCell(
        //     child: Center(
        //       child: Text(ZegoUIKitPrebuiltCallController().version),
        //     ),
        //   ),
        // ]),
        // TableRow(children: [
        //   const TableCell(child: Center(child: Text('LiveAudioRoom'))),
        //   TableCell(
        //     child: Center(
        //       child: Text(ZegoUIKitPrebuiltLiveAudioRoomController().version),
        //     ),
        //   ),
        // ]),
        // TableRow(children: [
        //   const TableCell(child: Center(child: Text('LiveStreaming'))),
        //   TableCell(
        //     child: Center(
        //       child: Text(ZegoUIKitPrebuiltLiveStreamingController().version),
        //     ),
        //   ),
        // ]),
        // TableRow(children: [
        //   const TableCell(child: Center(child: Text('VideoConference'))),
        //   TableCell(
        //     child: Center(
        //       child: Text(ZegoUIKitPrebuiltVideoConferenceController().version),
        //     ),
        //   ),
        // ]),
        TableRow(children: [
          const TableCell(child: Center(child: Text('ZIMKit'))),
          TableCell(child: Center(child: Text(ZIMKit().getVersion()))),
        ]),
      ],
    );
  }
}
