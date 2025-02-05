// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

// Project imports:
import 'package:zego_uikits_demo/data/translations.dart';

class RoomList extends StatefulWidget {
  const RoomList({
    this.onClicked,
    this.onStart,
    this.onJoin,
    this.showStartButton = false,
    this.showJoinButton = false,
    required this.cover,
    required this.valueNotifier,
    super.key,
  });

  final Widget cover;
  final ValueNotifier<List<String>> valueNotifier;
  final void Function(String)? onClicked;

  final bool showStartButton;
  final bool showJoinButton;
  final void Function(String)? onStart;
  final void Function(String)? onJoin;

  @override
  State<RoomList> createState() {
    return _RoomListState();
  }
}

class _RoomListState extends State<RoomList> {
  final inRoomNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();

    onRoomStateUpdated();
    ZegoUIKit().getRoomStateStream().addListener(onRoomStateUpdated);
  }

  @override
  void dispose() {
    super.dispose();

    ZegoUIKit().getRoomStateStream().removeListener(onRoomStateUpdated);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<String>>(
      valueListenable: widget.valueNotifier,
      builder: (context, roomIDList, _) {
        final emptyTips = Text(
          'The room list is empty, please add the list manually in settings.',
          style: TextStyle(
            fontSize: 25.r,
          ),
          textAlign: TextAlign.start,
        );

        return LayoutBuilder(
          builder: (context, constraint) {
            return SizedBox(
              height: constraint.maxHeight,
              child: roomIDList.isEmpty
                  ? emptyTips
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                        crossAxisSpacing: 16.r,
                        mainAxisSpacing: 16.r,
                      ),
                      itemCount: roomIDList.length,
                      itemBuilder: (context, index) {
                        final roomID = roomIDList[index];
                        return GestureDetector(
                          onTap: () {
                            widget.onClicked?.call(roomID);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: widget.cover,
                                ),
                                Positioned.fill(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 20.r,
                                  right: 10.r,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20.r,
                                      vertical: 5.r,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                    child: Text(
                                      roomID,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25.r,
                                      ),
                                    ),
                                  ),
                                ),
                                foreground(roomID),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            );
          },
        );
      },
    );
  }

  Widget foreground(String roomID) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.showStartButton) startButton(roomID),
          SizedBox(width: 5.r),
          if (widget.showJoinButton) joinButton(roomID),
        ],
      ),
    );
  }

  Widget startButton(String roomID) {
    return ValueListenableBuilder<bool>(
      valueListenable: inRoomNotifier,
      builder: (context, isInRoom, _) {
        return ElevatedButton(
          onPressed: isInRoom
              ? null
              : () {
                  widget.onStart?.call(roomID);
                },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
            padding: EdgeInsets.symmetric(
              vertical: 20.r,
              horizontal: 20.r,
            ),
          ),
          child: Text(
            Translations.tips.start,
            style: TextStyle(color: Colors.white, fontSize: 20.r),
          ),
        );
      },
    );
  }

  Widget joinButton(String roomID) {
    return ValueListenableBuilder<bool>(
      valueListenable: inRoomNotifier,
      builder: (context, isInRoom, _) {
        return ElevatedButton(
          onPressed: isInRoom
              ? null
              : () {
                  widget.onJoin?.call(roomID);
                },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
            padding: EdgeInsets.symmetric(
              vertical: 20.r,
              horizontal: 20.r,
            ), // 设置高度和宽度
          ),
          child: Text(
            Translations.tips.join,
            style: TextStyle(color: Colors.white, fontSize: 20.r),
          ),
        );
      },
    );
  }

  void onRoomStateUpdated() {
    final value = ZegoUIKit().getRoomStateStream().value;
    inRoomNotifier.value = ZegoRoomStateChangedReason.Logined == value.reason ||
        ZegoRoomStateChangedReason.Logining == value.reason;
  }
}
