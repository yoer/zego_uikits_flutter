// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

// Project imports:
import 'package:zego_uikits_demo/data/settings.dart';
import 'package:zego_uikits_demo/data/translations.dart';
import 'package:zego_uikits_demo/data/user.dart';
import 'package:zego_uikits_demo/data/zego.dart';
import 'package:zego_uikits_demo/kits/audio_room/cache.dart';
import 'package:zego_uikits_demo/kits/call/cache.dart';
import 'package:zego_uikits_demo/kits/conference/cache.dart';
import 'package:zego_uikits_demo/kits/live_streaming/cache.dart';
import 'package:zego_uikits_demo/kits/live_streaming/gifts/service.dart';
import 'package:zego_uikits_demo/pages/utils/router.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => LoadingPageState();
}

class LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: FutureBuilder(
          future: Future.wait([
            SettingsCache().load(),
            AudioRoomCache().load(),
            CallCache().load(),
            LiveStreamingCache().load(),
            ConferenceCache().load(),
            GiftService().init(),
            UserService().tryAutoLogin(),
          ]),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('load failed: ${snapshot.error}'));
            }

            if (snapshot.connectionState == ConnectionState.done) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (UserService().isLogin && SettingsCache().isAppKeyValid) {
                  PageRouter.home.go(context);
                } else {
                  PageRouter.login.go(context);
                }
              });
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
