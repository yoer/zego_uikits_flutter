// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> openBottomSheet({
  required BuildContext context,
  required Widget child,
  String title = '',
  double heightFactor = 0.45,
  Color backgroundColor = Colors.white,
}) async {
  return showModalBottomSheet(
    // barrierColor: Colors.transparent,
    backgroundColor: backgroundColor,
    context: context,
    useRootNavigator: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(32.0.r),
        topRight: Radius.circular(32.0.r),
      ),
    ),
    isDismissible: true,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return FractionallySizedBox(
        heightFactor: heightFactor,
        child: AnimatedPadding(
          padding: MediaQuery.of(context).viewInsets,
          duration: const Duration(milliseconds: 50),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (title.isNotEmpty) ...[
                    SizedBox(
                      height: 60.r,
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 40.r,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.r),
                  ],
                  SizedBox(
                    height: title.isNotEmpty
                        ? (constraints.maxHeight - 100.r - 16.r)
                        : constraints.maxHeight,
                    child: child,
                  ),
                ],
              );
            },
          ),
        ),
      );
    },
  );
}
