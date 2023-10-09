import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showError(msg) {
  return Fluttertoast.showToast(
      msg: msg,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 1);
}

separate() {
  return Container(
    color: Colors.grey.withOpacity(0.5),
    height: 1,
    width: double.infinity,
  );
}
