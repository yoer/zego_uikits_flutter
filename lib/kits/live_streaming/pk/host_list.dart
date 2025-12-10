// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

// Project imports:
import 'package:zego_uikits_demo/common/toast.dart';
import 'package:zego_uikits_demo/firestore/defines.dart';
import 'package:zego_uikits_demo/kits/live_streaming/cache.dart';
import '../../../common/avatar.dart';
import '../../../data/assets.dart';
import '../../../data/translations.dart';
import '../../../data/user.dart';
import '../../../firestore/kits_service.dart';
import '../../../firestore/user_doc.dart';

class LiveStreamingPKHostList extends StatefulWidget {
  const LiveStreamingPKHostList({
    super.key,
    required this.stateNotifier,
  });

  final ValueNotifier<ZegoLiveStreamingState> stateNotifier;

  @override
  State<StatefulWidget> createState() {
    return _LiveStreamingPKForegroundState();
  }
}

class _LiveStreamingPKForegroundState extends State<LiveStreamingPKHostList> {
  bool autoAccept = false;
  final TextEditingController _hostIdController = TextEditingController();

  @override
  void initState() {
    super.initState();

    autoAccept = LiveStreamingCache().pkAutoAccept;
  }

  @override
  void dispose() {
    _hostIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.r,
        vertical: 20.r,
      ),
      child: ValueListenableBuilder<Map<String, UserDoc>>(
        valueListenable: KitsFirebaseService().userTable.cacheNotifier,
        builder: (context, userDocsMap, _) {
          final currentLoginUser = UserService().loginUserNotifier.value;

          var userDocs = KitsFirebaseService().queryRoomActiveUsersWithType(
            roomType: RoomType.liveStreamingPK,
            isHost: true,
          );
          userDocs.removeWhere((e) => e.id == currentLoginUser?.id);
          userDocs.sort((left, right) => left.id.compareTo(right.id));

          return userDocs.isEmpty
              ? noFirebaseHostList()
              : firebaseHostList(userDocs);
        },
      ),
    );
  }

  Widget firebaseHostList(List<UserDoc> userDocs) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return Column(
          children: [
            SizedBox(
              height: 50.r,
              child: controls(),
            ),
            SizedBox(
              height: 5.r,
            ),
            SizedBox(
              height: constraint.maxHeight - 50.r - 5.r,
              child: ListView.builder(
                itemCount: userDocs.length,
                itemBuilder: (context, index) {
                  final userDoc = userDocs[index];
                  return hostItem(userDoc, index);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget controls() {
    final currentLoginUser = UserService().loginUserNotifier.value;

    return ValueListenableBuilder(
      valueListenable: widget.stateNotifier,
      builder: (context, state, _) {
        return state == ZegoLiveStreamingState.inPKBattle
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (currentLoginUser?.id ==
                      ZegoUIKitPrebuiltLiveStreamingController()
                          .pk
                          .currentInitiatorID)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red,
                      ),
                      child: Text(Translations.liveStreaming.endPK),
                      onPressed: () {
                        ZegoUIKitPrebuiltLiveStreamingController().pk.stop();
                      },
                    ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                    ),
                    child: Text(Translations.liveStreaming.quitPK),
                    onPressed: () {
                      ZegoUIKitPrebuiltLiveStreamingController().pk.quit();
                    },
                  ),
                ],
              )
            : const SizedBox();
      },
    );
  }

  /// 当firebase失效无法拉取用户列表
  Widget noFirebaseHostList() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _noFirebaseEmptyTips(),
          SizedBox(height: 40.r),
          _manualInputSection(),
          SizedBox(height: 20.r),
          _sendInviteButton(),
          SizedBox(height: 60.r),
          _noFirebasePKControlButtons(),
        ],
      ),
    );
  }

  Widget _noFirebaseEmptyTips() {
    return Text(
      Translations.liveStreaming.pkHostEmptyTips,
      style: TextStyle(
        color: Colors.black,
        fontSize: 30.r,
      ),
    );
  }

  Widget _manualInputSection() {
    return Column(
      children: [
        Text(
          Translations.liveStreaming.manualInputTips,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 24.r,
          ),
        ),
        SizedBox(height: 20.r),
        SizedBox(
          width: 400.r,
          child: TextField(
            controller: _hostIdController,
            decoration: InputDecoration(
              hintText: Translations.liveStreaming.hostIdPlaceholder,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.r,
                vertical: 12.r,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _sendInviteButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.red,
        padding: EdgeInsets.symmetric(
          horizontal: 32.r,
          vertical: 16.r,
        ),
      ),
      child: Text(
        Translations.liveStreaming.sendInvite,
        style: TextStyle(fontSize: 24.r),
      ),
      onPressed: () {
        final hostId = _hostIdController.text.trim();
        if (hostId.isEmpty) {
          showFailedToast(Translations.liveStreaming.pleaseEnterHostId);
          return;
        }

        ZegoUIKitPrebuiltLiveStreamingController().pk.sendRequest(
          targetHostIDs: [hostId],
          isAutoAccept: autoAccept,
        ).then(
          (result) {
            if (!mounted) return;

            if (result.error != null) {
              showFailedToast(
                '${Translations.liveStreaming.invitePK}:${result.error.toString()}',
              );
            } else {
              _hostIdController.clear();
              showInfoToast(Translations.liveStreaming.inviteSent);
              Navigator.pop(context);
            }
          },
        );
      },
    );
  }

  Widget _noFirebasePKControlButtons() {
    return ValueListenableBuilder(
      valueListenable: widget.stateNotifier,
      builder: (context, state, _) {
        if (state != ZegoLiveStreamingState.inPKBattle) {
          return const SizedBox();
        }

        final currentLoginUser = UserService().loginUserNotifier.value;
        final isInitiator = currentLoginUser?.id ==
            ZegoUIKitPrebuiltLiveStreamingController().pk.currentInitiatorID;

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isInitiator) _stopPKButton(),
            if (isInitiator) SizedBox(width: 20.r),
            _quitPKButton(),
          ],
        );
      },
    );
  }

  Widget _stopPKButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.red,
        padding: EdgeInsets.symmetric(
          horizontal: 32.r,
          vertical: 16.r,
        ),
      ),
      child: Text(
        Translations.liveStreaming.endPK,
        style: TextStyle(fontSize: 24.r),
      ),
      onPressed: () {
        ZegoUIKitPrebuiltLiveStreamingController().pk.stop();
      },
    );
  }

  Widget _quitPKButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        padding: EdgeInsets.symmetric(
          horizontal: 32.r,
          vertical: 16.r,
        ),
      ),
      child: Text(
        Translations.liveStreaming.quitPK,
        style: TextStyle(fontSize: 24.r),
      ),
      onPressed: () {
        ZegoUIKitPrebuiltLiveStreamingController().pk.quit();
      },
    );
  }

  Widget hostItem(
    UserDoc userDoc,
    int index,
  ) {
    final iconSize = 100.r;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.r),
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
          muteButton(userDoc.id),
          SizedBox(width: 5.r),
          pkWidget(userDoc),
        ],
      ),
    );
  }

  Widget muteButton(String hostID) {
    final currentLoginUser = UserService().loginUserNotifier.value;

    return currentLoginUser?.id == hostID
        ? const SizedBox()
        : ValueListenableBuilder(
            valueListenable: widget.stateNotifier,
            builder: (context, state, _) {
              return ValueListenableBuilder<List<String>>(
                valueListenable: ZegoUIKitPrebuiltLiveStreamingController()
                    .pk
                    .mutedUsersNotifier,
                builder: (context, muteUsers, _) {
                  return state == ZegoLiveStreamingState.inPKBattle
                      ? GestureDetector(
                          onTap: () {
                            ZegoUIKitPrebuiltLiveStreamingController()
                                .pk
                                .muteAudios(
                              targetHostIDs: [hostID],
                              isMute: !muteUsers.contains(hostID),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(20.r),
                            child: Icon(
                              muteUsers.contains(hostID)
                                  ? Icons.volume_off
                                  : Icons.volume_up,
                              color: Colors.black,
                            ),
                          ),
                        )
                      : const SizedBox();
                },
              );
            },
          );
  }

  Widget pkWidget(
    UserDoc userDoc,
  ) {
    return userDoc.pkState == LiveStreamingPKState.idle
        ? ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.red,
            ),
            child: Text(Translations.liveStreaming.invitePK),
            onPressed: () {
              ZegoUIKitPrebuiltLiveStreamingController().pk.sendRequest(
                targetHostIDs: [userDoc.id],
                isAutoAccept: autoAccept,
              ).then(
                (result) {
                  if (result.error != null) {
                    showFailedToast(
                      '${Translations.liveStreaming.invitePK}:${result.error.toString()}',
                    );
                  }
                },
              );
            },
          )
        : Stack(
            children: [
              Image.asset(
                userDoc.pkState == LiveStreamingPKState.waiting
                    ? MyIcons.waiting
                    : MyIcons.inPK,
                width: 66.r,
                height: 66.r,
                // color: Colors.white,
              ),
              CircularProgressIndicator(
                color: userDoc.pkState == LiveStreamingPKState.waiting
                    ? Colors.yellow
                    : Colors.red,
              ),
            ],
          );
  }
}
