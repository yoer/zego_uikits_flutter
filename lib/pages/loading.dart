// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:zego_uikits_demo/data/settings.dart';
import 'package:zego_uikits_demo/data/user.dart';
import 'package:zego_uikits_demo/pages/home.dart';
import 'package:zego_uikits_demo/pages/login.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => LoadingPageState();
}

class LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: UserService().isLogin && SettingsCache().isAppKeyValid
          ? const HomePage()
          : const LoginPage(),
    );
  }
}
