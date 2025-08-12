// Dart imports:
import 'dart:async';
import 'dart:collection';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

// Project imports:
import 'package:zego_uikits_demo/data/translations.dart';
import 'package:zego_uikits_demo/kits/live_streaming/gifts/service.dart';
import 'defines.dart';

class LiveStreamingGiftPlayer extends StatefulWidget {
  const LiveStreamingGiftPlayer({super.key});

  @override
  State<LiveStreamingGiftPlayer> createState() {
    return _LiveStreamingGiftPlayerState();
  }
}

class _LiveStreamingGiftPlayerState extends State<LiveStreamingGiftPlayer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final giftsQueue = Queue<GiftProtocol>();
  StreamSubscription? subscription;

  final displayGiftNotifier = ValueNotifier<GiftProtocol?>(null);

  @override
  void initState() {
    super.initState();

    displayGiftNotifier.addListener(onDisplayingGiftChanged);

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: -3 * 50.r, end: 0).animate(_controller)
      ..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            Future.delayed(const Duration(seconds: 2), () {
              _controller.reverse();
            });
          } else if (status == AnimationStatus.dismissed) {
            displayGiftNotifier.value = null;
          }
        },
      );

    subscription = GiftService().receivedStream().listen(onGiftReceived);
  }

  @override
  void dispose() {
    _controller.dispose();
    subscription?.cancel();

    displayGiftNotifier.removeListener(onDisplayingGiftChanged);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<GiftProtocol?>(
      valueListenable: displayGiftNotifier,
      builder: (context, displayGift, _) {
        if (null == displayGift) {
          return const SizedBox();
        }

        return AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Positioned(
              bottom: 100.r,
              left: _animation.value,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  children: [
                    Text(
                      Translations.gift.received(displayGift.senderName),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.r,
                      ),
                    ),
                    Lottie.asset(
                      GiftType.values[displayGift.giftID].asset,
                      animate: true,
                      width: 50.r,
                      height: 50.r,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void onGiftReceived(GiftProtocol gift) {
    if (null == displayGiftNotifier.value && giftsQueue.isEmpty) {
      displayGiftNotifier.value = gift;
    } else {
      giftsQueue.add(gift);
    }
  }

  void onDisplayingGiftChanged() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (null == displayGiftNotifier.value) {
        if (giftsQueue.isNotEmpty) {
          displayGiftNotifier.value = giftsQueue.removeFirst();
          _controller.forward();
        }
      } else {
        _controller.forward();
      }
    });
  }
}
