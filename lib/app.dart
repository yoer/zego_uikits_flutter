// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_prebuilt_live_audio_room/zego_uikit_prebuilt_live_audio_room.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

// Project imports:
import 'package:zego_uikits_demo/pages/utils/router.dart';
import 'common/constant.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(750, 1334),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          /// easy_localization
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,

          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            useMaterial3: true,
            drawerTheme: const DrawerThemeData(
              scrimColor: Colors.transparent,
              shadowColor: Colors.black,
            ),
          ),
          routerConfig: router,
          builder: (BuildContext context, Widget? child) {
            return Stack(
              children: [
                child!,
                ZegoUIKitPrebuiltCallMiniOverlayPage(
                  contextQuery: () {
                    return navigatorKey.currentState!.context;
                  },
                ),
                ZegoUIKitPrebuiltLiveAudioRoomMiniOverlayPage(
                  contextQuery: () {
                    return navigatorKey.currentState!.context;
                  },
                ),
                ZegoUIKitPrebuiltLiveStreamingMiniOverlayPage(
                  contextQuery: () {
                    return navigatorKey.currentState!.context;
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
