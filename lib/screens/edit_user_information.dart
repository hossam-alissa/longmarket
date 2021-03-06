import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/config.dart';
import '../helper/helper.dart';
import '../widgets/widgets.dart';
import '../models/models.dart';

class EditUserInformation extends StatefulWidget {
  @override
  _EditUserInformationState createState() => _EditUserInformationState();
}

class _EditUserInformationState extends State<EditUserInformation> {
  TextEditingController userName = new TextEditingController();
  TextEditingController mobileNumber = new TextEditingController();
  TextEditingController firstName = new TextEditingController();
  TextEditingController secondName = new TextEditingController();
  TextEditingController lastName = new TextEditingController();
  String selectedCityValue = cityUser[0];
  TextEditingController areaUser = new TextEditingController();
  TextEditingController validationMobileNumber = new TextEditingController();
  bool ch = false;

  @override
  void initState() {
    userName.text =
        Provider.of<UserInformation>(providerContext, listen: false).username;
    mobileNumber.text =
        Provider.of<UserInformation>(providerContext, listen: false)
            .mobileNumber;
    firstName.text =
        Provider.of<UserInformation>(providerContext, listen: false).firstName;
    secondName.text =
        Provider.of<UserInformation>(providerContext, listen: false).secondName;
    lastName.text =
        Provider.of<UserInformation>(providerContext, listen: false).lastName;

    var city = Provider.of<UserInformation>(providerContext, listen: false).city;

    if (city == "Damascus" || city == "دمشق")
        selectedCityValue = cityUser[1];
    else if(city == "Aleppo" || city == "حلب")
      selectedCityValue = cityUser[2];
    else if(city == "Hama" || city == "حماه")
      selectedCityValue = cityUser[3];
    else if(city == "Homs" || city == "حمص")
      selectedCityValue = cityUser[4];
    else if(city == "Latakia" || city == "الاذقية")
      selectedCityValue = cityUser[4];
    else if(city == "Tartous" || city == "طرطوس")
      selectedCityValue = cityUser[5];
    else if(city == "Jablah" || city == "جبلة")
      selectedCityValue = cityUser[6];
    else if(city == "Damascus Countryside" || city == "ريف دمشق")
      selectedCityValue = cityUser[7];
    else if(city == "Daraa" || city == "درعا")
      selectedCityValue = cityUser[8];
    else if(city == "Kenitra" || city == "القنيطره")
      selectedCityValue = cityUser[9];
    else if(city == "Endosperm" || city == "السويداء")
      selectedCityValue = cityUser[10];

    setState(() {});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyBuildAlertDialog(
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
                        isLeft ? 'Edit Information' : "تعديل المعلومات",
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
              myDivider(),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                      child: Text(
                          (isLeft ? 'Email :' : "البريد الإلكتروني : "+ Provider.of<UserInformation>(providerContext,listen: false).email.toString()),
                      overflow: TextOverflow.visible,
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
                        controller: userName,
                        decoration: InputDecoration(
                          labelText:
                              (isLeft ? 'User Name :' : "إسم المستخدم :"),
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
                      padding: EdgeInsets.only(
                          top: 0, bottom: 0, left: 15, right: 15),
                      child: TextField(
                        controller: mobileNumber,
                        decoration: InputDecoration(
                          labelText:
                              (isLeft ? 'Mobile Number :' : "رقم الجوال :"),
                          alignLabelWithHint: true,
                          // border: OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(30),
                          // ),
                        ),
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 0, bottom: 0, left: 15, right: 15),
                      child: TextField(
                        maxLength: 25,
                        controller: firstName,
                        decoration: InputDecoration(
                          labelText:
                              (isLeft ? 'First Name :' : "الإسم الأول :"),
                          alignLabelWithHint: true,
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
                        controller: secondName,
                        decoration: InputDecoration(
                          labelText:
                              (isLeft ? 'Second Name :' : "الإسم الثاني :"),
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
                        controller: lastName,
                        decoration: InputDecoration(
                          labelText: (isLeft ? 'Last Name :' : "إسم العائلة"),
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
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 6, bottom: 6, left: 10, right: 10),
                      child: ListTile(
                        title: DropdownButton(
                          value: selectedCityValue,
                          items: cityUser.map((String dropDownItem) {
                            return DropdownMenuItem<String>(
                              value: dropDownItem,
                              child: Text(dropDownItem),
                            );
                          }).toList(),
                          onTap: () {
                            FocusScope.of(context).unfocus();
                          },
                          onChanged: (selectedItem) {
                            setState(() {
                              selectedCityValue = selectedItem;
                              print(selectedItem);
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              myDivider(),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 6, bottom: 20, left: 25, right: 25),
                      child: ElevatedButton(
                        child: Text(
                          isLeft ? "Save information" : "حفظ المعلومات",
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          if(userName.text != ""){
                            if(mobileNumber.text != ""){
                              if(mobileNumber.text.length == 10){
                                if(firstName.text != ""){
                                  if(secondName.text != ""){
                                    if(lastName.text != ""){
                                      if(selectedCityValue != cityUser[0]){
                                        print("Save Information");
                                        try {
                                          await Provider.of<UserInformation>(providerContext,
                                              listen: false)
                                              .editInformation(
                                            idInDataBase: Provider.of<UserInformation>(
                                                providerContext,
                                                listen: false)
                                                .idInDataBase,
                                            userName: userName.text.toString(),
                                            mobileNumber: mobileNumber.text.toString(),
                                            firstName: firstName.text.toString(),
                                            secondName: secondName.text.toString(),
                                            lastName: lastName.text.toString(),
                                            city: selectedCityValue.toString(),
                                          );
                                          toastShow(
                                              isLeft
                                                  ? "Done edit information"
                                                  : "تم تعديل المعلومات",
                                              context);
                                          Navigator.pop(context);
                                        } catch (error) {
                                          toastShow(isLeft ? "error" : "خطا", context);
                                          print(error);
                                        }
                                      }else {
                                        toastShow(isLeft ? "Entry your City." : ".قم بإدخال اسم مدينتك", context);
                                      }
                                    }else {
                                      toastShow(isLeft ? "Entry your last name." : ".قم بإدخال اسم العائلة", context);
                                    }
                                  }else {
                                    toastShow(isLeft ? "Entry your second name." : ".قم بإدخال اسمك الثاني", context);
                                  }
                                }else {
                                  toastShow(isLeft ? "Entry your first name." : ".قم بإدخال اسمك الأول", context);
                                }
                              }else{
                                toastShow(isLeft ? "Entry your mobile number." : ".قم بإدخال رقم موبايل صحيح غير مكتمل", context);
                              }
                            }else {
                              toastShow(isLeft ? "Mobile number is empty." : ".قم بإدخال رقم موبايل, حقل رقم الموبايل فارغ", context);
                            }
                          }else {
                            toastShow(isLeft ? "User Name is Empty." : ".قم بإدخال اسم المستخدم. اسم المستخدم فارغ", context);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
