// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:fluttertoast/fluttertoast.dart';

void showInfoToast(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP,
    backgroundColor: Colors.green,
    textColor: Colors.white,
  );
}

void showFailedToast(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    timeInSecForIosWeb: 10,
    gravity: ToastGravity.TOP,
    backgroundColor: Colors.red,
    textColor: Colors.white,
  );
}
