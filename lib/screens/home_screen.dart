import 'package:flutter/material.dart';
import 'package:longmarket/screens/screens.dart';
import 'package:provider/provider.dart';

import '../widgets/widgets.dart';
import '../config/config.dart';
import '../helper/helper.dart';
import '../models/advertising.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<Advertisement>(providerContext, listen: false).fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarMobile(),
      endDrawer: CustomEndDrawer(),
      body: myBigList("All"),
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
