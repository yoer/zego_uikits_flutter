// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:zego_uikit/zego_uikit.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

// Project imports:
import 'package:zego_uikits_demo/common/avatar.dart';
import 'package:zego_uikits_demo/data/assets.dart';
import 'package:zego_uikits_demo/data/translations.dart';
import 'package:zego_uikits_demo/data/user.dart';
import 'package:zego_uikits_demo/firestore/kits_service.dart';
import 'package:zego_uikits_demo/firestore/user_doc.dart';
import 'package:zego_uikits_demo/kits/call/cache.dart';
import 'package:zego_uikits_demo/kits/call/utils.dart';
import 'package:zego_uikits_demo/kits/chat/chatting_page.dart';
import 'package:zego_uikits_demo/pages/utils/bottom_nav.dart';

class Contact extends StatefulWidget {
  const Contact({
    super.key,
    required this.pageController,
  });
  final PageController pageController;

  @override
  State<Contact> createState() {
    return _ContactState();
  }
}

class _ContactState extends State<Contact> with SingleTickerProviderStateMixin {
  late final controller = SlidableController(this);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 10.r,
        top: 10.r,
        bottom: 10.r,
      ),
      child: LayoutBuilder(
        builder: (context, constraint) {
          return ValueListenableBuilder<Map<String, UserDoc>>(
            valueListenable: KitsFirebaseService().userTable.cacheNotifier,
            builder: (context, userDocsMap, _) {
              final currentLoginUser = UserService().loginUserNotifier.value;

              final userDocs = userDocsMap.values.toList();
              userDocs.removeWhere((e) => e.id == currentLoginUser?.id);
              userDocs.sort((left, right) => left.id.compareTo(right.id));
              return userDocs.isEmpty
                  ? emptyTips()
                  : ListView.builder(
                      itemCount: userDocs.length,
                      itemBuilder: (context, index) {
                        final userDoc = userDocs[index];
                        return contactItem(userDoc, constraint, index);
                      },
                    );
            },
          );
        },
      ),
    );
  }

  Widget emptyTips() {
    return Center(
      child: Text(
        Translations.call.contactsEmptyTips,
        style: TextStyle(
          color: Colors.black,
          fontSize: 30.r,
        ),
      ),
    );
  }

  Widget contactItem(
    UserDoc userDoc,
    BoxConstraints constraint,
    int index,
  ) {
    final rowHeight = 150.r;
    final iconSize = 100.r;
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
              color: Colors.black.withValues(alpha: 0.1), width: 2.r),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: iconSize,
            height: iconSize,
            child: CircleAvatar(
              child: avatar(userDoc.id),
            ),
          ),
          SizedBox(width: 5.r),
          Text(
            userDoc.name,
            style: TextStyle(
              color: userDoc.isLogin ? Colors.black : Colors.grey,
              fontSize: 30.r,
            ),
          ),
          const Expanded(child: SizedBox()),
          chatButton(
            userDoc,
            Size(80.r, 80.r),
          ),
          SizedBox(width: 5.r),
          callButton(
            false,
            userDoc,
            Size(iconSize, rowHeight),
          ),
          callButton(
            true,
            userDoc,
            Size(iconSize, rowHeight),
          ),
        ],
      ),
    );
  }

  Widget chatButton(UserDoc userDoc, Size size) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        widget.pageController.jumpToPage(BottomNavIndex.chat.index);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return DemoChattingMessageListPage(
                conversationID: userDoc.id,
                conversationType: ZIMConversationType.peer,
              );
            },
          ),
        );
      },
      child: Image.asset(
        MyIcons.chat,
        width: size.width,
        height: size.height,
      ),
    );
  }

  Widget callButton(bool isVideoCall, UserDoc userDoc, Size size) {
    return ZegoSendCallInvitationButton(
      isVideoCall: isVideoCall,
      invitees: [
        ZegoUIKitUser(id: userDoc.id, name: userDoc.name),
      ],
      resourceID: CallCache().invitation.resourceID,
      iconSize: Size(size.width * 0.8, size.height * 0.8),
      buttonSize: size,
      timeoutSeconds: CallCache().invitation.timeoutSecond,
      onPressed: onSendCallInvitationFinished,
    );
  }
}
