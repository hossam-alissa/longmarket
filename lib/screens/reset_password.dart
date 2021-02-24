import 'package:flutter/material.dart';
import 'package:longmarket/config/config.dart';
import 'package:longmarket/widgets/widgets.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController emailUserName = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  MyBuildAlertDialog(
      context,
      SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
            Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding:
                  EdgeInsets.only(top: 10, right: 0, left: 0, bottom: 4),
                  child: Text(
                    isLeft ? 'Reset Password' : "إستعادة الرقم السري",
                    textAlign: TextAlign.center,
                    style:
                    TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
                  child: TextField(
                    maxLength: 50,
                    keyboardType: TextInputType.emailAddress,
                    controller: emailUserName,
                    decoration: InputDecoration(
                      labelText: (isLeft ? 'Email :' : "الإميل"),
                      alignLabelWithHint: true,
                    ),
                  ),
                ),
              ),
            ],
          ),
          //End Text Field User Name
          // Row(
          //   children: <Widget>[
          //     Expanded(
          //       child: Padding(
          //         padding: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
          //         child: TextField(
          //           maxLength: 10,
          //           keyboardType: TextInputType.number,
          //           controller: mobileNumber,
          //           decoration: InputDecoration(
          //             labelText: (isLeft
          //             ? 'Mobile number : 09***' : "رقم الجوال ...٠٩"),
          //             alignLabelWithHint: true,
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ), //End Text Field Password
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 15, right: 15, left: 15, bottom: 2),
                  child: InkWell(
                    onTap: () {
                      setState(() {

                      });
                    },
                    child: Text(
                      isLeft ? 'SingIn !' : "تسجيل الدخول !",
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.lightBlueAccent,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
          //Reset password
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    top: 15, bottom: 20, left: 25, right: 25),
                child: ElevatedButton(
                    child: Text(
                      isLeft ? 'Reset Password' : "إستعادة الرقم السري",
                      textScaleFactor: 1.5,
                    ),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      if (emailUserName.text != '') {
                        // if (mobileNumber.text.length == 10) {
                        try {
                          print("start");
                          // Provider.of<UserInformation>(widget.providerContext,listen: false).resetPassword(email: emailUserName.text);
                          Navigator.pop(context);
                          print("end");
                        } catch (error) {
                          print(error);
                        }
                        // }
                        // else {
                        //   toastShow('Mobile number is not correct', context);
                        // }
                      } else {
                        toastShow(
                            isLeft ? 'Email is empty' : "حقل الإميل فارغ",
                            context);
                      }
                    }),
              ),

            ],
          ),
        ]),
      ),
    );
  }
}
