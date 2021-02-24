import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class MyBuildAlertDialog extends StatefulWidget {
  final BuildContext ctx;
  final Widget bodyAlertDialog;

  MyBuildAlertDialog(this.ctx, this.bodyAlertDialog);

  @override
  _MyBuildAlertDialog createState() => _MyBuildAlertDialog(ctx);
}

class _MyBuildAlertDialog extends State<MyBuildAlertDialog> {
  BuildContext ctx;

  _MyBuildAlertDialog(this.ctx);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white.withOpacity(0.0),
      ),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.all(6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.white, Colors.lightBlueAccent],
              ),
            ),
            child: Container(
                margin: EdgeInsets.all(3),
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: widget.bodyAlertDialog),
          ),
          InkWell(
            onTap: () {
              setState(() {
                Navigator.pop(context);
              });
            },
            child: Container(
              alignment: Alignment.center,
              child: Icon(
                Icons.close,
                size: 15,
                color: Colors.white,
              ),
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white,
                    Colors.black,
                    Colors.white,
                  ],
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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