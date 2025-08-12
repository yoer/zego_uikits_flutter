// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'dialpad.dart';
import 'history.dart';

class CallInvitationPage extends StatefulWidget {
  const CallInvitationPage({
    required this.outsideTabSwitchEnabledNotifier,
    super.key,
  });

  final ValueNotifier<bool> outsideTabSwitchEnabledNotifier;

  @override
  State<CallInvitationPage> createState() {
    return _CallInvitationPageState();
  }
}

class _CallInvitationPageState extends State<CallInvitationPage> {
  final currentIndexNotifier = ValueNotifier<int>(0);
  final childrenNotifier = ValueNotifier<List<Widget>>([]);

  @override
  void initState() {
    super.initState();

    childrenNotifier.value = [
      CallInvitationDialPad(
        outsideTabSwitchEnabledNotifier: widget.outsideTabSwitchEnabledNotifier,
      ),
      const CallInvitationHistory(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Widget>>(
      valueListenable: childrenNotifier,
      builder: (context, children, _) {
        return tabWidget(children);
      },
    );
  }

  Widget tabWidget(List<Widget> children) {
    return ValueListenableBuilder(
      valueListenable: currentIndexNotifier,
      builder: (context, currentIndex, _) {
        final bottomBarHeight = 130.r;
        return LayoutBuilder(builder: (context, constraints) {
          return Column(
            children: [
              SizedBox(
                child: SizedBox(
                  height: constraints.maxHeight - bottomBarHeight,
                  child: children[currentIndex],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey, width: 0.25),
                ),
                margin: EdgeInsets.only(bottom: 30.r),
                height: bottomBarHeight - 30.r,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () => onTabTapped(0),
                      child: Icon(
                        Icons.dialpad,
                        color: 0 == currentIndex ? Colors.black : Colors.grey,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => onTabTapped(1),
                      child: Icon(
                        Icons.history,
                        color: 1 == currentIndex ? Colors.black : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
      },
    );
  }

  void onTabTapped(int index) {
    currentIndexNotifier.value = index;
  }
}
