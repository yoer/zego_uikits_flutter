part of 'default_dialogs.dart';

Future<dynamic> showDefaultGroupMemberListDialog(
  BuildContext context,
  String groupID,
) {
  final title = Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const SizedBox.shrink(),
      const SizedBox.shrink(),
      ValueListenableBuilder(
          valueListenable: ZIMKit().queryGroupMemberCount(groupID),
          builder: (BuildContext context, int groupMemberCount, Widget? _) {
            return Text(
              'Member List($groupMemberCount)',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            );
          }),
      IconButton(
        icon: const Icon(Icons.close),
        onPressed: () => Navigator.of(context).pop(),
      ),
    ],
  );

  Widget memberAvatar(
    ZIMGroupMemberInfo memberItem,
    String memberItemName,
  ) {
    return CachedNetworkImage(
      width: 60,
      height: 60,
      imageUrl: memberItem.memberAvatarUrl.isEmpty
          ? 'https://robohash.org/${memberItem.userID}.png?set=set4'
          : memberItem.memberAvatarUrl,
      fit: BoxFit.cover,
      progressIndicatorBuilder: (__, _, ___) => CircleAvatar(
        child: Text(memberItemName[0]),
      ),
    );
  }

  Widget memberInfo(
    ZIMGroupMemberInfo memberItem,
    String memberItemName,
  ) {
    final memberItemIsMe =
        memberItem.userID == ZIMKit().currentUser()!.baseInfo.userID;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Text(memberItemName, maxLines: 1, overflow: TextOverflow.clip),
            Text(memberItem.memberRole == ZIMGroupMemberRole.owner
                ? '(Owner)'
                : ''),
            Text(memberItem.memberRole == 2 ? '(Manager)' : ''),
            Text(memberItemIsMe ? '(Me)' : ''),
          ],
        ),
        Text('ID:${memberItem.userID}'),
      ],
    );
  }

  Widget memberMenu(
    ZIMGroupMemberInfo memberItem,
  ) {
    final memberItemIsMe =
        memberItem.userID == ZIMKit().currentUser()!.baseInfo.userID;

    return FutureBuilder(
      future: ZIMKit().queryGroupMemberInfo(
        groupID,
        ZIMKit().currentUser()?.baseInfo.userID ?? '',
      ),
      builder: (_, AsyncSnapshot<ZIMGroupMemberInfo?> snapshot) {
        final imGroupManager =
            snapshot.hasData && (snapshot.data?.memberRole == 2);

        return ValueListenableBuilder(
          valueListenable: ZIMKit().queryGroupOwner(groupID),
          builder: (context, ZIMGroupMemberInfo? owner, _) {
            if (memberItemIsMe) {
              return const SizedBox.shrink();
            }

            final imGroupOwner =
                owner?.userID == ZIMKit().currentUser()?.baseInfo.userID;
            return PopupMenuButton(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              position: PopupMenuPosition.under,
              icon: const Icon(Icons.more_horiz),
              itemBuilder: (context) {
                return [
                  if (imGroupOwner || imGroupManager) ...[
                    PopupMenuItem(
                      child: const ListTile(
                          leading: Icon(Icons.group_remove),
                          title: Text('Remove User')),
                      onTap: () => ZIMKit().removeUesrsFromGroup(
                        groupID,
                        [memberItem.userID],
                      ),
                    ),
                  ],
                  if (imGroupOwner) ...[
                    PopupMenuItem(
                      child: const ListTile(
                          leading: Icon(Icons.handshake),
                          title: Text('Transfer Group Owner')),
                      onTap: () => ZIMKit().transferGroupOwner(
                        groupID,
                        memberItem.userID,
                      ),
                    ),
                    PopupMenuItem(
                      child: ListTile(
                        leading: const Icon(Icons.diversity_3),
                        title: (memberItem.memberRole == 3)
                            ? const Text('Set Group Manager')
                            : const Text('Unset Group Manager'),
                      ),
                      onTap: () => ZIMKit().setGroupMemberRole(
                        conversationID: groupID,
                        userID: memberItem.userID,
                        role: (memberItem.memberRole == 3) ? 2 : 3,
                      ),
                    ),
                  ],
                  PopupMenuItem(
                    child: const ListTile(
                      leading: Icon(Icons.chat),
                      title: Text('Private Chat'),
                    ),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return DemoChattingMessageListPage(
                            conversationID: memberItem.userID,
                            conversationType: ZIMConversationType.peer,
                          );
                        }),
                      );
                    },
                  ),
                ];
              },
            );
          },
        );
      },
    );
  }

  final memberList = ValueListenableBuilder(
    valueListenable: ZIMKit().queryGroupMemberList(groupID),
    builder: (
      BuildContext context,
      List<ZIMGroupMemberInfo> memberList,
      Widget? child,
    ) {
      return Expanded(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: ListView.separated(
            separatorBuilder: (context, index) => const Divider(
              color: Colors.transparent,
            ),
            scrollDirection: Axis.vertical,
            itemCount: memberList.length,
            itemBuilder: (context, index) {
              final memberItem = memberList[index];
              final memberItemName = memberItem.memberNickname.isNotEmpty
                  ? memberItem.memberNickname
                  : memberItem.userName;

              return GestureDetector(
                onTap: () async {
                  debugPrint(
                    'click member: ${memberItem.userID}',
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      memberAvatar(memberItem, memberItemName),
                      const SizedBox(width: 10),
                      memberInfo(memberItem, memberItemName),
                    ]),
                    Row(children: [memberMenu(memberItem)]),
                  ],
                ),
              );
            },
          ),
        ),
      );
    },
  );

  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title,
            memberList,
          ],
        ),
      );
    },
  );
}
