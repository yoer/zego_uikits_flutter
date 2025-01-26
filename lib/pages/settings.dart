// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import 'package:zego_uikits_demo/common/settings.dart';
import 'package:zego_uikits_demo/common/toast.dart';
import 'package:zego_uikits_demo/data/settings.dart';
import 'package:zego_uikits_demo/data/translations.dart';
import 'package:zego_uikits_demo/data/user.dart';
import 'package:zego_uikits_demo/kits/call/utils.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() {
    return _SettingsPageState();
  }
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController appIdController = TextEditingController();
  final TextEditingController appSignController = TextEditingController();
  final TextEditingController appTokenController = TextEditingController();
  final RegExp appIDRegex = RegExp(r'^\d+$');
  final RegExp appSignRegex = RegExp(r'^[0-9a-z]{64}$');

  final saveButtonEnableNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();

    appIdController.text = SettingsCache().appID;
    appSignController.text = SettingsCache().appSign;
    appTokenController.text = SettingsCache().appToken;

    _updateButtonState();
    appIdController.addListener(_updateButtonState);
    appSignController.addListener(_updateButtonState);
    appTokenController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    super.dispose();

    appIdController.dispose();
    appSignController.dispose();
    appTokenController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final titleTextStyle = TextStyle(
      fontSize: 18.r,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    );
    final textStyle = TextStyle(fontSize: 18.r, color: Colors.black);
    final consoleURL = 'https://console.zegocloud.com/';

    return PopScope(
      canPop: true,
      child: Scaffold(
        appBar: AppBar(
          title: Text(Translations.settings.title),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                settingsGroup(
                  'App Keys',
                  [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          child: Text(
                            Translations.settings.consoleURLTips,
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 18.r,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          onTap: () async {
                            final Uri uri = Uri.parse(consoleURL);
                            if (await canLaunchUrl(uri)) {
                              await launchUrl(uri);
                            }
                          },
                        ),
                        SizedBox(width: 20.r),
                        GestureDetector(
                          child: Text(
                            Translations.settings.copyURL,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.r,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          onTap: () async {
                            Clipboard.setData(ClipboardData(text: consoleURL))
                                .then((_) {
                              showInfoToast(Translations.settings.copied);
                            });
                          },
                        )
                      ],
                    ),
                    Text('App ID:', style: titleTextStyle),
                    TextField(
                      controller: appIdController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: '0 ~ 4294967295',
                      ),
                      style: textStyle,
                    ),
                    SizedBox(height: 16.r),
                    Text('App Sign:', style: titleTextStyle),
                    TextField(
                      controller: appSignController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'a 64-character string',
                      ),
                      style: textStyle,
                    ),
                    SizedBox(height: 16.r),
                    Text(
                      'App Token (${Translations.settings.optional}):',
                      style: titleTextStyle,
                    ),
                    TextField(
                      controller: appTokenController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText:
                            'Enter App Token (${Translations.settings.optional})',
                      ),
                      style: textStyle,
                    ),
                  ],
                ),
                settingsGroup(
                  Translations.settings.common,
                  [
                    // settingsCheckBox(
                    //   title: '${Translations.settings.useFirestore}(*)',
                    //   value: SettingsCache().useFirestore,
                    //   onChanged: (value) {
                    //     SettingsCache().useFirestore = value ?? true;
                    //
                    //     setState(() {});
                    //   },
                    // ),
                    settingsCheckBox(
                      title: Translations.settings.showSplash,
                      value: SettingsCache().showSplash,
                      onChanged: (value) {
                        SettingsCache().showSplash = value ?? true;

                        setState(() {});
                      },
                    ),
                    settingsRadio(
                      title: Translations.drawer.language,
                      defaultValue: context.locale,
                      items: [
                        MyLocale.zhCN,
                        MyLocale.enUS,
                        MyLocale.hiIN,
                      ],
                      onChanged: (value) {
                        context.setLocale(value);
                      },
                    ),
                  ],
                ),
                const Expanded(child: SizedBox()),
                saveButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget saveButton() {
    return SizedBox(
      width: double.infinity,
      height: 100.r,
      child: ValueListenableBuilder(
        valueListenable: saveButtonEnableNotifier,
        builder: (context, isButtonEnabled, _) {
          return ElevatedButton(
            onPressed: () {
              String appID = appIdController.text;
              String appSign = appSignController.text;
              String appToken = appTokenController.text;

              SettingsCache()
                  .saveAppKey(
                appID: appID,
                appSign: appSign,
                appToken: appToken,
              )
                  .then((_) {
                if (UserService().isLogin) {
                  initCallInvitation();
                }
              });

              context.pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: isButtonEnabled ? Colors.green : Colors.grey,
              minimumSize: const Size(
                double.infinity,
                50,
              ),
            ),
            child: Text(
              Translations.settings.save,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30.r,
              ),
            ),
          );
        },
      ),
    );
  }

  void _updateButtonState() {
    final appIdText = appIdController.text;
    final appSignText = appSignController.text;
    final appToken = appTokenController.text;

    if (appIDRegex.hasMatch(appIdText)) {
      final int appId = int.parse(appIdText);
      saveButtonEnableNotifier.value = (appId >= 0 && appId <= 4294967295);
    } else {
      saveButtonEnableNotifier.value = false;
    }

    if (appToken.isNotEmpty) {
      saveButtonEnableNotifier.value &= saveButtonEnableNotifier.value && true;
    } else {
      saveButtonEnableNotifier.value &=
          saveButtonEnableNotifier.value && appSignRegex.hasMatch(appSignText);
    }
  }
}
