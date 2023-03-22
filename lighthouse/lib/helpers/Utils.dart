import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

class Utils {
  static List<String> permissions = [];

  static toast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static errorSnackBar(BuildContext context, String message) {
    showTopSnackBar(
      Overlay.of(context)!,
      CustomSnackBar.error(
        message: message,
      ),
      displayDuration: const Duration(milliseconds: 500),
    );
  }

  static successSnackBar(BuildContext context, String message) {
    showTopSnackBar(
      Overlay.of(context)!,
      CustomSnackBar.success(
        message: message,
      ),
      displayDuration: const Duration(milliseconds: 500),
    );
  }

  static infoSnackBar(BuildContext context, String message) {
    showTopSnackBar(
      Overlay.of(context)!,
      CustomSnackBar.info(
        message: message,
      ),
      displayDuration: const Duration(milliseconds: 500),
    );
  }
}
