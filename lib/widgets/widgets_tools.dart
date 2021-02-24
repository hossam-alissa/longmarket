import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

Divider myDivider() {
  return Divider(
    color: Colors.black54,
  );
}

void toastShow(String msg, BuildContext ctxToastShow) {
  Toast.show(msg, ctxToastShow, duration: 4);
}

Widget myText(String textBody) {
  return Text(textBody);
}