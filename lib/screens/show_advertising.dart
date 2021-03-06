import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/config.dart';
import '../helper/helper.dart';
import '../models/advertising.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';
class ShowAdvertisingScreen extends StatefulWidget {
  final Advertising advertising;

  ShowAdvertisingScreen({@required this.advertising});

  @override
  _ShowAdvertisingScreenState createState() => _ShowAdvertisingScreenState();
}

class _ShowAdvertisingScreenState extends State<ShowAdvertisingScreen> {
  int imgIndex;
  List imgUrlList = [''];
  TextEditingController addComment = new TextEditingController();

  String userName = "";
  String city = '';
  String date = '';
  String title = '';
  String details = '';
  String timeAgo = "";
  String mobileNumber = "";

  _getData() async {
    try {
        Provider.of<Comments>(providerContext, listen: false).commentList.clear();
        await Provider.of<Comments>(providerContext, listen: false).fetchData(idAdvertising: widget.advertising.idAdvertising);
        setState(() {

        });
      // await Provider.of<UserInformation>(providerContext, listen: false).startApp();
    } catch (e) {
      toastShow(
          isLeft
              ? "Check your connection is bad, No Downloaded"
              : "الرجاء التأكد من اتصالك ، لا يمكن التحميل",
          context);
      print(e);
    }
  }

