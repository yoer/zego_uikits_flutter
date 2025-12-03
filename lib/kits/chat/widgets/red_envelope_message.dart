// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:zego_zimkit/zego_zimkit.dart';

class RedEnvelopeMessage extends StatelessWidget {
  const RedEnvelopeMessage({
    super.key,
    required this.message,
  });

  final ZIMKitMessage message;

  void onTap() {
    debugPrint('RedEnvelopeMessage: onTap');
    ZIMKit().updateLocalExtendedData(
      message,
      'localExtendedData-${Random().nextInt(99)}',
    );
  }

  @override
  Widget build(BuildContext context) {
    const redEnvelopeHeight = 40.0;
    return Flexible(
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              child: Container(
                height: 86,
                width: 200,
                color: Colors.orange,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: 8),
                            Container(
                              width: redEnvelopeHeight * 0.7,
                              height: redEnvelopeHeight,
                              color: Colors.red,
                              child: const Center(
                                child: CircleAvatar(
                                  radius: 5,
                                  backgroundColor: Colors.amber,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            const Text(
                              'Red Envelope',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const Divider(thickness: 1),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'ZEGOCLOUD',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Column(
                children: [
                  ValueListenableBuilder(
                    valueListenable: message.localExtendedData,
                    builder: (
                      BuildContext context,
                      String localExtendedData,
                      Widget? child,
                    ) {
                      return Text(localExtendedData);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
