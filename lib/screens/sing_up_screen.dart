import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/config.dart';
import '../main.dart';
import '../widgets/widgets.dart';
import '../models/models.dart';
import '../helper/helper.dart';

class SingUpScreen extends StatefulWidget {
  @override
  _SingUpScreenState createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  TextEditingController emailUserName = new TextEditingController();
  TextEditingController userName = new TextEditingController();
  TextEditingController passwordUser = new TextEditingController();
  TextEditingController passwordUserValidation = new TextEditingController();
  bool _secureText = true;

  TextEditingController validationMobileNumber = new TextEditingController();
  bool ch = false;
  bool lawsCheckBox = false;

  bool sendData = false;

  @override
  Widget build(BuildContext context) {
    return sendData ?Center(child: CircularProgressIndicator()):
    MyBuildAlertDialog(
      context,
      SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 10, bottom: 6, right: 10, left: 10),
                      child: Text(
                        isLeft ? 'New Account' : "إنشاء حساب جديد",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
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
              //End title New Account
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                      child: TextField(
                        maxLength: 50,
                        keyboardType: TextInputType.emailAddress,
                        controller: emailUserName,
                        decoration: InputDecoration(
                          labelText:
                              (isLeft ? 'Email :' : "البريد الإلكتروني :"),
                          alignLabelWithHint: true,
                          // border: OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(30),
                          // ),
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
                      padding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                      child: TextField(
                        maxLength: 25,
                        controller: passwordUser,
                        decoration: InputDecoration(
                          labelText: (isLeft ? 'Password :' : "الرقم السري :"),
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
              ),
              //End Password
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                      child: TextField(
                        maxLength: 25,
                        controller: passwordUserValidation,
                        decoration: InputDecoration(
                          labelText: (isLeft
                              ? 'Password Validation :'
                              : "تأكيد الرقم السري :"),
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
              ), // End password Validation
              Row(
                children: [
                  Checkbox(
                    onChanged: (value) {
                      setState(() {
                        lawsCheckBox = value;
                        FocusScope.of(context).unfocus();
                      });
                    },
                    value: lawsCheckBox,
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(
                      isLeft
                          ? "Accept all laws in Treaty to use service."
                          : "موافق على جميع قوانين معاهدة الإستخدام",
                      overflow: TextOverflow.visible,
                    ),
                  )),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 6, bottom: 20, left: 25, right: 25),
                      child: ElevatedButton(
                        child: Text(
                          isLeft ? "Sing Up" : "إنشاء الحساب",
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () async {
                          setState(() {
                            sendData = true;
                          });
                          FocusScope.of(context).unfocus();
                          if (emailUserName.text != "") {
                            if (passwordUser.text != "") {
                              if (passwordUserValidation.text != "") {
                                if (passwordUser.text ==
                                    passwordUserValidation.text) {
                                  if (lawsCheckBox == true) {
                                    if (passwordUser.text.length >= 8) {
                                      print("Sing Up");
                                      try {
                                        await Provider.of<UserInformation>(
                                                providerContext,
                                                listen: false)
                                            .singUpInDataBase(
                                                email: emailUserName.text,
                                                passwordUser:
                                                    passwordUser.text);

                                          sendData = false;

                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  MyApp()),
                                          ModalRoute.withName('/'),
                                        );
                                      } catch (e) {
                                        setState(() {
                                          sendData = false;
                                        });
                                        toastShow(errorExceptionFireBase(e.toString()), context);
                                        print(e.toString());
                                      }
                                    } else {
                                      toastShow(
                                          isLeft
                                              ? "You\'r password in short"
                                              : "لاحظنا بأن الرقم السري ضعيف يجب أن يتكون من ٨ خانات و أكثر",
                                          context);
                                    }
                                  } else {
                                    toastShow(
                                        isLeft
                                            ? "Accepted laws in Treaty to use service"
                                            : "يجب الموافقة على قوانين معاهدة الإستخدام",
                                        context);
                                  }
                                } else {
                                  toastShow(
                                      isLeft
                                          ? "You\'r Password is not Validation"
                                          : "الرقم السري غير متطابق",
                                      context);
                                }
                              } else {
                                toastShow(
                                    isLeft
                                        ? "Entre you Password Validation"
                                        : "قم بإدخال تاكيد الرقم السري",
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
                        },
                      ),
                    ),
                  ),
                ],
              ),
              //End Sing up button
            ],
          ),
        ),
      ),
    );
  }
}
