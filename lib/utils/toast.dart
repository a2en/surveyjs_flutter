
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(String msg, {Color? color, Color? textColor}) {
  if(msg.contains('An error')){
    return;
  }
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: color ?? Colors.black87,
      textColor:textColor??Colors.white,
      fontSize: 16.0,
    );
}
