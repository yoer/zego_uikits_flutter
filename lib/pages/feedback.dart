// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:archive/archive.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

// Project imports:
import 'package:zego_uikits_demo/common/toast.dart';
import 'package:zego_uikits_demo/data/translations.dart';

class FeedbacksPage extends StatefulWidget {
  const FeedbacksPage({super.key});

  @override
  State<FeedbacksPage> createState() => _FeedbacksPageState();
}

class _FeedbacksPageState extends State<FeedbacksPage> {
  final buttonValidNotifier = ValueNotifier<bool>(false);

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  bool _addLogs = true;
  bool _isLoading = false;
  bool _useEmailMode = false; // false = 分享模式（默认），true = 邮箱模式

  Future<List<String>> _getLogsZipPaths() async {
    if (!_addLogs) return [];

    try {
      final tempDir = await getTemporaryDirectory();
      final List<String> zipPaths = [];
      var currentArchive = Archive();
      var currentSize = 0;
      const maxArchiveSize = 20 * 1024 * 1024; // 20MB

      Future<void> saveCurrentArchive() async {
        if (currentArchive.isNotEmpty) {
          debugPrint(
              'feedback: Creating zip file ${zipPaths.length + 1} with ${currentArchive.length} files, total size: ${currentSize ~/ 1024}KB');
          final encoder = ZipEncoder();
          final zipData = encoder.encode(currentArchive);
          if (zipData != null) {
            final zipPath =
                '${tempDir.path}/logs_${DateTime.now().millisecondsSinceEpoch}_${zipPaths.length}.zip';
            final file = File(zipPath);
            await file.writeAsBytes(zipData);
            final zipSize = await file.length();
            debugPrint(
                'Created zip file: $zipPath (${zipSize ~/ 1024}KB, compression ratio: ${(currentSize / zipSize).toStringAsFixed(2)}x)');

            // 如果压缩后仍然超过20MB，尝试重新压缩
            if (zipSize > maxArchiveSize) {
              debugPrint(
                  'Zip file too large (${zipSize ~/ 1024}KB), trying to split...');
              await file.delete();

              // 计算需要分成多少份
              final numParts = (zipSize / maxArchiveSize).ceil();
              final partSize = (zipData.length / numParts).ceil();
              debugPrint(
                  'Splitting into $numParts parts, each part size: ${partSize ~/ 1024}KB');

              for (var i = 0; i < numParts; i++) {
                final start = i * partSize;
                final end = (start + partSize > zipData.length)
                    ? zipData.length
                    : start + partSize;
                final partData = zipData.sublist(start, end);

                final partPath =
                    '${tempDir.path}/logs_${DateTime.now().millisecondsSinceEpoch}_part$i.zip';
                final partFile = File(partPath);
                await partFile.writeAsBytes(partData);
                zipPaths.add(partPath);
                debugPrint(
                    'Created part $i: $partPath (${partData.length ~/ 1024}KB)');
              }

              return;
            }

            zipPaths.add(zipPath);
          }
          currentArchive = Archive();
          currentSize = 0;
        }
      }

      Future<void> addFileToArchive(File file, String archivePath) async {
        try {
          final fileSize = await file.length();
          final bytes = await file.readAsBytes();
          currentArchive.addFile(ArchiveFile(archivePath, bytes.length, bytes));
          currentSize += fileSize;
          debugPrint(
              'feedback: Added file to archive: $archivePath (${fileSize ~/ 1024}KB)');
        } catch (e) {
          debugPrint('feedback: Error processing file ${file.path}: $e');
        }
      }

      if (Platform.isAndroid) {
        debugPrint('feedback: Processing Android logs...');
        final appDir = await getExternalStorageDirectory();
        debugPrint('feedback: appDir = \'${appDir?.path}\'');
        if (appDir != null) {
          final filesDir = Directory(appDir.path);
          debugPrint(
              'feedback: filesDir = \'${filesDir.path}\' exists: ${await filesDir.exists()}');
          if (await filesDir.exists()) {
            int totalFiles = 0;
            int matchedFiles = 0;
            await for (final entity in filesDir.list(recursive: true)) {
              debugPrint('feedback: 遍历到: ${entity.path}');
              final name = entity.uri.pathSegments.last;
              final relativePath = p.relative(entity.path, from: filesDir.path);
              if (entity is File) {
                totalFiles++;

                // 1. 文件打包
                if (name.endsWith('.txt') || name.endsWith('.zip')) {
                  debugPrint('feedback: 匹配到 zego.*.txt/zip 文件: $relativePath');
                  matchedFiles++;
                  await addFileToArchive(entity, 'android_files/$relativePath');
                }
                // 2. 只要在 zego_prebuilt、ZIMAudioLog、ZIMLogs 这3个文件夹下的任何文件都要打包
                else if (relativePath.startsWith('ZegoUIKits/') ||
                    relativePath.startsWith('ZIMAudioLog/') ||
                    relativePath.startsWith('ZIMLogs/')) {
                  debugPrint('feedback: 匹配到指定文件夹内容: $relativePath');
                  matchedFiles++;
                  await addFileToArchive(entity, 'android_files/$relativePath');
                }
              } else if (entity is Directory) {
                debugPrint('feedback: 遍历到文件夹: $relativePath');
              }
            }
            debugPrint('feedback: 遍历总文件数: $totalFiles, 匹配打包文件数: $matchedFiles');
          } else {
            debugPrint('feedback: filesDir 不存在!');
          }
        } else {
          debugPrint('feedback: appDir 为空!');
        }
      } else if (Platform.isIOS) {
        debugPrint('feedback: Processing iOS logs...');
        final appSupportDir = await getApplicationSupportDirectory();
        final logsDir = Directory('${appSupportDir.path}/Logs');
        if (await logsDir.exists()) {
          debugPrint('feedback: Processing iOS Logs directory...');
          await for (final entity in logsDir.list(recursive: true)) {
            if (entity is File) {
              final relativePath =
                  entity.path.substring(logsDir.path.length + 1);
              final archivePath = 'ios_logs/$relativePath';
              await addFileToArchive(entity, archivePath);
            }
          }
        }

        final cachesDir = await getTemporaryDirectory();
        final parentDir = cachesDir.parent;
        final List<Directory> cacheDirs = [
          Directory('${parentDir.path}/Caches/ZIMAudioLog'),
          Directory('${parentDir.path}/Caches/ZIMCaches'),
          Directory('${parentDir.path}/Caches/ZIMLogs'),
          Directory('${parentDir.path}/Caches/ZefLogs'),
          Directory('${parentDir.path}/Caches/ZegoLogs'),
        ];

        for (final dir in cacheDirs) {
          if (await dir.exists()) {
            final dirName = dir.path.split('/').last;
            debugPrint('feedback: Processing iOS Caches directory: $dirName');
            await for (final entity in dir.list(recursive: true)) {
              if (entity is File) {
                final name = entity.uri.pathSegments.last;
                if (name.endsWith('.txt') || name.endsWith('.zip')) {
                  final relativePath =
                      entity.path.substring(dir.path.length + 1);
                  final archivePath = 'ios_caches/$dirName/$relativePath';
                  await addFileToArchive(entity, archivePath);
                }
              }
            }
          }
        }
      }

      // Save the last archive if it has any files
      await saveCurrentArchive();
      debugPrint('feedback: Created ${zipPaths.length} zip files in total');
      return zipPaths;
    } catch (e) {
      debugPrint('feedback: Error creating logs zips: $e');
      return [];
    }
  }

