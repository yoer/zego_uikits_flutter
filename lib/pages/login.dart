// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:zego_uikits_demo/common/connect_status.dart';
import 'package:zego_uikits_demo/common/logo.dart';
import 'package:zego_uikits_demo/common/toast.dart';
import 'package:zego_uikits_demo/common/user_id.dart';
import 'package:zego_uikits_demo/data/assets.dart';
import 'package:zego_uikits_demo/data/settings.dart';
import 'package:zego_uikits_demo/data/translations.dart';
import 'package:zego_uikits_demo/data/user.dart';
import 'package:zego_uikits_demo/data/zego.dart';
import 'package:zego_uikits_demo/pages/utils/router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final buttonValidNotifier = ValueNotifier<bool>(false);
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    getUniqueUserId().then((userID) {
      userIdController.text = userID;
      userNameController.text = 'user_$userID';
      buttonValidNotifier.value = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: NetworkLoading(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  PageRouter.settings.go(context);
                },
              ),
            ],
          ),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.r),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    uikitsLogo(MediaQuery.of(context).size.width * 0.8),
                    SizedBox(height: 8.h),
                    logo(),
                    SizedBox(height: 80.h),
                    userID(),
                    SizedBox(height: 20.h),
                    userName(),
                    SizedBox(height: 80.h),
                    loginButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget userID() {
    return TextField(
      controller: userIdController,
      decoration: InputDecoration(
        labelText: Translations.login.id,
        border: const OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(9),
      ],
      onChanged: (text) {
        buttonValidNotifier.value =
            text.isNotEmpty && userNameController.text.isNotEmpty;
      },
    );
  }

  Widget userName() {
    return TextField(
      controller: userNameController,
      decoration: InputDecoration(
        labelText: Translations.login.name,
        border: const OutlineInputBorder(),
      ),
      keyboardType: TextInputType.text,
      onChanged: (text) {
        buttonValidNotifier.value =
            text.isNotEmpty && userIdController.text.isNotEmpty;
      },
    );
  }

  Widget loginButton() {
    return ValueListenableBuilder(
      valueListenable: buttonValidNotifier,
      builder: (context, isValid, _) {
        return ElevatedButton(
          onPressed: isValid
              ? () async {
                  if (!SettingsCache().isAppKeyValid) {
                    showFailedToast(Translations.tips.appIDSign);

                    return;
                  }

                  final userId = userIdController.text;
                  final userName = userNameController.text;

                  UserService()
                      .login(UserInfo(id: userId, name: userName))
                      .then((_) {
                    showInfoToast(Translations.login.success);

                    PageRouter.home.go(context);
                  });
                }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: isValid ? Colors.green : Colors.grey,
            minimumSize: const Size(
              double.infinity,
              50,
            ),
          ),
          child: Text(
            Translations.login.signIn,
            style: TextStyle(
              color: Colors.white,
              fontSize: 30.r,
            ),
          ),
        );
      },
    );
  }
}
