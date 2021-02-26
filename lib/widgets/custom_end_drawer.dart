import 'package:flutter/material.dart';
import 'package:longmarket/config/config.dart';
import 'package:longmarket/models/models.dart';
import 'package:longmarket/screens/screens.dart';
import 'package:longmarket/widgets/widgets_tools.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class CustomEndDrawer extends StatefulWidget {
  @override
  _CustomEndDrawerState createState() => _CustomEndDrawerState();
}

class _CustomEndDrawerState extends State<CustomEndDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: isLeft
          ? EdgeInsets.only(top: 20.0, bottom: 20.0, left: 50.0)
          : EdgeInsets.only(top: 20.0, bottom: 20.0, right: 50.0),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20, bottom: 20, left: 0, right: 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: isLeft ? Radius.circular(25) : Radius.circular(0),
                topRight: isLeft ? Radius.circular(0) : Radius.circular(25),
                bottomLeft: isLeft ? Radius.circular(25) : Radius.circular(0),
                bottomRight: isLeft ? Radius.circular(0) : Radius.circular(25),
              ),
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
                borderRadius: BorderRadius.only(
                  topLeft: isLeft ? Radius.circular(25) : Radius.circular(0),
                  topRight: isLeft ? Radius.circular(0) : Radius.circular(25),
                  bottomLeft: isLeft ? Radius.circular(25) : Radius.circular(0),
                  bottomRight:
                      isLeft ? Radius.circular(0) : Radius.circular(25),
                ),
                color: Colors.white,
              ),
              //    child: bodyAlertDialog,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                              width: 70,
                              height: 32,
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black45),
                                borderRadius: BorderRadius.circular(17),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.white,
                                    Colors.grey,
                                  ],
                                ),
                              ),
                              child: Text(
                                isLeft ? 'Done' : "تم",
                                style: TextStyle(color: Colors.black),
                              )),
                        ),
                      ],
                    ),
                  ),
                  myDivider(),
                  Expanded(
                    child: Container(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: <Widget>[
                          buildListTile(
                              context,
                              isLeft
                                  ? "SingUp Create New Account"
                                  : "إنشاء حساب جديد",
                              SingUpScreen()),
                          myDivider(),
                          buildListTile(
                              context,
                              isLeft ? "Sing In" : "تسجيل الدخول",
                              SingInScreen()),
                          myDivider(),
                          ListTile(
                            title: myText(isLeft ? "Log out" : "تسجيل الخروج"),
                            trailing: Icon(Icons.navigate_next),
                            onTap: ()  async{
                              try{
                                await Provider.of<UserInformation>(providerContext,listen: false).logOutUserInformation();
                              }catch(e){
                                print(e.toString());
                              }
                            },
                          ),
                          myDivider(),
                          buildListTile(
                              context,
                              isLeft
                                  ? "Treaty to use service"
                                  : "معاهدة الإستخدام",
                              TreatyToUseService()),
                          myDivider(),
                          buildListTile(context,
                              isLeft ? "Call Us" : "إتصل بنا", CallUsScreen()),
                          myDivider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("العربية"),
                              Switch(
                                  value: isLeft,
                                  onChanged: (value) {
                                    setState(() {
                                      isLeft = value;
                                      setLanguage();
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                MyApp()),
                                        ModalRoute.withName('/'),
                                      );
                                    });
                                  }),
                              Text("English"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

ListTile buildListTile(BuildContext context, String title, Widget nextPage) {
  return ListTile(
    title: myText(title),
    trailing: Icon(Icons.navigate_next),
    onTap: () {
      AlertDialog aDI = AlertDialog(
        insetPadding: EdgeInsets.all(20),
        backgroundColor: Colors.white70.withOpacity(0.1),
        elevation: double.maxFinite,
        contentPadding: EdgeInsets.all(0),
        content: nextPage,
      );
      showDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.black.withOpacity(0.6),
        builder: (context) => aDI,
      );
    },
  );
}
