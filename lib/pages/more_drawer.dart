// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:zego_uikits_demo/common/settings.dart';
import 'package:zego_uikits_demo/data/translations.dart';
import 'package:zego_uikits_demo/data/user.dart';
import 'utils/router.dart';

class MoreDrawer extends StatefulWidget {
  const MoreDrawer({
    super.key,
  });

  @override
  State<MoreDrawer> createState() {
    return _MoreDrawerState();
  }
}

class _MoreDrawerState extends State<MoreDrawer> {
  TextStyle get itemTextStyle => TextStyle(
        color: Colors.black,
        fontSize: 25.r,
      );
  EdgeInsetsGeometry get itemPadding =>
      EdgeInsets.fromLTRB(20.r, 5.r, 0.r, 5.r);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width / 5.0 * 2;

    return Drawer(
      width: width,
      backgroundColor: Colors.white,
      child: Container(
        margin: EdgeInsets.all(10.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 80.r),
            settingsButton(),
            feedbackButton(),
            aboutButton(),
            const Expanded(child: SizedBox()),
            logoutButton(),
            SizedBox(height: 80.r),
          ],
        ),
      ),
    );
  }

  Widget settingsButton() {
    return ListTile(
      title: Text(
        Translations.settings.title,
        style: itemTextStyle,
      ),
      contentPadding: itemPadding,
      leading: const Icon(
        Icons.settings,
        color: Colors.black,
      ),
      onTap: () async {
        PageRouter.settings.go(context);
      },
    );
  }

  Widget logoutButton() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular((20.r)),
      ),
      child: ListTile(
        title: Text(
          Translations.drawer.signOut,
          style: TextStyle(
            color: Colors.white,
            fontSize: 25.r,
          ),
        ),
        contentPadding: itemPadding,
        leading: const Icon(
          Icons.logout,
          color: Colors.white,
        ),
        onTap: () async {
          UserService().logout().then((_) {
            PageRouter.login.go(context);
          });
        },
      ),
    );
  }

  Widget aboutButton() {
    return ListTile(
      title: Text(
        Translations.drawer.about,
        style: itemTextStyle,
      ),
      contentPadding: itemPadding,
      leading: const Icon(
        Icons.info,
        color: Colors.black,
      ),
      onTap: () async {
        PageRouter.abouts.go(context);
      },
    );
  }

  Widget feedbackButton() {
    return ListTile(
      title: Text(
        Translations.drawer.feedback,
        style: itemTextStyle,
      ),
      contentPadding: itemPadding,
      leading: const Icon(
        Icons.feedback,
        color: Colors.black,
      ),
      onTap: () async {
        PageRouter.feedbacks.go(context);
      },
    );
  }
}
