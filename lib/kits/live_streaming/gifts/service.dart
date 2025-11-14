// Dart imports:
import 'dart:async';
import 'dart:convert';

// Flutter imports:
import 'package:flutter/services.dart';

// Package imports:
import 'package:zego_uikit/zego_uikit.dart';

// Project imports:
import 'defines.dart';

class GiftService {
  Future<bool> send(
    int giftID,
    int count,
    String liveID,
  ) async {
    return ZegoUIKit().sendInRoomCommand(
      targetRoomID: liveID,
      const JsonEncoder().convert(
        GiftProtocol.toCommandMap(giftID, count),
      ),
      [],
    );
  }

  Future<List<GiftModel>> queryModels() async {
    if (null != models) {
      return models!;
    }

    final String jsonString = await rootBundle.loadString(
      'assets/json/gift.json',
    );
    final List<dynamic> jsonList = json.decode(jsonString);
    models = jsonList.map((json) => GiftModel.fromJson(json)).toList();
    return models!;
  }

  Stream<GiftProtocol> receivedStream() {
    return _giftReceivedStreamCtrl?.stream ?? const Stream.empty();
  }

  Future<void> init() async {
    if (_init) {
      return;
    }
    _init = true;

    _giftReceivedStreamCtrl ??= StreamController<GiftProtocol>.broadcast();

    _listen();
  }

  void _listen() {
    ZegoUIKit()
        .getInRoomCommandReceivedStream()
        .listen(_onInRoomCommandReceived);
  }

  void _onInRoomCommandReceived(ZegoInRoomCommandReceivedData data) {
    var protocol = GiftProtocol(
      senderID: data.fromUser.id,
      senderName: data.fromUser.name,
    );
    protocol.parseJson(data.command);

    _giftReceivedStreamCtrl?.add(protocol);
  }

  List<GiftModel>? models;

  StreamController<GiftProtocol>? _giftReceivedStreamCtrl;

  GiftService._internal();

  bool _init = false;

  factory GiftService() => _instance;

  static final GiftService _instance = GiftService._internal();
}
