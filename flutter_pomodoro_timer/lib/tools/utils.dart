import 'package:flutter/material.dart';

import 'package:sprintf/sprintf.dart';
import 'package:fluttertoast/fluttertoast.dart';


String secondsToString(int seconds) {
    return sprintf('%02d:%02d', [seconds ~/ 60, seconds % 60]);
}

void showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0
  );
}