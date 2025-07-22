// Project imports:
import 'defines.dart';

class UserDoc {
  String id;
  String name;
  bool isLogin;

  /// room id
  String roomID;
  RoomType roomType;
  bool isHost;
  LiveStreamingPKState pkState;

  UserDoc({
    required this.id,
    required this.name,
    this.isLogin = false,
    this.roomID = '',
    this.roomType = RoomType.none,
    this.isHost = false,
    this.pkState = LiveStreamingPKState.idle,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'is_login': isLogin,
      'room_id': roomID,
      'room_type': roomType.index,
      'is_host': isHost,
      'pk_state': pkState.index,
    };
  }

  static UserDoc fromMap(Map<String, dynamic> map) {
    return UserDoc(
      id: map['id'],
      name: map['name'],
      isLogin: map['is_login'] ?? false,
      roomID: map['room_id'] ?? '',
      roomType: RoomType.values[map['room_type'] ?? RoomType.none.index],
      isHost: map['is_host'] ?? false,
      pkState: LiveStreamingPKState
          .values[map['pk_state'] ?? LiveStreamingPKState.idle.index],
    );
  }
}
