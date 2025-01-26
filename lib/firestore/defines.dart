enum RoomType {
  none,
  call,
  audioRoom,
  liveStreaming,
  liveStreamingPK,
  liveStreamingList,
  conference,
  unknown,
}

extension RoomTypeExtension on RoomType {
  static RoomType fromRoomID(String roomID) {
    if (roomID.isEmpty) {
      return RoomType.none;
    }

    if (roomID.startsWith('call_')) {
      return RoomType.call;
    } else if (roomID.startsWith('audio_room_')) {
      return RoomType.audioRoom;
    } else if (roomID.startsWith('live_pk')) {
      return RoomType.liveStreamingPK;
    } else if (roomID.startsWith('live_')) {
      return RoomType.liveStreaming;
    } else if (roomID.startsWith('conference_')) {
      return RoomType.conference;
    } else if (roomID.startsWith('zg_t_r')) {
      return RoomType.liveStreamingList;
    }

    return RoomType.unknown;
  }
}

enum LiveStreamingPKState {
  idle,
  waiting,
  inPK,
}
