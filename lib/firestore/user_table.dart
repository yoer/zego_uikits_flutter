// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

// Project imports:
import 'package:zego_uikits_demo/firestore/defines.dart';
import 'package:zego_uikits_demo/firestore/user_doc.dart';
import '../data/user.dart';

class UserTable {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _init = false;

  /// Cache
  final cacheNotifier = ValueNotifier<Map<String, UserDoc>>({});

  void init() {
    if (_init) {
      return;
    }
    _init = true;

    /// Start real-time listener
    _startListening();
  }

  void _startListening() {
    _firestore.collection('users').snapshots().listen((snapshot) {
      for (var change in snapshot.docChanges) {
        final user = UserDoc.fromMap(change.doc.data()!);
        switch (change.type) {
          /// Add new user
          case DocumentChangeType.added:
            cacheNotifier.value[user.id] = user;

            break;

          /// Update user
          case DocumentChangeType.modified:
            cacheNotifier.value[user.id] = user;

            break;

          /// Remove user
          case DocumentChangeType.removed:
            cacheNotifier.value.remove(user.id);

            break;
        }
      }

      cacheNotifier.notifyListeners();
    });
  }

  ///  Query all users in the table
  Future<List<UserDoc>> query() async {
    try {
      final snapshot = await _firestore.collection('users').get();
      List<UserDoc> users = snapshot.docs.map((doc) {
        /// Update cache
        UserDoc user = UserDoc.fromMap(doc.data());
        cacheNotifier.value[user.id] = user;

        return user;
      }).toList();

      cacheNotifier.notifyListeners();

      return users;
    } catch (e) {
      /// Handle query error
      debugPrint("Error querying users: $e");
      return [];
    }
  }

  ///  Add a user
  Future<void> addUser(UserDoc user) async {
    if (!_validateUser(user)) {
      debugPrint("Validation failed for user: ${user.id}");
      return;
    }
    try {
      await _firestore.collection('users').doc(user.id).set(user.toMap());

      /// Update cache
      cacheNotifier.value[user.id] = user;
      cacheNotifier.notifyListeners();
    } catch (e) {
      /// Handle add error
      debugPrint("Error adding user: $e");
    }
  }

  /// Delete a user
  Future<void> deleteUser(String userId) async {
    try {
      await _firestore.collection('users').doc(userId).delete();

      /// Remove from cache
      cacheNotifier.value.remove(userId);
      cacheNotifier.notifyListeners();
    } catch (e) {
      /// Handle delete error
      debugPrint("Error deleting user: $e");
    }
  }

  /// Update user data by user ID
  Future<void> updateUser(UserDoc user) async {
    if (!_validateUser(user)) {
      debugPrint("Validation failed for user: ${user.id}");
      return;
    }

    UserDoc? cachedUser = cacheNotifier.value[user.id];
    if (cachedUser != null) {
      Map<String, dynamic> updates = {};

      /// Check which fields have been modified
      if (cachedUser.name != user.name) {
        updates['name'] = user.name;
      }
      if (cachedUser.isLogin != user.isLogin) {
        updates['is_login'] = user.isLogin;
      }
      if (cachedUser.roomID != user.roomID) {
        updates['room_id'] = user.roomID;
      }

      /// Perform partial update
      if (updates.isNotEmpty) {
        try {
          await _firestore
              .collection('users')
              .doc(user.id)
              .update(updates)
              .timeout(
            const Duration(seconds: 2),
            onTimeout: () {
              throw TimeoutException('Update user info timeout');
            },
          );

          /// Update cache
          cacheNotifier.value[user.id] = user;
        } catch (e) {
          /// Handle update error
          debugPrint("Error updating user: $e");
        }
      }
    } else {
      /// If the user is not in the cache, choose to add it
      try {
        await _firestore.collection('users').doc(user.id).set(user.toMap());

        /// Update cache
        cacheNotifier.value[user.id] = user;
      } catch (e) {
        /// Handle add error (no cache)
        debugPrint("Error adding user (no cache): $e");
      }
    }

    cacheNotifier.notifyListeners();
  }

