// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

// Project imports:
import 'package:zego_uikits_demo/common/avatar.dart';
import 'package:zego_uikits_demo/kits/call/cache.dart';

class CallInvitationHistory extends StatefulWidget {
  const CallInvitationHistory({super.key});

  @override
  State<CallInvitationHistory> createState() {
    return _CallInvitationHistoryState();
  }
}

class _CallInvitationHistoryState extends State<CallInvitationHistory>
    with SingleTickerProviderStateMixin {
  late final controller = SlidableController(this);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return ValueListenableBuilder<List<CallRecord>>(
          valueListenable: CallCache().invitation.historyNotifier,
          builder: (context, history, _) {
            return ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, index) {
                final reversedIndex = history.length - 1 - index;

                final record = history[reversedIndex];
                return Slidable(
                  key: ValueKey(record.callID),
                  startActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          CallCache().invitation.removeHistory(record.callID);
                        },
                        backgroundColor: const Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),
                  child: recordItem(record, constraint, index),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget recordItem(
    CallRecord record,
    BoxConstraints constraint,
    int index,
  ) {
    final subtitleStyle = TextStyle(
      color: Colors.grey,
      fontSize: 20.r,
    );

    String title = '';
    ZegoCallUser? caller;
    if (record.isGroup) {
      title = record.users
          .map((caller) => (caller.name.isEmpty) ? caller.id : caller.name)
          .toList()
          .join(',');
    } else {
      caller = record.users.isEmpty ? null : record.users.first;
      title =
          (caller?.name.isEmpty ?? true) ? '${caller?.id}' : '${caller?.name}';
    }

    final rowHeight = 150.r;
    final iconSize = 50.r;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: iconSize,
          height: rowHeight,
          child: record.isCaller
              ? const SizedBox()
              : Icon(
                  Icons.phone_callback,
                  color: Colors.grey,
                  size: iconSize,
                ),
        ),
        GestureDetector(
          // onLongPress: () {
          //   RenderBox renderBox = context.findRenderObject() as RenderBox;
          //   Offset offset = renderBox.localToGlobal(Offset.zero);
          //   double dx = offset.dx;
          //   double dy = offset.dy + (index) * rowHeight;
          //
          //   showListMenu(
          //     context,
          //     record,
          //     dx,
          //     dy,
          //   );
          // },
          child: SizedBox(
            width: constraint.maxWidth - iconSize,
            height: rowHeight,
            child: ListTile(
              title: Row(
                children: [
                  SizedBox(
                    width: iconSize,
                    height: iconSize,
                    child: record.isGroup
                        ? Icon(
                            Icons.group,
                            color: Colors.blue,
                            size: 45.r,
                          )
                        : CircleAvatar(
                            child: avatar(caller?.id ?? ''),
                          ),
                  ),
                  SizedBox(width: 5.r),
                  Text(
                    title,
                    style: TextStyle(
                      color: record.isMissed ? Colors.red : Colors.black,
                      fontSize: 30.r,
                    ),
                  )
                ],
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    record.formatDateTime(),
                    style: subtitleStyle,
                  ),
                  Text(
                    record.formatDuration(),
                    style: subtitleStyle,
                  ),
                ],
              ),
              onTap: () {
                if (record.users.isEmpty) {
                  return;
                }

                ZegoUIKitPrebuiltCallInvitationService().send(
                  invitees: record.users,
                  isVideoCall: record.isVideo,
                  resourceID: CallCache().invitation.resourceID,
                  timeoutSeconds: CallCache().invitation.timeoutSecond,
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  void showListMenu(
    BuildContext context,
    CallRecord record,
    double dx,
    double dy,
  ) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        dx,
        dy,
        100.r,
        100.r,
      ),
      items: [
        const PopupMenuItem(
          value: 'delete',
          child: Text('Delete'),
        ),
      ],
    ).then((value) {
      if (value == 'delete') {
        CallCache().invitation.removeHistory(record.callID);
      }
    });
  }
}

class CallRecord {
  String callID;
  List<ZegoCallUser> users;
  DateTime respondTime;
  Duration duration;
  bool isMissed;
  bool isGroup;
  bool isVideo;
  bool isCaller;

  CallRecord({
    required this.callID,
    required this.users,
    required this.respondTime,
    required this.duration,
    required this.isMissed,
    required this.isCaller,
    required this.isVideo,
    this.isGroup = false,
  });

  void hangup(bool fromCall) {
    duration = DateTime.now().difference(respondTime);
    isMissed = !fromCall;

    CallCache().invitation.updateHistory(forceUpdate: true);
  }

  factory CallRecord.fromJson(String json) {
    final jsonMap = jsonDecode(json) as Map<String, dynamic>;

    return CallRecord(
      callID: jsonMap['call_id'] as String? ?? '',
      users: (jsonMap['users'] as List<dynamic>).map((userJson) {
        final userMap = userJson as Map<String, dynamic>;
        return ZegoCallUser(
          userMap['id'] as String? ?? '',
          userMap['name'] as String? ?? '',
        );
      }).toList(),
      respondTime: DateTime.fromMillisecondsSinceEpoch(
          jsonMap['respond_time'] as int? ?? 0),
      duration: Duration(seconds: jsonMap['duration'] as int? ?? 0),
      isMissed: jsonMap['is_group'] as bool? ?? false,
      isGroup: jsonMap['is_group'] as bool? ?? false,
      isCaller: jsonMap['is_caller'] as bool? ?? false,
      isVideo: jsonMap['is_video'] as bool? ?? false,
    );
  }

  String toJson() {
    return const JsonEncoder().convert({
      'call_id': callID,
      'users': users.map((u) => {'id': u.id, 'name': u.name}).toList(),
      'respond_time': respondTime.millisecondsSinceEpoch,
      'duration': duration.inSeconds,
      'is_missed': isMissed,
      'is_group': isGroup,
      'is_caller': isCaller,
      'is_video': isVideo,
    });
  }

  String formatDateTime() {
    final formater = DateFormat('MM-dd hh:mm');
    return formater.format(respondTime);
  }

  String formatDuration() {
    String negativeSign = duration.isNegative ? '-' : '';
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60).abs());
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60).abs());
    return "$negativeSign${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
