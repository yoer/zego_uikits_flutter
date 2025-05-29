// Flutter imports:
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:archive/archive.dart';
import 'package:url_launcher/url_launcher.dart';

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
  String? _logZipPath;

  Future<String?> _getLogsZipPath() async {
    if (!_addLogs) return null;

    try {
      final tempDir = await getTemporaryDirectory();
      final zipPath =
          '${tempDir.path}/logs_${DateTime.now().millisecondsSinceEpoch}.zip';
      final encoder = ZipEncoder();
      final archive = Archive();

      if (Platform.isAndroid) {
        // Android logs path
        final appDir = await getExternalStorageDirectory();
        if (appDir != null) {
          final parentDir = appDir.parent;
          if (await parentDir.exists()) {
            await _addDirectoryToArchive(parentDir, archive, 'android_logs');
          }
        }
      } else if (Platform.isIOS) {
        // iOS logs paths
        final appSupportDir = await getApplicationSupportDirectory();
        final logsDir = Directory('${appSupportDir.path}/Logs');
        if (await logsDir.exists()) {
          await _addDirectoryToArchive(logsDir, archive, 'ios_logs');
        }

        final cachesDir = await getTemporaryDirectory();
        final parentDir = cachesDir.parent;
        final zimAudioLogDir =
            Directory('${parentDir.path}/Caches/ZIMAudioLog');
        final zimCachesDir = Directory('${parentDir.path}/Caches/ZIMCaches');
        final zimLogsDir = Directory('${parentDir.path}/Caches/ZIMLogs');
        final zefLogsDir = Directory('${parentDir.path}/Caches/ZefLogs');
        final zegoLogsDir = Directory('${parentDir.path}/Caches/ZegoLogs');

        if (await zimAudioLogDir.exists()) {
          await _addDirectoryToArchive(
              zimAudioLogDir, archive, 'ios_caches/ZIMAudioLog');
        }
        if (await zimCachesDir.exists()) {
          await _addDirectoryToArchive(
              zimCachesDir, archive, 'ios_caches/ZIMCaches');
        }
        if (await zimLogsDir.exists()) {
          await _addDirectoryToArchive(
              zimLogsDir, archive, 'ios_caches/ZIMLogs');
        }
        if (await zefLogsDir.exists()) {
          await _addDirectoryToArchive(
              zefLogsDir, archive, 'ios_caches/ZefLogs');
        }
        if (await zegoLogsDir.exists()) {
          await _addDirectoryToArchive(
              zegoLogsDir, archive, 'ios_caches/ZegoLogs');
        }
      }

      final zipData = encoder.encode(archive);
      if (zipData != null) {
        final file = File(zipPath);
        await file.writeAsBytes(zipData);
        return zipPath;
      }
    } catch (e) {
      debugPrint('Error creating logs zip: $e');
    }
    return null;
  }

  Future<void> _addDirectoryToArchive(
      Directory dir, Archive archive, String baseArchivePath) async {
    await for (final entity in dir.list(recursive: true)) {
      if (entity is File) {
        final relativePath = entity.path.substring(dir.path.length + 1);
        final fileArchivePath = '$baseArchivePath/$relativePath';
        final bytes = await entity.readAsBytes();
        archive.addFile(ArchiveFile(fileArchivePath, bytes.length, bytes));
      }
    }
  }

  Future<bool> _isEmailAvailable() async {
    try {
      final Email email = Email(
        body: 'Test',
        subject: 'Test',
        recipients: ['test@example.com'],
        isHTML: false,
      );
      await FlutterEmailSender.send(email);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> _showNoEmailClientDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('No Email Client'),
          content: const Text(
              'No email client found. Would you like to install Gmail?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Install'),
              onPressed: () async {
                Navigator.of(context).pop();
                final Uri url =
                    Uri.parse('market://details?id=com.google.android.gm');
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                } else {
                  showInfoToast('Could not open Play Store');
                }
              },
            ),
          ],
        );
      },
    );
  }

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
          onPressed: () async {
            if (!await _isEmailAvailable()) {
              await _showNoEmailClientDialog();
              return;
            }

            if (_addLogs) {
              _logZipPath = await _getLogsZipPath();
            }

            final Email email = Email(
              body: _contentController.text,
              subject: _titleController.text.isEmpty
                  ? 'Empty'
                  : _titleController.text,
              recipients: ['iamyoer@gmail.com'],
              attachmentPaths: _logZipPath != null ? [_logZipPath!] : [],
              isHTML: false,
            );

            try {
              await FlutterEmailSender.send(email);
              showInfoToast(Translations.feedback.thankYou);

              // Clean up zip file
              if (_logZipPath != null) {
                final file = File(_logZipPath!);
                if (await file.exists()) {
                  await file.delete();
                }
              }
            } catch (e) {
              debugPrint('Error sending email: $e');
              showInfoToast('Failed to send email: $e');
            }
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
