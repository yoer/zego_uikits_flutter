// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:introduction_screen/introduction_screen.dart';

// Project imports:
import 'package:zego_uikits_demo/data/assets.dart';
import 'package:zego_uikits_demo/data/settings.dart';
import 'package:zego_uikits_demo/data/translations.dart';
import 'package:zego_uikits_demo/pages/utils/router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: FutureBuilder(
        future: Future.wait([
          SettingsCache().load(),
        ]),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('load failed: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.done) {
            if (!SettingsCache().showSplash) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                PageRouter.loading.go(context);
              });
            } else {
              return splash();
            }
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget splash() {
    final bodyStyle = TextStyle(fontSize: 35.0.r);
    final pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 30.0.r, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0.r, 0.0, 16.0.r, 16.0.r),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      globalBackgroundColor: Colors.white,
      allowImplicitScrolling: true,
      autoScrollDuration: 3 * 1000,
      infiniteAutoScroll: true,
      globalFooter: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          child: const Text(
            'Enter',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          onPressed: () => onIntroEnd(context),
        ),
      ),
      pages: [
        PageViewModel(
          title: Translations.intro.title1v1Call,
          body: Translations.intro.body1v1Call,
          image: buildImage(CallAssets.adOneOnOne),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: Translations.intro.titleGroupCall,
          body: Translations.intro.bodyGroupCall,
          image: buildImage(CallAssets.adGroup),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: Translations.intro.titleLiveStreaming,
          body: Translations.intro.bodyLiveStreaming,
          image: buildImage(LiveStreamingAssets.ad),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: Translations.intro.titleAudioRoom,
          body: Translations.intro.bodyAudioRoom,
          image: buildImage(AudioRoomAssets.ad),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: Translations.intro.titleConference,
          body: Translations.intro.bodyConference,
          image: buildImage(ConferenceAssets.ad),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: Translations.intro.titleIMKit,
          body: Translations.intro.bodyIMKit,
          image: buildImage(ChatAssets.ad),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => onIntroEnd(context),
      onSkip: () => onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      //rtl: true, // Display as right-to-left
      // back: const Icon(Icons.arrow_back, color: Colors.red),
      skip: Text(
        Translations.intro.skip,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      next: const Icon(Icons.arrow_forward, color: Colors.white),
      done: Text(
        Translations.intro.done,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }

  Widget buildImage(String assetName, [double width = 350]) {
    return Image.asset(assetName, width: width, fit: BoxFit.cover);
  }

  void onIntroEnd(context) {
    SettingsCache().showSplash = false;

    PageRouter.loading.go(context);
  }
}
