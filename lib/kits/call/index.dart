// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:zego_uikits_demo/common/toast.dart';
import 'package:zego_uikits_demo/data/assets.dart';
import 'package:zego_uikits_demo/data/settings.dart';
import 'package:zego_uikits_demo/data/translations.dart';
import 'package:zego_uikits_demo/kits/call/group.dart';
import 'package:zego_uikits_demo/kits/call/invitation/page.dart';
import 'package:zego_uikits_demo/kits/call/one_on_one.dart';
import 'package:zego_uikits_demo/kits/kits_page.dart';
import 'package:zego_uikits_demo/pages/utils/router.dart';

class CallPage extends StatefulWidget {
  const CallPage({super.key});

  @override
  State<CallPage> createState() {
    return _CallPageState();
  }
}

class _CallPageState extends State<CallPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Timer? _tabSwitchTimer;
  final _tabPageCount = 3;
  final _tagPageIndexNotifier = ValueNotifier<int>(0);

  final tabSwitchEnabledNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: _tabPageCount, vsync: this);
    _tagPageIndexNotifier.value = 0;
    _tabController.addListener(() {
      _tagPageIndexNotifier.value = _tabController.index;
    });

    startTabSwitchTimer();

    if (!SettingsCache().isAppKeyValid) {
      showFailedToast('Please set app id/sign by settings');
    }
  }

  @override
  void dispose() {
    super.dispose();

    _tabController.dispose();
    _tabSwitchTimer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10.r),
            child: Text(
              '👈🏻 ${Translations.tab.swipeTips} 👉🏻',
              style: TextStyle(fontSize: 20.r, fontStyle: FontStyle.italic),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.r),
            child: PreferredSize(
              preferredSize: Size.fromHeight(30.r),
              child: ValueListenableBuilder(
                valueListenable: _tagPageIndexNotifier,
                builder: (context, tabIndex, _) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _tabPageCount,
                      (index) {
                        return GestureDetector(
                          onTap: () {
                            _tabController.index = index;
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 4.r),
                            width: 20.r,
                            height: 20.r,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: tabIndex == index
                                  ? Colors.black
                                  : Colors.yellow,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                KitsPage(
                  backgroundURL: CallAssets.adInvitation,
                  title: Translations.call.invitationTitle,
                  onSettingsClicked: () {
                    PageRouter.callSettings.go(context);
                  },
                  child: Listener(
                    onPointerDown: (_) {
                      resetTabSwitchTimer();
                    },
                    onPointerUp: (_) {
                      resetTabSwitchTimer();
                    },
                    child: CallInvitationPage(
                      outsideTabSwitchEnabledNotifier: tabSwitchEnabledNotifier,
                    ),
                  ),
                ),
                KitsPage(
                  backgroundURL: CallAssets.adOneOnOne,
                  title: Translations.call.oneOnOneTitle,
                  onSettingsClicked: () {
                    PageRouter.callSettings.go(context);
                  },
                  child: const OneOnOneCallPage(),
                ),
                KitsPage(
                  backgroundURL: CallAssets.adGroup,
                  title: Translations.call.groupTitle,
                  onSettingsClicked: () {
                    PageRouter.callSettings.go(context);
                  },
                  child: const GroupCallPage(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void startTabSwitchTimer() {
    if (_tabSwitchTimer != null) {
      _tabSwitchTimer?.cancel();
    }

    _tabSwitchTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (!tabSwitchEnabledNotifier.value) {
        return;
      }

      if (_tabController.index < _tabController.length - 1) {
        _tabController.index++;
      } else {
        _tabController.index = 0;
      }
    });
  }

  void resetTabSwitchTimer() {
    startTabSwitchTimer();
  }
}
