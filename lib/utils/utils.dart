import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static changeFocus(BuildContext context, FocusNode current, FocusNode next) {
    current.unfocus();
    FocusScope.of(context).requestFocus(next);
  }

  static toastMessage(String msg) {
    Fluttertoast.showToast(msg: msg);
  }

  static void flushbarErrorMessage(String msg, BuildContext context) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        borderRadius: BorderRadius.circular(5),
        forwardAnimationCurve: Curves.decelerate,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(20),
        message: msg,
        duration: const Duration(seconds: 3),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: Colors.red,
        reverseAnimationCurve: Curves.easeIn,
        positionOffset: 20,
        icon: const Icon(Icons.error),
      )..show(context),
    );
  }
}
