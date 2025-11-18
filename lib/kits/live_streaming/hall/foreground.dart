// Flutter imports:
import 'dart:math' as math;
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

// Project imports:
import 'package:zego_uikits_demo/common/avatar.dart';
import 'package:zego_uikits_demo/data/settings.dart';
import 'package:zego_uikits_demo/kits/live_streaming/cache.dart';
import 'package:zego_uikits_demo/kits/live_streaming/zego_page.dart';

class LiveStreamingLiveHallForeground extends StatefulWidget {
  final String liveID;
  final VoidCallback onEnter;
  final ZegoUIKitUser? user;

  const LiveStreamingLiveHallForeground({
    super.key,
    required this.user,
    required this.liveID,
    required this.onEnter,
  });

  @override
  State<LiveStreamingLiveHallForeground> createState() {
    return _LiveStreamingLiveHallPageState();
  }
}

class _LiveStreamingLiveHallPageState
    extends State<LiveStreamingLiveHallForeground> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 20.r,
          right: 20.r,
          bottom: 120.r,
          child: joinButton(),
        ),
        Positioned(
          left: 10.r,
          bottom: 80.r,
          child: livingFlag(),
        ),
        Positioned(
          left: 10.r,
          bottom: 20.r,
          child: userName(),
        ),
      ],
    );
  }

  Widget userName() {
    return Text(
      '@${(widget.user?.name.isEmpty ?? true) ? 'user_${widget.user?.id}' : widget.user?.name}',
      style: TextStyle(
        fontSize: 25.r,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget livingFlag() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12.r,
        vertical: 4.r,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFF69B4), // 粉色
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Text(
        '直播中',
        style: TextStyle(
          fontSize: 25.r,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget joinButton() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.r),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white.withAlpha(70),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.r),
            ),
            padding: EdgeInsets.symmetric(
              vertical: 12.r,
              horizontal: 24.r,
            ),
          ),
          onPressed: widget.onEnter,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              LiveStreamingLiveHallEnterWaveAnimation(
                size: 20.r,
                color: Colors.white,
              ),
              SizedBox(width: 15.r),
              Text(
                '点击进入直播间',
                style: TextStyle(
                  fontSize: 30.r,
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 波浪线动画组件
class LiveStreamingLiveHallEnterWaveAnimation extends StatefulWidget {
  const LiveStreamingLiveHallEnterWaveAnimation({
    super.key,
    required this.size,
    required this.color,
  });

  final double size;
  final Color color;

  @override
  State<LiveStreamingLiveHallEnterWaveAnimation> createState() =>
      _LiveStreamingLiveHallEnterWaveAnimationState();
}

class _LiveStreamingLiveHallEnterWaveAnimationState
    extends State<LiveStreamingLiveHallEnterWaveAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: LiveStreamingLiveHallEnterWavePainter(
              progress: _controller.value,
              color: widget.color,
            ),
          );
        },
      ),
    );
  }
}

/// 波浪线绘制器
class LiveStreamingLiveHallEnterWavePainter extends CustomPainter {
  LiveStreamingLiveHallEnterWavePainter({
    required this.progress,
    required this.color,
  });

  final double progress;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    final centerY = size.height / 2;
    final waveLength = size.width * 0.8;
    final amplitude = size.height * 0.3;
    final offsetX = progress * waveLength * 2;

    final path = Path();
    final points = <Offset>[];

    for (double x = 0; x <= size.width; x += 1) {
      final normalizedX = (x + offsetX) / waveLength;
      final y = centerY + math.sin(normalizedX * 2 * math.pi) * amplitude;
      points.add(Offset(x, y));
    }

    if (points.isNotEmpty) {
      path.moveTo(points.first.dx, points.first.dy);
      for (int i = 1; i < points.length; i++) {
        path.lineTo(points[i].dx, points[i].dy);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(LiveStreamingLiveHallEnterWavePainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}