  @override
  void initState() {
    setState(() {
      userName = widget.advertising.userNameAddedAdvertising;
      city = widget.advertising.city;
      timeAgo = TimeAgo.timeAgoSinceDate(widget.advertising.date).toString();
      title = widget.advertising.title;
      details = widget.advertising.details;
      imgUrlList.clear();
      imgUrlList.add(widget.advertising.imgUrl.toString());
      mobileNumber = widget.advertising.mobileNumber;

    });
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: isLeft ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.lightBlue[600],
          ),
          title: Text(
            isLeft ? "Advertising" : "الإعلانات",
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  color: Colors.black,
                  blurRadius: 3.0,
                  offset: Offset(1, 1),
                ),
              ],
            ),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  isLeft == true ? Colors.white : Colors.lightBlue[600],
                  isLeft == true ? Colors.lightBlue[600] : Colors.white,
                ],
              ),
            ),
          ),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  SizedBox(height: 16),
                  Row(
                    children: [
                      imgUrlList[0] != ''
                          ? Expanded(
                              child: CarouselSlider.builder(
                                itemCount: imgUrlList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    width: double.infinity,
                                    child: Center(
                                      child: Image.network(
                                        imgUrlList[index].toString(),
                                        // fit: BoxFit.fill,
                                      ),
                                    ),
                                  );
                                },
                                options: CarouselOptions(
                                  enableInfiniteScroll: true,
                                  height: 330,
                                  initialPage: 0,
                                  enlargeCenterPage: true,
                                  //   autoPlay: true,
                                  onPageChanged: (index, _) {
                                    setState(() {
                                      imgIndex = index;
                                    });
                                  },
                                ),
                              ),
                            )
                          : Expanded(child: Image.asset("images/download_image.png",height: 300,width: 400,)),
                    ],
                  ), //Images View
                  myDivider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Container(
                            child: Row(
                              children: [
                                Icon(Icons.person_rounded),
                                Expanded(
                                    child: Text(
                                  userName.toString(),
                                  overflow: TextOverflow.ellipsis,
                                ))
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            child: Row(
                              children: [
                                Icon(Icons.add_location),
                                Text(
                                  city.toString(),
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ), //End Information publisher

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Container(
                            child: Row(
                              children: [
                                Icon(Icons.phone_android),
                                Expanded(
                                    child: Text(
                                  mobileNumber,
                                  overflow: TextOverflow.ellipsis,
                                ))
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            child: Row(
                              children: [
                                Icon(Icons.access_time),
                                Expanded(
                                    child: Text(
                                  (timeAgo).toString(),
                                  overflow: TextOverflow.ellipsis,
                                ))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ), //End Information publisher
                  myDivider(),
                  _buildRowTitleAndDetails(isLeft ? "Title :" : "العنوان :", title),
                  //End Advertising Title
                  _buildRowTitleAndDetails(
                      isLeft ? "Details :" : "التفاصيل :", details),
                  //End Advertising Details
                  myDivider(),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height:
                              Provider.of<Comments>(providerContext, listen: true)
                                  .sizeContainerBox(),
                          width: double.maxFinite,
                          child: _myBigList(),
                        ),
                      ),
                    ],
                  ), //End Scroll Comment
                  myDivider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // InkWell(onTap: () {}, child: Icon(Icons.favorite_border)),
                      // InkWell(
                      //     onTap: () async {
                      //       // if (addComment.text != "") {
                      //       //   await
                      //       //   FirebaseFirestore.instance.collection('/chats')
                      //       //       .add({
                      //       //       'text': '${addComment.text.toString()}',
                      //       //     'createdAt': Timestamp.now(),
                      //       //
                      //       //   },
                      //       //   );
                      //       // }
                      //     },
                      //     child: Icon(Icons.email_outlined)),
                      InkWell(
                          onTap: () {
                            AlertDialog aDialog =  AlertDialog(
                              insetPadding: EdgeInsets.all(20),
                              backgroundColor: Colors.white70.withOpacity(0.1),
                              elevation: double.maxFinite,
                              contentPadding: EdgeInsets.all(0),
                               content: AddReportAdvertising(idAdvertising: widget.advertising.idAdvertising,idAddedAdvertising: widget.advertising.idAddedAdvertising,)
                            );
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              barrierColor: Colors.black.withOpacity(0.6),
                              builder: (ctx) => aDialog,
                            );
                          },
                          child: Icon(
                            Icons.report_gmailerrorred_outlined,
                            color: Colors.red,
                          )),
                    ],
                  ), // End Icons
                  myDivider(),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 2, horizontal: 15),
                          child: TextField(
                            maxLength: 250,
                            controller: addComment,
                            decoration: InputDecoration(
                              labelText:
                                  (isLeft ? "Add Comment :" : "إضافة تعليق :"),
                              alignLabelWithHint: true,
                              suffixIcon: IconButton(
                                icon: Icon(Icons.send),
                                onPressed: () async {
                                  FocusScope.of(context).unfocus();
                                  if (Provider.of<UserInformation>(
                                              providerContext,
                                              listen: false)
                                          .isAuth ==
                                      true) {
                                    if (addComment.text == '') {
                                      toastShow(
                                          isLeft
                                              ? "Write you\'r comment !"
                                              : "قم بكتابة تعليقك !",
                                          context);
                                    } else {
                                      toastShow(
                                          isLeft
                                              ? "Adding Comment now"
                                              : "جاري إضافة تعليقك",
                                          context);
                                      try {
                                        FocusScope.of(context).unfocus();
                                        await Provider.of<Comments>(
                                                providerContext,
                                                listen: false)
                                            .add(
                                                idAdvertising: widget
                                                    .advertising.idAdvertising,
                                                userIdAddedComment:
                                                    Provider.of<UserInformation>(
                                                            providerContext,
                                                            listen: false)
                                                        .idInDataBase,
                                                textComment:
                                                    addComment.text.toString(),
                                                userNameAddedAdvertising:
                                                    Provider.of<UserInformation>(
                                                            providerContext,
                                                            listen: false)
                                                        .username);
                                        setState(() {
                                          addComment.text = '';
                                        });
                                        toastShow(
                                            isLeft
                                                ? "Added comment"
                                                : "تم إضافة تعليقك",
                                            context);
                                      } catch (error) {
                                        return showDialog<Null>(
                                          context: context,
                                          builder: (innerContext) => AlertDialog(
                                            title: Text('An Error'),
                                            content: Text(isLeft
                                                ? "Connection is bad ,Please check your Connection."
                                                : "الإتصال ضعيف تأكد من الإتصال لديك" +
                                                    '\n ${error.toString()}'),
                                            actions: [
                                              TextButton(
                                                child:
                                                    Text(isLeft ? "Done" : "تم"),
                                                onPressed: () =>
                                                    Navigator.pop(innerContext),
                                              )
                                            ],
                                          ),
                                        );
                                      }
                                    }
                                  } else {
                                    toastShow(
                                        isLeft
                                            ? "Please Log In or Sing Up new account"
                                            : "قم بتسجيل الدخول أو إنشاء حساب جديد أولا",
                                        context);
                                    setState(() {
                                      addComment.text = "";
                                    });
                                  }
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ), //End Add Comment
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row _buildRowTitleAndDetails(String txtTitle, String txtDetails) {
    return Row(
      children: [
        Expanded(
          child: Container(
            width: double.maxFinite,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15 , vertical: 9),
                  child: Row(
                    children: [Text(txtTitle)],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15 , vertical: 9),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                      colors: [Colors.white, Colors.grey.withOpacity(0.2)],
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                        txtDetails,
                        overflow: TextOverflow.fade,
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Color bGContainer = Colors.white12;

  Color backGroundColor(Color ch) {
    if (ch == Colors.white) {
      ch = Colors.white12;
      bGContainer = ch;
    } else if (ch == Colors.white12) {
      ch = Colors.white;
      bGContainer = ch;
    }
    return ch;
  }

  getDataSoursComments() {
    int lengthOfList =
        Provider.of<Comments>(providerContext, listen: true).commentList.length;
    var items =
        List<String>.generate(lengthOfList, (countNum) => "item $countNum");
    return items;
  }

  Widget _myBigList() {
    int lengthOfList =
        Provider.of<Comments>(providerContext, listen: true).commentList.length;
    List<Comment> listComments =
        Provider.of<Comments>(providerContext, listen: true).commentList;
    var listView;
    if (lengthOfList > 0) {
      listView = ListView.builder(
        itemCount: listComments.length,
        padding: EdgeInsets.only(bottom: 0),
        reverse: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, countNum) {
          return InkWell(
            child: Container(
              color: backGroundColor(bGContainer),
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 3, top: 17),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 43,
                        width: 43,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white,
                              Colors.grey.withOpacity(0.5),
                            ],
                          ),
                        ),
                        child: Icon(
                          Icons.person,
                          size: 35,
                        ),
                      )
                    ],
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              '${listComments[countNum].userNameAddedAdvertising}',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ))
                          ],
                        ),
                        Row(children: [
                          Expanded(
                            child: Text(
                              listComments[countNum].textComment,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
    return listView;
  }
}
