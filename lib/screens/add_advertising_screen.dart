import 'dart:async';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:longmarket/models/models.dart';
import 'package:provider/provider.dart';

import '../config/config.dart';
import '../widgets/widgets.dart';
import '../helper/tools.dart';

class AddAdvertisingScreen extends StatefulWidget {
  @override
  _AddAdvertisingScreenState createState() => _AddAdvertisingScreenState();
}

class _AddAdvertisingScreenState extends State<AddAdvertisingScreen> {
  int imgIndex = 0;
  String imgURL = '';

  List<String> imgUrlList = [
    'images/img1.jpg',
    'images/img2.jpg',
    'images/img3.jpg'
  ];
  TextEditingController aaTitle = new TextEditingController();
  TextEditingController aaDetails = new TextEditingController();

  static var departmentOne = [
    isLeft ? "Select Department :" : "إختر القسم :",
    isLeft ? "Cars" : "سيارات",
    isLeft ? "Home" : "عقارات",
    isLeft ? "Mobile" : "موبايلات",
    isLeft ? "Furniture" : "مفروشات",
    isLeft ? "Electron" : "الكترونيات",
    isLeft ? "Other" : "آخرى",
  ];
  String selectedDepartmentOne = departmentOne[0];
  static var category = [
    isLeft ? "Select Category :" : "إختر الفئة :",
  ];
  String selectedCategory = category[0];
  TextEditingController aaMobileNumber = new TextEditingController();

  String selectedCityValue = cityUser[0];
  List<bool> chBox = [false, false, false, false, true];
  File image;
  final picker = ImagePicker();
  bool _isLoading = false;

