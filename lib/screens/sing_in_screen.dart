import 'package:flutter/material.dart';
import 'package:longmarket/helper/helper.dart';
import 'package:provider/provider.dart';

import '../config/config.dart';
import '../main.dart';
import '../widgets/widgets.dart';
import '../models/models.dart';

class SingInScreen extends StatefulWidget {
  @override
  _SingInScreenState createState() => _SingInScreenState();
}

class _SingInScreenState extends State<SingInScreen> {
  TextEditingController emailUserName = new TextEditingController();
  TextEditingController passwordUser = new TextEditingController();
  bool _secureText = true;
  bool _resetPassword = false;

  @override
  Widget build(BuildContext context) {
    return MyBuildAlertDialog(
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
                    _resetPassword
                        ? isLeft
                            ? "Reset Password"
                            : "إستعادة الرقم السري"
                        : isLeft
                            ? 'Sing In'
                            : "تسجيل الدخول",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.grey,
                          blurRadius: 2.0,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                  child: TextField(
                    maxLength: 50,
                    keyboardType: TextInputType.emailAddress,
                    controller: emailUserName,
                    decoration: InputDecoration(
                      labelText: (isLeft ? 'Email : ' : "البريد الإلكتروني : "),
                      alignLabelWithHint: true,
                    ),
                  ),
                ),
              ),
            ],
          ), //End Text Field Email
          _resetPassword
              ? SizedBox()
              : Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                        child: TextField(
                          maxLength: 25,
                          controller: passwordUser,
                          decoration: InputDecoration(
                            labelText:
                                (isLeft ? 'Password : ' : "الرقم السري :"),
                            alignLabelWithHint: true,
                            suffixIcon: IconButton(
                              icon: Icon(_secureText
                                  ? Icons.remove_red_eye
                                  : Icons.security),
                              onPressed: () {
                                setState(() {
                                  _secureText = !_secureText;
                                });
                              },
                            ),
                          ),
                          obscureText: _secureText,
                        ),
                      ),
                    ),
                  ],
                ), //End Text Field Password
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  alignment:
                      isLeft ? Alignment.centerLeft : Alignment.centerRight,
                  padding:
                      EdgeInsets.only(top: 15, right: 15, left: 15, bottom: 2),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _resetPassword = !_resetPassword;
                        print("reset password");
                      });
                    },
                    child: Text(
                      isLeft ? 'Reset password !' : "! إستعادة الرقم السري",
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.lightBlueAccent,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ), //Reset password
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding:
                      EdgeInsets.only(top: 15, bottom: 20, left: 25, right: 25),
                  child: ElevatedButton(
                    child: Text(
                      _resetPassword
                          ? isLeft
                              ? "Reset Password"
                              : "إستعادة الرقم السري"
                          : isLeft
                              ? 'Sing In'
                              : "تسجيل الدخول",
                      textScaleFactor: 1.5,
                    ),
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      if (_resetPassword == true) {
                        if (emailUserName.text != "") {
                          print("reset Password");
                          try{
                            await Provider.of<UserInformation>(providerContext,listen: false).resetPassword(email: emailUserName.text);
                            toastShow(
                                isLeft
                                    ? "Done, Send message to email address, Open the Link to change your Password"
                                    : "تم إرسال رسالة إلى بريدك الإلكتروني،قم بفتح الرابط وقم بتغير كلمة السر",
                                context);
                          }catch(e){
                            toastShow(errorExceptionFireBase(e.toString()), context);
                            print(e);
                          }

                        } else {
                          toastShow(
                              isLeft
                                  ? "Enter you Email"
                                  : "قم بإدخال البريد الإلكتروني",
                              context);
                        }
                      } else {
                        if (emailUserName.text != "") {
                          if (passwordUser.text != "") {
                            if (passwordUser.text.length >= 8) {
                              print("Sing IN");
                              try {
                                await Provider.of<UserInformation>(
                                        providerContext,
                                        listen: false)
                                    .singInInDataBase(
                                        emailUserName: emailUserName.text,
                                        passwordUser: passwordUser.text);
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          MyApp()),
                                  ModalRoute.withName('/'),
                                );
                              } catch (e) {
                                toastShow(errorExceptionFireBase(e.toString()), context);
                                print(e);
                              }
                            } else {
                              toastShow(
                                  isLeft
                                      ? "Password not accept"
                                      : "الرقم السري غير صحيح",
                                  context);
                            }
                          } else {
                            toastShow(
                                isLeft
                                    ? "Entre you Password"
                                    : "قم بإدخال الرقم السري",
                                context);
                          }
                        } else {
                          toastShow(
                              isLeft
                                  ? "Enter you Email"
                                  : "قم بإدخال البريد الإلكتروني",
                              context);
                        }
                      }
                    },
                  ),
                ),
              ),
            ],
          ), //Sing in button
        ]),
      ),
    );
  }
}
