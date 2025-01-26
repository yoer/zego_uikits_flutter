// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:zego_uikits_demo/common/toast.dart';
import 'package:zego_uikits_demo/data/translations.dart';

class FeedbacksPage extends StatefulWidget {
  const FeedbacksPage({super.key});

  @override
  _FeedbacksPageState createState() => _FeedbacksPageState();
}

class _FeedbacksPageState extends State<FeedbacksPage> {
  final buttonValidNotifier = ValueNotifier<bool>(false);

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  bool _addLogs = false;

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(fontSize: 18.r, color: Colors.black);

    return Scaffold(
      appBar: AppBar(
        title: Text(Translations.drawer.feedback),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: Translations.feedback.title,
                  border: const OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
                style: textStyle,
              ),
              SizedBox(height: 15.r),
              TextField(
                controller: _contentController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: '${Translations.feedback.content} *',
                  border: const OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
                style: textStyle,
                onChanged: (value) {
                  buttonValidNotifier.value = value.isNotEmpty;
                },
              ),
              SizedBox(height: 15.r),
              Row(
                children: [
                  Checkbox(
                    value: _addLogs,
                    onChanged: (value) {
                      setState(() {
                        _addLogs = value!;
                      });
                    },
                  ),
                  Text(
                    Translations.feedback.addLogs,
                    style: textStyle,
                  ),
                ],
              ),
              SizedBox(height: 15.r),
              button(),
            ],
          ),
        ),
      ),
    );
  }

  Widget button() {
    return ValueListenableBuilder(
      valueListenable: buttonValidNotifier,
      builder: (context, isValid, _) {
        return ElevatedButton(
          onPressed: () {
            final Email email = Email(
              body: _contentController.text,
              subject: _titleController.text.isEmpty
                  ? 'Empty'
                  : _titleController.text,
              recipients: ['iamyoer@gmail.com'],

              /// todo
              // attachmentPaths: ['/path/to/attachment.zip'],
              isHTML: false,
            );

            FlutterEmailSender.send(email).then((_) {
              showInfoToast(Translations.feedback.thankYou);
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: isValid ? Colors.green : Colors.grey,
            minimumSize: const Size(
              double.infinity,
              50,
            ),
          ),
          child: Text(
            Translations.feedback.button,
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
