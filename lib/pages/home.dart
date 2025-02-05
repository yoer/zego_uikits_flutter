// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

// Project imports:
import 'package:zego_uikits_demo/common/avatar.dart';
import 'package:zego_uikits_demo/common/connect_status.dart';
import 'package:zego_uikits_demo/data/translations.dart';
import 'package:zego_uikits_demo/data/user.dart';
import 'package:zego_uikits_demo/data/zego.dart';
import 'package:zego_uikits_demo/kits/audio_room/index.dart';
import 'package:zego_uikits_demo/kits/call/index.dart';
import 'package:zego_uikits_demo/kits/chat/index.dart';
import 'package:zego_uikits_demo/kits/conference/index.dart';
import 'package:zego_uikits_demo/kits/live_streaming/index.dart';
import 'package:zego_uikits_demo/pages/utils/bottom_nav.dart';
import 'package:zego_uikits_demo/pages/utils/style.dart';
import '../common/bottom_sheet.dart';
import '../data/assets.dart';
import 'contact.dart';
import 'more_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final tabIndexNotifier = ValueNotifier<int>(0);
  late PageController pageController;

  List<StreamSubscription<dynamic>?> subscriptions = [];

  @override
  void initState() {
    super.initState();

    if (kDebugMode) {
      subscriptions.add(ZegoUIKit().getErrorStream().listen(onUIKitError));
    }

    pageController = PageController(initialPage: 0);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ZegoSDKer().init().then((_) {
        /// beta api
        /// skip to call page page if app active by offline call
        // ZegoUIKitPrebuiltCallInvitationService().enterAcceptedOfflineCall();

        /// skip to offline conversation page if app active by offline chat
        ZIMKit().getOfflineConversationInfo().then((value) {
          if (value.valid) {
            pageController.jumpToPage(BottomNavIndex.chat.index);

            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return ZIMKitMessageListPage(
                    conversationID: value.senderID,
                    conversationType: value.conversionType,
                  );
                },
              ));
            });
          }
        });
      });
    });
  }

  @override
  void dispose() {
    super.dispose();

    for (final subscription in subscriptions) {
      subscription?.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: NetworkLoading(
        child: Scaffold(
          endDrawer: const MoreDrawer(),
          appBar: appBar(),
          body: SafeArea(
            child: ValueListenableBuilder(
              valueListenable: tabIndexNotifier,
              builder: (context, tabIndex, _) {
                return Stack(
                  children: [
                    body(),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: navigatorBar(tabIndex),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  PreferredSize appBar() {
    final loginUser = UserService().loginUserNotifier.value;
    return PreferredSize(
      preferredSize: Size.fromHeight(
        PageStyle.navigatorBarHeight(),
      ),
      child: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        flexibleSpace: Container(
          padding: EdgeInsets.only(
            left: 10.r,
            top: 10.r,
            right: 50.r,
            bottom: 10.r,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: PageStyle.navigatorBarHeight() / 2,
                    backgroundImage: NetworkImage(
                      avatarURL(loginUser?.id ?? ''),
                    ), //
                  ),
                  SizedBox(width: 10.w),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${Translations.login.id}:${loginUser?.id ?? Translations.login.unknown}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                          '${Translations.login.name}:${loginUser?.name ?? Translations.login.unknown}'),
                    ],
                  ),
                ],
              ),
              const Expanded(child: SizedBox()),
              ValueListenableBuilder(
                valueListenable: tabIndexNotifier,
                builder: (context, tabIndex, _) {
                  return contact(tabIndex);
                },
              ),
              SizedBox(width: 30.w),
            ],
          ),
        ),
      ),
    );
  }

  Widget body() {
    double screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: screenHeight - PageStyle.navigatorBarHeight(),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: PageView(
          controller: pageController,
          onPageChanged: (v) {
            tabIndexNotifier.value = v;
          },
          children: const [
            CallPage(),
            LiveStreamingPage(),
            AudioRoomPage(),
            ConferencePage(),
            ChatPage(),
          ],
        ),
      ),
    );
  }

  Widget contact(int tabIndex) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        onTap: () {
          openBottomSheet(
            title: Translations.call.contactsTitle,
            context: context,
            child: Contact(
              pageController: pageController,
            ),
            heightFactor: 0.8,
          );
        },
        child: Container(
          height: PageStyle.navigatorBarHeight(),
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 20.r,
          ),
          child: Image.asset(
            MyIcons.contact,
            width: 40.r,
            height: 40.r,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget navigatorBar(int tabIndex) {
    return CircleNavBar(
      activeIcons: [
        BottomNavIndex.call.icon,
        BottomNavIndex.liveStreaming.icon,
        BottomNavIndex.audioRoom.icon,
        BottomNavIndex.conference.icon,
        BottomNavIndex.chat.icon,
      ],
      inactiveIcons: [
        Text(BottomNavIndex.call.text),
        Text(BottomNavIndex.liveStreaming.text),
        Text(BottomNavIndex.audioRoom.text),
        Text(BottomNavIndex.conference.text),
        Text(BottomNavIndex.chat.text),
      ],
      color: Colors.white,
      height: PageStyle.navigatorBarHeight(),
      circleWidth: PageStyle.navigatorBarHeight(),
      activeIndex: tabIndex,
      onTap: (index) {
        tabIndexNotifier.value = index;
        pageController.jumpToPage(index);
      },
      padding: EdgeInsets.only(left: 20.r, right: 20.r, bottom: 5.r),
      cornerRadius: const BorderRadius.only(
        topLeft: Radius.circular(8),
        topRight: Radius.circular(8),
        bottomRight: Radius.circular(24),
        bottomLeft: Radius.circular(24),
      ),
      shadowColor: Colors.deepPurple,
      elevation: 5.r,
    );
  }

  void onUIKitError(ZegoUIKitError error) {
    debugPrint('onUIKitError:$error');
    // showFailedToast(
    //   '${Translations.tips.error}, ${Translations.tips.errorCode}:${error.code}, ${Translations.tips.errorMsg}:${error.message}',
    // );
  }
}