  Future<void> _shareWithLogs(List<String> zipPaths) async {
    if (zipPaths.isEmpty) {
      debugPrint('feedback: No logs to share');
      showInfoToast('No logs to share');
      return;
    }

    debugPrint('feedback: Starting to share ${zipPaths.length} files...');

    try {
      if (zipPaths.length == 1) {
        // 单个文件直接分享
        await Share.shareXFiles(
          [XFile(zipPaths[0])],
          text:
              '${_titleController.text.isEmpty ? Translations.feedback.feedbackDefault : _titleController.text}\n\n${_contentController.text}',
          subject: _titleController.text.isEmpty
              ? Translations.feedback.feedbackDefault
              : _titleController.text,
        );
      } else {
        // 多个文件，先创建一个包含所有文件的临时目录
        final tempDir = await getTemporaryDirectory();
        final shareDir = Directory(
            '${tempDir.path}/feedback_logs_${DateTime.now().millisecondsSinceEpoch}');
        await shareDir.create();

        // 复制所有zip文件到分享目录
        for (var i = 0; i < zipPaths.length; i++) {
          final sourceFile = File(zipPaths[i]);
          final targetFile = File('${shareDir.path}/logs_part_${i + 1}.zip');
          await sourceFile.copy(targetFile.path);
        }

        // 创建反馈内容文件
        final feedbackFile = File('${shareDir.path}/feedback.txt');
        await feedbackFile.writeAsString(
            '${_titleController.text.isEmpty ? Translations.feedback.feedbackDefault : _titleController.text}\n\n${_contentController.text}');

        // 分享整个目录（iOS会显示为文件夹）
        await Share.shareXFiles(
          [XFile(shareDir.path)],
          text: Translations.feedback.logsWithParts(zipPaths.length),
        );
      }

      showInfoToast(Translations.feedback.thankYou);
    } catch (e) {
      debugPrint('feedback: Error sharing files: $e');
      showInfoToast('${Translations.feedback.shareFailed}: $e');
    }
  }

