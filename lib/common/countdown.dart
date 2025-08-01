// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:circular_countdown/circular_countdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import '../data/translations.dart';

class CountdownTimer extends StatefulWidget {
  const CountdownTimer({
    required this.seconds,
    required this.tips,
    this.onFinished,
    super.key,
  });

  final int seconds;
  final String tips;
  final void Function()? onFinished;

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  final valuesNotifier = ValueNotifier<List<String>>([]);
  final TextEditingController controller = TextEditingController();
  final remainingSecondsNotifier = ValueNotifier<int>(0);

  TextStyle get textStyle => TextStyle(
        color: Colors.white,
        fontSize: 30.r,
      );

  @override
  void initState() {
    super.initState();

    remainingSecondsNotifier.value = widget.seconds;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.2),
      ),
      padding: EdgeInsets.all(20.r),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          timer(),
          SizedBox(height: 10.r),
          tips(),
        ],
      ),
    );
  }

  Widget timer() {
    return TimeCircularCountdown(
      unit: CountdownUnit.second,
      countdownTotal: widget.seconds,
      textStyle: textStyle,
      onUpdated: (
        CountdownUnit unit,
        int remaining,
      ) {
        remainingSecondsNotifier.value = remaining;
      },
      onFinished: () {
        widget.onFinished?.call();
      },
    );
  }

  Widget tips() {
    return ValueListenableBuilder(
      valueListenable: remainingSecondsNotifier,
      builder: (context, remainingSeconds, _) {
        return Text(
          '${widget.tips}, '
          '${Translations.settings.durationSecondTips(remainingSeconds)}',
          style: textStyle,
        );
      },
    );
  }
}
