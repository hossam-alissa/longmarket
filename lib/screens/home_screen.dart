import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../screens/screens.dart';
import '../widgets/widgets.dart';
import '../config/config.dart';
import '../helper/helper.dart';
import '../models/advertising.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String sortBy = "All";

  @override
  void initState() {
    try{
      Provider.of<Advertisement>(providerContext, listen: false).fetchData();
      Provider.of<UserInformation>(providerContext, listen: false).startApp();
    }catch(e){

    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          mainBarButton(),
          Expanded(child: myBigList(sortBy)),
        ],
      ),
    );
  }
  Widget mainBarButton() {
    return Container(
      height: 35,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, Colors.grey.withOpacity(0.4)],
        ),
      ),
      padding: EdgeInsets.only(top: 1, bottom: 1),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          circleButton(isLeft ? 'All' : "الجميع"),
          circleButton(isLeft ?  'Cars' :'سيارات'),
          circleButton(isLeft ? 'Home' : 'عقارات'),
          circleButton(isLeft ? 'Mobile' : 'موبايلات'),
          circleButton(isLeft ?  'Furniture' : 'مفروشات'),
          circleButton(isLeft ? 'Electron' : 'الكترونيات'),
          circleButton(isLeft ?  'Other' : 'آخرى'),
        ],
      ),
    );
  }

  Widget circleButton(String nameBtn) {
    return InkWell(
      onTap: () {
        setState(() {
          sortBy = nameBtn;
          print(nameBtn);
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 3),
        alignment: Alignment.center,
        height: 30,
        width: 75,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          nameBtn,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget myBigList(String sort) {
    List<Advertising> items;
    if (sort == "All" || sort == "الجميع") {
      items = Provider.of<Advertisement>(context, listen: true).listAdvertising;
    }
    if (sort == "Cars" || sort == "سيارات") {
      items = Provider.of<Advertisement>(context, listen: false)
          .getListAdvertisingBySort("Cars", "سيارات");
    }
    if (sort == "Home" || sort == "عقارات") {
      items = Provider.of<Advertisement>(context, listen: false)
          .getListAdvertisingBySort("Home", "عقارات");
    }
    if (sort == "Mobile" || sort == "موبايلات") {
      items = Provider.of<Advertisement>(context, listen: false)
          .getListAdvertisingBySort("Mobile", "موبايلات");
    }
    if (sort == "Furniture" || sort == "مفروشات") {
      items = Provider.of<Advertisement>(context, listen: false)
          .getListAdvertisingBySort("Furniture", "مفروشات");
    }
    if (sort == "Electron" || sort == "الكترونيات") {
      items = Provider.of<Advertisement>(context, listen: false)
          .getListAdvertisingBySort("Electron", "الكترونيات");
    }
    if (sort == "Other" || sort == "آخرى") {
      items = Provider.of<Advertisement>(context, listen: false)
          .getListAdvertisingBySort("Other", "آخرى");
    }

    var listView;
    listView = ListView.builder(
      itemCount: items.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (ctx, countNum) {
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  ShowAdvertisingScreen(advertising: items[countNum]),
            ),
          ),
          child: Container(
            height: 350.0,
            margin: EdgeInsets.only(bottom: 7.0),
            // color: Colors.green,
            child: Column(
              children: [
                Container(
                  height: 220.0,
                  width: double.maxFinite,
                  margin: const EdgeInsets.fromLTRB(17.0, 10, 17.0, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(color: Colors.black45, width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 2),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      13.0,
                    ),
                    child: Hero(
                      tag: items[countNum].idAdvertising,
                      child: Image.network(
                        items[countNum].imgUrl,
                        height: 120.0,
                        width: 120.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 32.0),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4.0),
                  height: 110.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0),
                      bottomLeft: Radius.circular(15.0),
                      bottomRight: Radius.circular(15.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 2),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            items[countNum].title,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      myDivider(),
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              items[countNum].userNameAddedAdvertising,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w500),
                            ),
                            Expanded(child: SizedBox()),
                            // VerticalDivider(color: Colors.black54,),
                            Container(
                              color: Colors.white,
                              height: 20.0,
                              width: 70.0,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.add_location,
                                    size: 14,
                                  ),
                                  Text("${items[countNum].city.toString()}",overflow: TextOverflow.visible,),
                                ],
                              ),
                            ),
                            // Text(getTranslated(context, "city")),
                          ],
                        ),
                      ),
                      myDivider(),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              color: Colors.white,
                              height: 20.0,
                              width: 80,
                              child: Row(
                                children: [
                                  Icon(Icons.article, size: 14),
                                  Expanded(
                                    child: Text(
                                      "${items[countNum].department}",
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            VerticalDivider(
                              color: Colors.black54,
                            ),
                            Container(
                              color: Colors.white,
                              height: 20.0,
                              width: 80,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,

                                children: [
                                  Icon(Icons.article_outlined, size: 14),
                                  Expanded(
                                    child: Text(
                                      "${items[countNum].category}",
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            VerticalDivider(
                              color: Colors.black54,
                            ),
                            Container(
                              color: Colors.white,
                              height: 20.0,
                              width: 70,
                              child: Row(
                                children: [
                                  Icon(Icons.access_time, size: 14),
                                  Expanded(
                                    child: Text(
                                      "${TimeAgo.timeAgoSinceDate(items[countNum].date).toString()}",
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
    return listView;
  }
}