  Future<void> _sendEmailsWithLogs(List<String> zipPaths) async {
    if (zipPaths.isEmpty) {
      debugPrint('feedback: No logs to send');
      showInfoToast('No logs to send');
      return;
    }

    debugPrint(
        'feedback: Starting to send ${zipPaths.length} emails with logs...');
    for (var i = 0; i < zipPaths.length; i++) {
      debugPrint(
          'feedback: Sending email part ${i + 1} of ${zipPaths.length}...');
      final Email email = Email(
        body:
            '${_contentController.text}\n\nLogs part ${i + 1} of ${zipPaths.length}',
        subject:
            '${_titleController.text.isEmpty ? "Empty" : _titleController.text} (Part ${i + 1}/${zipPaths.length})',
        recipients: ['ejunyue@163.com'],
        attachmentPaths: [zipPaths[i]],
        isHTML: false,
      );

      try {
        await FlutterEmailSender.send(email);
        debugPrint('feedback: Successfully sent email part ${i + 1}');
        if (i == zipPaths.length - 1) {
          showInfoToast(Translations.feedback.thankYou);
        }
      } catch (e) {
        debugPrint('feedback: Error sending email part ${i + 1}: $e');
        showInfoToast('Failed to send email part ${i + 1}: $e');
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(fontSize: 18.r, color: Colors.black);

    return Stack(
      children: [
        Scaffold(
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
                  // 发送模式选择
                  Container(
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Translations.feedback.sendMethod,
                          style: TextStyle(
                            fontSize: 16.r,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 10.r),
                        Row(
                          children: [
                            Expanded(
                              child: RadioListTile<bool>(
                                title: Text(
                                  Translations.feedback.systemShare,
                                  style: TextStyle(fontSize: 14.r),
                                ),
                                subtitle: Text(
                                  Translations.feedback.systemShareDesc,
                                  style: TextStyle(
                                      fontSize: 12.r, color: Colors.grey),
                                ),
                                value: false,
                                groupValue: _useEmailMode,
                                onChanged: (value) {
                                  setState(() {
                                    _useEmailMode = value!;
                                  });
                                },
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: RadioListTile<bool>(
                                title: Text(
                                  Translations.feedback.emailSend,
                                  style: TextStyle(fontSize: 14.r),
                                ),
                                subtitle: Text(
                                  Translations.feedback.emailSendDesc,
                                  style: TextStyle(
                                      fontSize: 12.r, color: Colors.grey),
                                ),
                                value: true,
                                groupValue: _useEmailMode,
                                onChanged: (value) {
                                  setState(() {
                                    _useEmailMode = value!;
                                  });
                                },
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
        ),
        if (_isLoading)
          Container(
            color: Colors.black.withValues(alpha: 0.3),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }

  Widget button() {
    return ValueListenableBuilder(
      valueListenable: buttonValidNotifier,
      builder: (context, isValid, _) {
        return ElevatedButton(
          onPressed: () async {
            // 先收起键盘
            FocusScope.of(context).unfocus();
            setState(() {
              _isLoading = true;
            });
            try {
              if (!_addLogs) {
                // 用户没有选择添加日志
                if (_useEmailMode) {
                  // 邮箱模式：发送单封邮件
                  final Email email = Email(
                    body: _contentController.text,
                    subject: _titleController.text.isEmpty
                        ? 'Empty'
                        : _titleController.text,
                    recipients: ['ejunyue@163.com'],
                    isHTML: false,
                  );
                  try {
                    await FlutterEmailSender.send(email);
                    showInfoToast(Translations.feedback.thankYou);
                  } catch (e) {
                    debugPrint('feedback: Error sending email: $e');
                    showInfoToast('Failed to send email: $e');
                  }
                } else {
                  // 分享模式：分享文本内容
                  await Share.share(
                    '${_titleController.text.isEmpty ? Translations.feedback.feedbackDefault : _titleController.text}\n\n${_contentController.text}',
                    subject: _titleController.text.isEmpty
                        ? Translations.feedback.feedbackDefault
                        : _titleController.text,
                  );
                  showInfoToast(Translations.feedback.thankYou);
                }
              } else {
                // 用户选择了添加日志
                List<String> zipPaths = await _getLogsZipPaths();
                if (zipPaths.isNotEmpty) {
                  if (_useEmailMode) {
                    // 邮箱模式：发送带日志的邮件
                    await _sendEmailsWithLogs(zipPaths);
                  } else {
                    // 分享模式：分享日志文件
                    await _shareWithLogs(zipPaths);
                  }
                } else {
                  showInfoToast('No logs found');
                }
                // 清理zip文件
                for (final zipPath in zipPaths) {
                  final file = File(zipPath);
                  if (await file.exists()) {
                    await file.delete();
                  }
                }
              }
            } finally {
              setState(() {
                _isLoading = false;
              });
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
            _useEmailMode
                ? Translations.feedback.sendEmail
                : Translations.feedback.shareFeedback,
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
