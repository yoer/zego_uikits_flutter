class StreamTestSettings {
  final String roomId;
  final String userId;
  final String userName;
  final String streamId;
  final bool turnOnCamera;
  final bool turnOnMicrophone;
  final String remoteUserId;
  final String remoteUserName;
  final String remoteStreamId;

  const StreamTestSettings({
    required this.roomId,
    required this.userId,
    required this.userName,
    required this.streamId,
    this.turnOnCamera = true,
    this.turnOnMicrophone = true,
    this.remoteUserId = '',
    this.remoteUserName = '',
    this.remoteStreamId = '',
  });

  StreamTestSettings copyWith({
    String? roomId,
    String? userId,
    String? userName,
    String? streamId,
    bool? turnOnCamera,
    bool? turnOnMicrophone,
    String? remoteUserId,
    String? remoteUserName,
    String? remoteStreamId,
  }) {
    return StreamTestSettings(
      roomId: roomId ?? this.roomId,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      streamId: streamId ?? this.streamId,
      turnOnCamera: turnOnCamera ?? this.turnOnCamera,
      turnOnMicrophone: turnOnMicrophone ?? this.turnOnMicrophone,
      remoteUserId: remoteUserId ?? this.remoteUserId,
      remoteUserName: remoteUserName ?? this.remoteUserName,
      remoteStreamId: remoteStreamId ?? this.remoteStreamId,
    );
  }
}
