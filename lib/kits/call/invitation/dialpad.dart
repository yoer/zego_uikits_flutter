// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_dialpad/flutter_dialpad.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:zego_uikit/zego_uikit.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

// Project imports:
import 'package:zego_uikits_demo/common/avatar.dart';
import 'package:zego_uikits_demo/common/toast.dart';
import 'package:zego_uikits_demo/data/user.dart';
import 'package:zego_uikits_demo/kits/call/cache.dart';
import 'package:zego_uikits_demo/kits/call/utils.dart';

class CallInvitationDialPad extends StatefulWidget {
  const CallInvitationDialPad({
    required this.outsideTabSwitchEnabledNotifier,
    super.key,
  });

  final ValueNotifier<bool> outsideTabSwitchEnabledNotifier;

  @override
  State<StatefulWidget> createState() => CallInvitationDialPadState();
}

class CallInvitationDialPadState extends State<CallInvitationDialPad> {
  String callNumber = '';
  final callNumbersNotifier = ValueNotifier<List<String>>([]);

  TextStyle get inviteeTextStyle => TextStyle(
        color: Colors.black,
        fontSize: 20.r,
      );

  @override
  void initState() {
    super.initState();

    callNumbersNotifier.value = CallCache().dialInviteeIDs;
    callNumbersNotifier.addListener(onCallNumbersUpdated);
  }

  @override
  void dispose() {
    super.dispose();

    callNumbersNotifier.removeListener(onCallNumbersUpdated);
  }

  @override
  Widget build(BuildContext context) {
    final topBarHeight = 80.r;
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                top: topBarHeight,
                bottom: 0,
                child: dialPad(),
              ),
              Positioned(
                child: SizedBox(
                  height: topBarHeight,
                  child: listview(),
                ),
              ),
              Positioned(
                top: 10.r,
                right: 10.r,
                child: IconButton(
                  icon: Icon(
                    Icons.help,
                    color: Colors.yellow,
                    size: 60.r,
                  ),
                  onPressed: () {
                    showInfoToast('Press \'#\' to continue add caller');
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget dialPad() {
    return DialPad(
      enableDtmf: true,
      outputMask: "000000000",
      buttonColor: Colors.grey.withOpacity(0.5),
      backspaceButtonIconColor: Colors.red,
      valueUpdated: (String value) {
        callNumber = value;
      },
      keyPressed: (String tempKey) {
        const brokeKey = '＃';
        final key = tempKey.trim();

        if (brokeKey == key) {
          if (callNumber.isNotEmpty) {
            callNumbersNotifier.value = [
              ...callNumbersNotifier.value,
              callNumber,
            ];
          }
        }

        return key == brokeKey;
      },
      audioDialButtonBuilder: (double sizeFactor) {
        return ValueListenableBuilder<List<String>>(
          valueListenable: callNumbersNotifier,
          builder: (context, callNumbers, _) {
            return sendCallButton(
              isVideoCall: false,
              inviteeIDs: callNumbers.isEmpty ? [callNumber] : callNumbers,
              sizeFactor: sizeFactor,
              onCallFinished: onSendCallInvitationFinished,
            );
          },
        );
      },
      videoDialButtonBuilder: (double sizeFactor) {
        return ValueListenableBuilder<List<String>>(
          valueListenable: callNumbersNotifier,
          builder: (context, callNumbers, _) {
            return sendCallButton(
              isVideoCall: true,
              inviteeIDs: callNumbers.isEmpty ? [callNumber] : callNumbers,
              sizeFactor: sizeFactor,
              onCallFinished: onSendCallInvitationFinished,
            );
          },
        );
      },
    );
  }

  Widget sendCallButton({
    required bool isVideoCall,
    required List<String> inviteeIDs,
    required double sizeFactor,
    void Function(
      String code,
      String message,
      List<String> errorInvitees,
    )? onCallFinished,
  }) {
    final currentUser = UserService().loginUserNotifier.value;
    if (null == currentUser) {
      return const SizedBox();
    }

    final invitees = inviteeIDs
        .map((inviteeID) => ZegoUIKitUser(id: inviteeID, name: ''))
        .toList();
    return ZegoSendCallInvitationButton(
      isVideoCall: isVideoCall,
      invitees: invitees,
      resourceID: CallCache().invitation.resourceID,
      iconSize: Size(sizeFactor * 0.8, sizeFactor * 0.8),
      buttonSize: Size(sizeFactor, sizeFactor),
      timeoutSeconds: CallCache().invitation.timeoutSecond,
      onWillPressed: () async {
        final canCall =
            callNumber.isNotEmpty || callNumbersNotifier.value.isNotEmpty;
        if (!canCall) {
          showInfoToast('Please enter User ID');
        }

        return canCall;
      },
      onPressed: onCallFinished,
    );
  }

  Widget listview() {
    return ValueListenableBuilder<List<String>>(
      valueListenable: callNumbersNotifier,
      builder: (context, callNumbers, _) {
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: callNumbers.length,
          itemBuilder: (context, index) {
            final closeIconSize = 30.r;
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 10.r),
              padding: EdgeInsets.all(10.r),
              constraints: BoxConstraints(
                minWidth: 180.r,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 50.r,
                      height: 50.r,
                      child: avatar(callNumbers[index]),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: SizedBox(
                      width: 180.r,
                      child: Text(
                        callNumbers[index],
                        style: inviteeTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        callNumbers.removeAt(index);
                        callNumbersNotifier.value = [...callNumbers];
                      },
                      child: Container(
                        width: closeIconSize,
                        height: closeIconSize,
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.3),
                          borderRadius:
                              BorderRadius.circular(closeIconSize / 2.0),
                        ),
                        child: Icon(Icons.close, size: closeIconSize),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void onCallNumbersUpdated() {
    widget.outsideTabSwitchEnabledNotifier.value =
        callNumbersNotifier.value.isNotEmpty;

    CallCache().dialInviteeIDs = callNumbersNotifier.value;
  }
}
