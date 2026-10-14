import 'package:flutter_test/flutter_test.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_zim/zego_zim.dart';
import 'package:zego_uikits_demo/kits/chat/chatting_page_mixins.dart';

void main() {
  test('keeps selected group call invitees within the call limit', () {
    final invitees = [
      ZegoCallUser('alice', 'Alice'),
      ZegoCallUser('bob', 'Bob'),
      ZegoCallUser('carol', 'Carol'),
    ];

    final selected = selectGroupCallInvitees(
      availableInvitees: invitees,
      selectedUserIDs: {'carol', 'alice'},
    );

    expect(selected.map((user) => user.id), ['alice', 'carol']);
  });

  test('rejects a selection larger than the CallInvite limit', () {
    final invitees = List.generate(
      maxGroupCallInviteeCount + 1,
      (index) => ZegoCallUser('user-$index', 'User $index'),
    );

    expect(
      () => selectGroupCallInvitees(
        availableInvitees: invitees,
        selectedUserIDs: invitees.map((user) => user.id).toSet(),
      ),
      throwsArgumentError,
    );
  });

  test('allows selecting the maximum number of CallInvite members', () {
    final invitees = List.generate(
      maxGroupCallInviteeCount,
      (index) => ZegoCallUser('user-$index', 'User $index'),
    );

    final selected = selectGroupCallInvitees(
      availableInvitees: invitees,
      selectedUserIDs: invitees.map((user) => user.id).toSet(),
    );

    expect(selected, hasLength(maxGroupCallInviteeCount));
  });

  test('loads every group member page and excludes the current user', () async {
    final queriedFlags = <int>[];

    final invitees = await queryGroupCallInvitees(
      groupID: 'group-1',
      currentUserID: 'caller',
      queryPage: (groupID, config) async {
        expect(groupID, 'group-1');
        queriedFlags.add(config.nextFlag);

        if (config.nextFlag == 0) {
          return ZIMGroupMemberListQueriedResult(
            groupID: groupID,
            userList: [
              ZIMGroupMemberInfo(userID: 'caller', userName: 'Caller'),
              ZIMGroupMemberInfo(
                userID: 'alice',
                userName: 'Alice',
                memberNickname: 'Alice in group',
              ),
            ],
            nextFlag: 17,
          );
        }

        return ZIMGroupMemberListQueriedResult(
          groupID: groupID,
          userList: [ZIMGroupMemberInfo(userID: 'bob', userName: 'Bob')],
          nextFlag: 0,
        );
      },
    );

    expect(queriedFlags, [0, 17]);
    expect(
      invitees.map((user) => (user.id, user.name)).toList(),
      [('alice', 'Alice in group'), ('bob', 'Bob')],
    );
  });

  test('fails if the group member pagination cursor does not advance',
      () async {
    await expectLater(
      queryGroupCallInvitees(
        groupID: 'group-1',
        currentUserID: 'caller',
        queryPage: (groupID, config) async => ZIMGroupMemberListQueriedResult(
          groupID: groupID,
          userList: const [],
          nextFlag: config.nextFlag == 0 ? 17 : config.nextFlag,
        ),
      ),
      throwsStateError,
    );
  });

  test('returns no invitees when the current user is the only member',
      () async {
    final invitees = await queryGroupCallInvitees(
      groupID: 'group-1',
      currentUserID: 'caller',
      queryPage: (groupID, config) async => ZIMGroupMemberListQueriedResult(
        groupID: groupID,
        userList: [
          ZIMGroupMemberInfo(userID: 'caller', userName: 'Caller'),
        ],
        nextFlag: 0,
      ),
    );

    expect(invitees, isEmpty);
  });
}
