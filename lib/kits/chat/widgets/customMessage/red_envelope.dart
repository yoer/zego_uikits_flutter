// Dart imports:
import 'dart:convert';
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:zego_zimkit/zego_zimkit.dart';

part 'red_envelope_defines.dart';
part 'red_envelope_item.dart';

void demoSendRedEnvelope(conversationID, conversationType) {
  ZIMKit().sendCustomMessage(
    conversationID,
    conversationType,
    customType: DemoCustomMessageType.redEnvelope.index,
    customMessage: jsonEncode({'count': 10, 'money': 100}),
  );
}

Widget demoSendRedEnvelopeButton(
    String conversationID, ZIMKitConversationType conversationType) {
  return IconButton(
    onPressed: () => demoSendRedEnvelope(conversationID, conversationType),
    icon: const Icon(Icons.attach_money),
    style: sendRedEnvelopeButtonStyle(),
  );
}
