// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:zego_uikits_demo/common/constant.dart';
import 'package:zego_uikits_demo/kits/audio_room/settings.dart';
import 'package:zego_uikits_demo/kits/call/settings.dart';
import 'package:zego_uikits_demo/kits/chat/settings.dart';
import 'package:zego_uikits_demo/kits/conference/settings.dart';
import 'package:zego_uikits_demo/kits/live_streaming/settings.dart';
import 'package:zego_uikits_demo/pages/about.dart';
import 'package:zego_uikits_demo/pages/feedback.dart';
import 'package:zego_uikits_demo/pages/home.dart';
import 'package:zego_uikits_demo/pages/loading.dart';
import 'package:zego_uikits_demo/pages/login.dart';
import 'package:zego_uikits_demo/pages/settings.dart';
import 'package:zego_uikits_demo/pages/splash.dart';

enum PageRouter {
  splash,
  loading,
  home,
  login,
  settings,
  abouts,
  feedbacks,
  callSettings,
  audioRoomSettings,
  liveStreamingSettings,
  conferenceSettings,
  chatSettings,
}

extension PageRouterExtension on PageRouter {
  String get name {
    switch (this) {
      case PageRouter.splash:
        return 'splash';
      case PageRouter.loading:
        return 'loading';
      case PageRouter.login:
        return 'login';
      case PageRouter.home:
        return 'home';
      case PageRouter.settings:
        return 'settings';
      case PageRouter.abouts:
        return 'abouts';
      case PageRouter.feedbacks:
        return 'feedbacks';
      case PageRouter.callSettings:
        return 'call settings';
      case PageRouter.audioRoomSettings:
        return 'audio room settings';
      case PageRouter.liveStreamingSettings:
        return 'live streaming settings';
      case PageRouter.conferenceSettings:
        return 'conference settings';
      case PageRouter.chatSettings:
        return 'chat settings';
    }
  }

  String get path {
    switch (this) {
      case PageRouter.splash:
        return '/';
      case PageRouter.loading:
        return '/loading';
      case PageRouter.login:
        return '/login';
      case PageRouter.home:
        return '/home';
      case PageRouter.settings:
        return '/settings';
      case PageRouter.abouts:
        return '/abouts';
      case PageRouter.feedbacks:
        return '/feedbacks';
      case PageRouter.callSettings:
        return '/call/settings';
      case PageRouter.audioRoomSettings:
        return '/audio_room/settings';
      case PageRouter.liveStreamingSettings:
        return '/live_streaming/settings';
      case PageRouter.conferenceSettings:
        return '/conference/settings';
      case PageRouter.chatSettings:
        return '/chat/settings';
    }
  }

  Future<void> go(
    BuildContext context, {
    Map<String, String> parameters = const {},
  }) async {
    if (parameters.isEmpty) {
      await context.pushNamed(name);
    } else {
      await context.push(
        context.namedLocation(
          name,
          pathParameters: parameters,
        ),
      );
    }
  }
}

GoRouter router = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: PageRouter.splash.path,
  routes: [
    GoRoute(
      path: PageRouter.splash.path,
      name: PageRouter.splash.name,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: PageRouter.loading.path,
      name: PageRouter.loading.name,
      builder: (context, state) => const LoadingPage(),
    ),
    GoRoute(
      path: PageRouter.home.path,
      name: PageRouter.home.name,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: PageRouter.login.path,
      name: PageRouter.login.name,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: PageRouter.settings.path,
      name: PageRouter.settings.name,
      builder: (context, state) => const SettingsPage(),
    ),
    GoRoute(
      path: PageRouter.abouts.path,
      name: PageRouter.abouts.name,
      builder: (context, state) => const AboutsPage(),
    ),
    GoRoute(
      path: PageRouter.feedbacks.path,
      name: PageRouter.feedbacks.name,
      builder: (context, state) => const FeedbacksPage(),
    ),
    GoRoute(
      path: PageRouter.callSettings.path,
      name: PageRouter.callSettings.name,
      builder: (context, state) => const CallPageSettings(),
    ),
    GoRoute(
      path: PageRouter.audioRoomSettings.path,
      name: PageRouter.audioRoomSettings.name,
      builder: (context, state) => const AudioRoomPageSettings(),
    ),
    GoRoute(
      path: PageRouter.liveStreamingSettings.path,
      name: PageRouter.liveStreamingSettings.name,
      builder: (context, state) => const LiveStreamingPageSettings(),
    ),
    GoRoute(
      path: PageRouter.conferenceSettings.path,
      name: PageRouter.conferenceSettings.name,
      builder: (context, state) => const ConferencePageSettings(),
    ),
    GoRoute(
      path: PageRouter.chatSettings.path,
      name: PageRouter.chatSettings.name,
      builder: (context, state) => const ChatPageSettings(),
    ),
  ],
);
