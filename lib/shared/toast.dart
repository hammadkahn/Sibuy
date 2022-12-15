import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtil {
  static void showToast(BuildContext context, String msg) {
    if (msg == null) {
      return;
    }
    Fluttertoast.showToast(msg: msg,
        toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);
  }

  static void showToastCenter(BuildContext context, String msg) {
    if (msg == null) {
      return;
    }
    Fluttertoast.showToast(msg: msg,
        toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER);
  }
}