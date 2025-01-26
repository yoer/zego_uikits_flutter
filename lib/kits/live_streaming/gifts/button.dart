// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:zego_uikit/zego_uikit.dart';

// Project imports:
import 'package:zego_uikits_demo/common/bottom_sheet.dart';
import 'package:zego_uikits_demo/kits/live_streaming/gifts/service.dart';
import 'package:zego_uikits_demo/kits/live_streaming/gifts/sheet.dart';
import 'defines.dart';

class GiftButton extends StatefulWidget {
  const GiftButton({
    super.key,
    required this.targetReceiver,
  });

  final ZegoUIKitUser? targetReceiver;

  @override
  State<GiftButton> createState() {
    return _GiftButtonState();
  }
}

class _GiftButtonState extends State<GiftButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: const Icon(Icons.card_giftcard, color: Colors.white),
      onTap: () {
        openBottomSheet(
          context: context,
          child: FutureBuilder(
            future: GiftService().queryModels(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GiftsSheet(
                  gifts: snapshot.data as List<GiftModel>? ?? [],
                  onSend: null == widget.targetReceiver
                      ? null
                      : (model) {
                          GiftService().send(model.id, 1);
                        },
                );
              }

              return const CircularProgressIndicator();
            },
          ),
        );
      },
    );
  }
}