  Future getImage() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 20);
    setState(() {
      if (pickedFile != null) image = File(pickedFile.path);
    });
  }

  // List<Asset> photoAsset = <Asset>[];
  //  String _error = 'No Error';
  //  Future upLodePhoto() async {
  //    List<Asset> resultList;
  //    try {
  //      resultList = await MultiImagePicker.pickImages(
  //        maxImages: 1,
  //        enableCamera: true,
  //        selectedAssets: photoAsset,
  //      );
  //      if(resultList != null){
  //        setState(() {
  //          photoAsset = resultList;
  //        });
  //      }
  //
  //    } catch (e) {
  //      print(e);
  //    }
  //  }

  // setState(() {
  //   departmentOne.add(getTranslated(context, "SelectـDepartment"));
  //   departmentOne.add(getTranslated(context, "Cars"));
  //   departmentOne.add(getTranslated(context, "Home"));
  //   departmentOne.add(getTranslated(context, "Mobile"));
  //   departmentOne.add(getTranslated(context, "Furniture"));
  //   departmentOne.add(getTranslated(context, "Electron"));
  //   departmentOne.add(getTranslated(context, "Other"));
  // });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarMobile(),
      endDrawer: CustomEndDrawer(),
      body: CustomScrollView(
        slivers: [
          // CustomAppBarMobile(),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return _infoAdvertising();
              },
              childCount: (1), //Number of length
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoAdvertising() {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        image != null
                            ? Stack(
                                children: [
                                  Container(
                                    child: Image.file(
                                      image,
                                      width: 300,
                                      height: 300,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        image = null;
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Icon(
                                        Icons.close,
                                        size: 12,
                                        color: Colors.white,
                                      ),
                                      height: 18,
                                      width: 18,
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
                              )
                            : Expanded(child: Image.asset("images/download_image.png",height: 300,width: 400,)),
                      ],
                    ),
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: CarouselSlider.builder(
                    //         itemCount: photoAsset.isEmpty ? 1 : photoAsset.length,
                    //         itemBuilder: (BuildContext context, int index) {
                    //           return Stack(
                    //             children: [
                    //               Container(
                    //                 width: double.infinity,
                    //                 margin: EdgeInsets.symmetric(
                    //                     vertical: 5, horizontal: 5),
                    //                 child: photoAsset.isEmpty
                    //                     ? Image.asset('images/uploadeimage.png',
                    //                         fit: BoxFit.fill)
                    //                     : AssetThumb(
                    //                         asset: photoAsset[index],
                    //                         height: 300,
                    //                         width: 300,
                    //                       ),
                    //               ),
                    //               InkWell(
                    //                 onTap: () {
                    //                   setState(() {
                    //                     if (photoAsset.isNotEmpty) {
                    //                       try {
                    //                         print('${photoAsset[index]}');
                    //                         photoAsset.removeAt(index);
                    //                       } catch (e) {
                    //                         print(e);
                    //                       }
                    //                     }
                    //                   });
                    //                 },
                    //                 child: Container(
                    //                   alignment: Alignment.center,
                    //                   child: Icon(
                    //                     Icons.close,
                    //                     size: 12,
                    //                     color: Colors.white,
                    //                   ),
                    //                   height: 15,
                    //                   width: 15,
                    //                   decoration: BoxDecoration(
                    //                     border: Border.all(color: Colors.white),
                    //                     gradient: LinearGradient(
                    //                       begin: Alignment.topLeft,
                    //                       end: Alignment.bottomRight,
                    //                       colors: [
                    //                         Colors.white,
                    //                         Colors.black,
                    //                         Colors.white,
                    //                       ],
                    //                     ),
                    //                     shape: BoxShape.circle,
                    //                   ),
                    //                 ),
                    //               ),
                    //             ],
                    //           );
                    //         },
                    //         options: CarouselOptions(
                    //           enableInfiniteScroll: false,
                    //           height: 300,
                    //           initialPage: 0,
                    //           enlargeCenterPage: true,
                    //           onPageChanged: (index, _) {
                    //             setState(() {
                    //               imgIndex = index;
                    //             });
                    //           },
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ), //Images View
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(),
                          onPressed: () {
                            getImage();
                            //    upLodePhoto();
                          },
                          child: myText(isLeft ? "UpLoad photo" : "رفع الصورة"),
                        ),
                      ],
                    ),
                    myDivider(),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 3, bottom: 3, left: 20, right: 20),
                            child: TextField(
                              controller: aaTitle,
                              maxLength: 60,
                              decoration: InputDecoration(
                                labelText: (isLeft ? 'Title' : 'العنوان'),
                                alignLabelWithHint: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    //Title
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 3, bottom: 3, left: 20, right: 20),
                            child: TextField(
                              controller: aaDetails,
                              maxLines: 8,
                              maxLength: 250,
                              decoration: InputDecoration(
                                labelText: (isLeft ? "Details" : "التفاصيل"),
                                alignLabelWithHint: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    //Details
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 3, bottom: 3, left: 10, right: 10),
                            child: ListTile(
                              title: DropdownButton(
                                value: selectedDepartmentOne,
                                items: departmentOne.map((String dropDownItem) {
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
                                    selectedDepartmentOne = selectedItem;
                                    print(selectedDepartmentOne);
                                    if (selectedDepartmentOne ==
                                            "Select Department :" ||
                                        selectedDepartmentOne ==
                                            "إختر القسم :") {
                                      category = [
                                        isLeft
                                            ? "Select Category"
                                            : "إختر الفئة :",
                                      ];
                                      selectedCategory = category[0];
                                    }

                                    if (selectedDepartmentOne == "Cars" ||
                                        selectedDepartmentOne == "سيارات") {
                                      category = [
                                        isLeft
                                            ? 'Select Car Model :'
                                            : 'إختر موديل السيارة :',
                                        isLeft ? "Mercedes" : "مرسيدس",
                                        isLeft ? 'Toyota' : "تويوتا",
                                        isLeft ? 'Mazda' : 'مازدا',
                                        isLeft ? 'KIA' : 'كيا',
                                        isLeft ? 'Hyundai' : 'هيونداي',
                                        isLeft ? 'Honda' : 'هوندا',
                                      ];
                                      selectedCategory = category[0];
                                    }

                                    if (selectedDepartmentOne == "Home" ||
                                        selectedDepartmentOne == "عقارات") {
                                      category = [
                                        isLeft
                                            ? 'Select Home :'
                                            : 'إختر نوع العقار :',
                                        isLeft ? 'Land for sale' : 'أرض للبيع',
                                        isLeft ? 'Land for rent' : 'أرض للإجار',
                                        isLeft ? 'House for sale' : 'شقة للبيع',
                                        isLeft
                                            ? 'House for rent'
                                            : 'شقة للإجار',
                                      ];
                                      selectedCategory = category[0];
                                    }
                                    if (selectedDepartmentOne == "Mobile" ||
                                        selectedDepartmentOne == "موبايلات") {
                                      category = [
                                        isLeft
                                            ? 'Select Mobile Model'
                                            : 'إختر موديل الموبايل',
                                        'Apple',
                                        'Samsung',
                                        'HUAWEI',
                                        'Redmi',
                                        'Xiaomi',
                                      ];
                                      selectedCategory = category[0];
                                    }
                                    if (selectedDepartmentOne == "Furniture" ||
                                        selectedDepartmentOne == "مفروشات") {
                                      category = [
                                        isLeft
                                            ? 'Select Furniture Model'
                                            : 'إختر نوع المفروشات',
                                        isLeft ? 'Living Room' : 'غرفة المعيشة',
                                        isLeft ? 'Bed room' : 'غرفة نوم',
                                        isLeft ? 'Guest room' : 'غرفة ضيوف',
                                        isLeft ? "Kid's room" : 'غرفة أطفال',
                                        isLeft ? "Carpets" : 'السجاد',
                                        isLeft ? "Chairs" : 'كراسي',
                                        isLeft ? "Table" : "طاولات"
                                      ];
                                      selectedCategory = category[0];
                                    }
                                    if (selectedDepartmentOne == "Electron" ||
                                        selectedDepartmentOne == "الكترونيات") {
                                      category = [
                                        isLeft
                                            ? 'Select Electron Model'
                                            : 'إختر تصنيف الإلكتونيات',
                                        isLeft ? 'TV' : 'تلفزيون',
                                        isLeft ? 'Refrigerator' : 'ثلاجة',
                                        isLeft ? 'Oven' : 'فرن',
                                        isLeft ? 'Conditioner' : 'مكيف',
                                        isLeft ? 'Microwave' : 'مايكرويف',
                                        isLeft ? "Washer" : 'غسالة',
                                        isLeft ? "Water heaters" : 'سخان ماء',
                                      ];
                                      selectedCategory = category[0];
                                    }
                                    if (selectedDepartmentOne == "Other" ||
                                        selectedDepartmentOne == "آخرى") {
                                      category = [
                                        isLeft
                                            ? 'Select Other Model'
                                            : 'تصنيفات آخرى',
                                        isLeft ? 'Animal' : '',
                                        isLeft ? 'Dogs' : "كلاب",
                                        isLeft ? "Cats" : "قطط",
                                      ];
                                      selectedCategory = category[0];
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    //End DropDownButton selectedDepartment
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 3, bottom: 3, left: 10, right: 10),
                            child: ListTile(
                              title: DropdownButton(
                                value: selectedCategory,
                                items: category.map((String dropDownItem) {
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
                                    selectedCategory = selectedItem;
                                    print(selectedCategory);
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    //End DropDownButton selectedCategory
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 3, horizontal: 20),
                            child: TextField(
                              controller: aaMobileNumber,
                              decoration: InputDecoration(
                                labelText:
                                    (isLeft ? "Mobile Number" : "رقم الموبايل"),
                                alignLabelWithHint: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              maxLength: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                    //End Mobile Number
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 3, bottom: 3, left: 10, right: 10),
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
                                    print(selectedCityValue);
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    //End DropDownButton City
                    myDivider(),
                    buildCheckBox(0,
                        "أنا المعلن أتحمل كافة المسؤولية عن محتوى الإعلان وليس لإدارة تطبيق السوق الطويل أو تطبيق السوق الطويل اي مسؤولية أو علاقة في محتوى الإعلان"),
                    myDivider(),
                    buildCheckBox(1, "موافق على جميع قوانين معاهدة الإستخدام"),
                    //Check Box 2
                    myDivider(),
                    buildCheckBox(2,
                        "أنا المعلن أتعهد بدفع عمولة التطبيق ٢.٥٪ في حال تم بيع السلعة وتبقى في زمة المعلن الى يوم القيامة، إلا في حال نسبة ٢.٥٪ لم تتجاوز ٢٠٠٠ ليرة يتم توزيعها على الفقراء لوجة الله تعالى واذا كانت نسبة ٢.٥٪ أكثر من ٢٠٠٠ ليرة يتم تحويلها عن طريق البنك ويمكن الحصول على المعلومات من خلال قائمة إتصل بنا "),
                    //Check Box 2
                    myDivider(),
                    buildCheckBox(3,
                        "يحق لإدارة التطبيق ملاحقة المعلن قانونيا في حال تم إثبات أن المعلن تم بيع السلعه من خلال تطبيق السوق الطويل ولم يتم تحويل النسبة المتفق عليها"),
                    //Check Box 2
                    myDivider(),
                    // buildCheckBox(4, "٥"),
                    // //Check Box 2
                    // myDivider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, bottom: 50.0, left: 20.0, right: 20.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              if (aaTitle.text != "") {
                                if (aaDetails.text != "") {
                                  if (selectedDepartmentOne !=
                                      departmentOne[0].toString()) {
                                    if (selectedCategory != category[0]) {
                                      if (aaMobileNumber.text != '' &&
                                          aaMobileNumber.text.length == 10) {
                                        if (selectedCityValue != cityUser[0]) {
                                          if (image != null) {
                                            if (chBox[0] == true &&
                                                chBox[1] == true &&
                                                chBox[2] == true &&
                                                chBox[3] == true &&
                                                chBox[4] == true) {
                                              setState(() {
                                                _isLoading = true;
                                              });
                                              try {
                                              await  Provider.of<Advertisement>(providerContext, listen: false).addAdvertising(
                                                    idAddedAdvertising:
                                                        Provider.of<UserInformation>(
                                                                context,
                                                                listen: false)
                                                            .idInDataBase,
                                                    title:
                                                        aaTitle.text.toString(),
                                                    details: aaDetails.text
                                                        .toString(),
                                                    city: selectedCityValue
                                                        .toString(),
                                                    department:
                                                        selectedDepartmentOne,
                                                    category: selectedCategory,
                                                    date: DateTime.now()
                                                        .toIso8601String(),
                                                    imageFile: image,
                                                    userNameAddedAdvertising:
                                                        Provider.of<UserInformation>(
                                                                context,
                                                                listen: false)
                                                            .username,
                                                    mobileNumber: aaMobileNumber
                                                        .text
                                                        .toString());

                                                setState(
                                                  () {
                                                    image = null;
                                                    aaTitle.text = "";
                                                    aaDetails.text = "";
                                                    selectedDepartmentOne =
                                                        departmentOne[0];
                                                    selectedCategory =
                                                        category[0];
                                                    aaMobileNumber.text = '';
                                                    selectedCityValue =
                                                        cityUser[0];

                                                    chBox = [
                                                      false,
                                                      false,
                                                      false,
                                                      false,
                                                      false
                                                    ];
                                                    _isLoading = false;
                                                  },
                                                );
                                                toastShow(
                                                    isLeft
                                                        ? "Done added and share"
                                                        : "تم إضافة الإعلان بنجاح",
                                                    context);
                                              } catch (error) {
                                                setState(() {
                                                  _isLoading = false;
                                                });
                                                toastShow(
                                                    isLeft
                                                        ? "Not Added advertising"
                                                        : "الإتصال غير جيد، يرجا المحاوله لاحقا",
                                                    context);
                                                print(error);
                                              }
                                            } else {
                                              toastShow(
                                                  isLeft
                                                      ? "Accept all ch box"
                                                      : "يجب قبول جميع الشروط",
                                                  context);
                                            }
                                          } else {
                                            toastShow(
                                                isLeft
                                                    ? "Can not Add with out photo"
                                                    : "يجب إضافة صورة للإعلان",
                                                context);
                                          }
                                        } else {
                                          toastShow(
                                              isLeft
                                                  ? "City is not selected"
                                                  : "قم بإختيار المدينة",
                                              context);
                                        }
                                      } else {
                                        toastShow(
                                            isLeft
                                                ? "Check your mobile number"
                                                : "رقم الجوال غير صحيح",
                                            context);
                                      }
                                    } else {
                                      toastShow(
                                          isLeft
                                              ? "Category is not selected"
                                              : "إختر فئة الإعلان",
                                          context);
                                    }
                                  } else {
                                    toastShow(
                                        isLeft
                                            ? "Department is not selected"
                                            : "إختر قسم الإعلان",
                                        context);
                                  }
                                } else {
                                  toastShow(
                                      isLeft
                                          ? "Details is empty"
                                          : "قم بإضافة تفاصيل للإعلان",
                                      context);
                                }
                              } else {
                                toastShow(
                                    isLeft
                                        ? "Title is empty"
                                        : "قم بإضافة عنوان للإعلان",
                                    context);
                              }
                            },
                            child:
                                myText(isLeft ? "Save and share" : "حفظ و نشر"),
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

  Row buildCheckBox(int index, String checkBoxTxt) {
    return Row(
      children: [
        Checkbox(
          onChanged: (value) {
            setState(() {
              chBox[index] = value;
            });
          },
          value: chBox[index],
        ),
        Expanded(
            child: Text(
          checkBoxTxt,
          overflow: TextOverflow.visible,
        )),
      ],
    );
  }
}