  Future<void> updateUserLoginStatus(String userID, bool targetValue) async {
    if (userID.isEmpty) {
      return;
    }

    UserDoc? cachedUser = cacheNotifier.value[userID];
    if (cachedUser == null) {
      return;
    }

    Map<String, dynamic> updates = {};
    if (cachedUser.isLogin != targetValue) {
      updates['is_login'] = targetValue;
    }

    if (updates.isNotEmpty) {
      try {
        await _firestore
            .collection('users')
            .doc(userID)
            .update(updates)
            .timeout(
          const Duration(seconds: 2),
          onTimeout: () {
            throw TimeoutException('Update user login status timeout');
          },
        );

        /// Update cache
        cacheNotifier.value[userID]?.isLogin = targetValue;
      } catch (e) {
        /// Handle update error
        debugPrint("Error updating user: $e");
      }

      cacheNotifier.notifyListeners();
    }
  }

  Future<void> updateUserRoomInfo(
    String userID,
    String roomID,
    RoomType roomType,
    bool isHost,
  ) async {
    if (userID.isEmpty) {
      return;
    }

    UserDoc? cachedUser = cacheNotifier.value[userID];
    if (cachedUser == null) {
      return;
    }

    Map<String, dynamic> updates = {};
    if (cachedUser.roomID != roomID) {
      updates['room_id'] = roomID;
    }
    if (cachedUser.roomType != roomType) {
      updates['room_type'] = roomType.index;
    }
    if (cachedUser.isHost != isHost) {
      updates['is_host'] = isHost;
    }

    if (updates.isNotEmpty) {
      try {
        await _firestore
            .collection('users')
            .doc(userID)
            .update(updates)
            .timeout(
          const Duration(seconds: 2),
          onTimeout: () {
            throw TimeoutException('Update user room info timeout');
          },
        );

        /// Update cache
        cacheNotifier.value[userID]?.roomID = roomID;
        cacheNotifier.value[userID]?.roomType = roomType;
        cacheNotifier.value[userID]?.isHost = isHost;
      } catch (e) {
        /// Handle update error
        debugPrint("Error updating user: $e");
      }

      cacheNotifier.notifyListeners();
    }
  }

  Future<void> updateUserRoomHost(
    String userID,
    bool isHost,
  ) async {
    if (userID.isEmpty) {
      return;
    }

    UserDoc? cachedUser = cacheNotifier.value[userID];
    if (cachedUser == null) {
      return;
    }

    Map<String, dynamic> updates = {};

    if (cachedUser.isHost != isHost) {
      updates['is_host'] = isHost;
    }

    if (updates.isNotEmpty) {
      try {
        await _firestore
            .collection('users')
            .doc(userID)
            .update(updates)
            .timeout(
          const Duration(seconds: 2),
          onTimeout: () {
            throw TimeoutException('Update user room host status timeout');
          },
        );

        /// Update cache
        cacheNotifier.value[userID]?.isHost = isHost;
      } catch (e) {
        /// Handle update error
        debugPrint("Error updating user: $e");
      }

      cacheNotifier.notifyListeners();
    }
  }

  Future<void> updateUserLiveStreamingPKState(
    String userID,
    LiveStreamingPKState pkState,
  ) async {
    if (userID.isEmpty) {
      return;
    }

    UserDoc? cachedUser = cacheNotifier.value[userID];
    if (cachedUser == null) {
      return;
    }

    Map<String, dynamic> updates = {};

    if (cachedUser.pkState != pkState) {
      updates['pk_state'] = pkState.index;
    }

    if (updates.isNotEmpty) {
      try {
        await _firestore
            .collection('users')
            .doc(userID)
            .update(updates)
            .timeout(
          const Duration(seconds: 2),
          onTimeout: () {
            throw TimeoutException('Update user PK state timeout');
          },
        );

        /// Update cache
        cacheNotifier.value[userID]?.pkState = pkState;
      } catch (e) {
        /// Handle update error
        debugPrint("Error updating user: $e");
      }

      cacheNotifier.notifyListeners();
    }
  }

  /// Data validation
  bool _validateUser(UserDoc user) {
    return user.id.isNotEmpty && user.name.isNotEmpty;
  }
}
