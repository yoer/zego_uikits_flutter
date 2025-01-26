// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:zego_uikits_demo/data/assets.dart';

Widget uikitsLogo(double height) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: Image.asset(
      MyImages.uikits,
      height: height,
    ),
  );
}

Widget logo() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Text(
        'By ',
        style: TextStyle(fontSize: 15.r),
      ),
      Image.asset(
        MyIcons.zego,
        height: 30.r,
      ),
    ],
  );
}
