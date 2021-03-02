import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/config.dart';
import '../helper/helper.dart';
import '../models/models.dart';
import '../screens/screens.dart';
import '../widgets/widgets.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  List<Advertising> items =
      Provider.of<Advertisement>(providerContext, listen: false)
          .listAdvertisingForUser;

  @override
  void initState() {
    Provider.of<Advertisement>(providerContext, listen: false)
        .getAdvertisingForUser(
            Provider.of<UserInformation>(providerContext, listen: false)
                .idInDataBase);
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: items.length + 2,
        scrollDirection: Axis.vertical,
        itemBuilder: (ctx, index) {
          if (index == 0)
            return Container(
              height: 70.0,
              width: double.maxFinite,
              color: Colors.red,
              child: Row(
                children: [],
              ),
            );
          else if (index < items.length + 1)
            return GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      ShowAdvertisingScreen(advertising: items[index - 1]),
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
                          tag: items[index - 1].idAdvertising,
                          child: Image.network(
                            items[index - 1].imgUrl,
                            height: 120.0,
                            width: 120.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 32.0),
                      padding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 4.0),
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
                                items[index - 1].title,
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
                                  items[index - 1].userNameAddedAdvertising,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500),
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
                                      Text(
                                        "${items[index - 1].city.toString()}",
                                        overflow: TextOverflow.visible,
                                      ),
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
                                          "${items[index - 1].department}",
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
                                          "${items[index - 1].category}",
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
                                          "${TimeAgo.timeAgoSinceDate(items[index - 1].date).toString()}",
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
          else
            return Container(
              height: 70.0,
              width: double.maxFinite,
              color: Colors.greenAccent,
              child: Row(
                children: [],
              ),
            );
        },
      ),
      // Column(
      //   children: [
      //     Container(
      //       height: 70.0,
      //       width: double.maxFinite,
      //       color: Colors.red,
      //       child: Row(
      //         children: [
      //         ],
      //       ),
      //     ),
      //     Expanded(
      //       child: Container(
      //         height: 1000,
      //           child: _myBigList()),
      //     ),
      //   ],
      // ),
    );
  }

// Widget _myBigList() {
//   // List<Advertising> items = Provider.of<Advertisement>(providerContext, listen: false).listAdvertisingForUser;
//   var listView;
//   listView = ListView.builder(
//     itemCount: items.length,
//     scrollDirection: Axis.vertical,
//     itemBuilder: (ctx, countNum) {
//       return GestureDetector(
//         onTap: () => Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (_) =>
//                 ShowAdvertisingScreen(advertising: items[countNum]),
//           ),
//         ),
//         child: Container(
//           height: 350.0,
//           margin: EdgeInsets.only(bottom: 7.0),
//           // color: Colors.green,
//           child: Column(
//             children: [
//               Container(
//                 height: 220.0,
//                 width: double.maxFinite,
//                 margin: const EdgeInsets.fromLTRB(17.0, 10, 17.0, 0),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15.0),
//                   border: Border.all(color: Colors.black45, width: 1.5),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black12,
//                       offset: Offset(0, 2),
//                       blurRadius: 6.0,
//                     ),
//                   ],
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(
//                     13.0,
//                   ),
//                   child: Hero(
//                     tag: items[countNum].idAdvertising,
//                     child: Image.network(
//                       items[countNum].imgUrl,
//                       height: 120.0,
//                       width: 120.0,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 32.0),
//                 padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4.0),
//                 height: 110.0,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(0),
//                     topRight: Radius.circular(0),
//                     bottomLeft: Radius.circular(15.0),
//                     bottomRight: Radius.circular(15.0),
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black12,
//                       offset: Offset(0, 2),
//                       blurRadius: 6.0,
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Text(
//                           items[countNum].title,
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyle(
//                             fontSize: 16.0,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                     myDivider(),
//                     Expanded(
//                       child: Row(
//                         children: [
//                           Text(
//                             items[countNum].userNameAddedAdvertising,
//                             overflow: TextOverflow.ellipsis,
//                             style: TextStyle(
//                                 fontSize: 14.0, fontWeight: FontWeight.w500),
//                           ),
//                           Expanded(child: SizedBox()),
//                           // VerticalDivider(color: Colors.black54,),
//                           Container(
//                             color: Colors.white,
//                             height: 20.0,
//                             width: 70.0,
//                             child: Row(
//                               children: [
//                                 Icon(
//                                   Icons.add_location,
//                                   size: 14,
//                                 ),
//                                 Text(
//                                   "${items[countNum].city.toString()}",
//                                   overflow: TextOverflow.visible,
//                                 ),
//                               ],
//                             ),
//                           ),
//                           // Text(getTranslated(context, "city")),
//                         ],
//                       ),
//                     ),
//                     myDivider(),
//                     Expanded(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           Container(
//                             color: Colors.white,
//                             height: 20.0,
//                             width: 80,
//                             child: Row(
//                               children: [
//                                 Icon(Icons.article, size: 14),
//                                 Expanded(
//                                   child: Text(
//                                     "${items[countNum].department}",
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           VerticalDivider(
//                             color: Colors.black54,
//                           ),
//                           Container(
//                             color: Colors.white,
//                             height: 20.0,
//                             width: 80,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Icon(Icons.article_outlined, size: 14),
//                                 Expanded(
//                                   child: Text(
//                                     "${items[countNum].category}",
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           VerticalDivider(
//                             color: Colors.black54,
//                           ),
//                           Container(
//                             color: Colors.white,
//                             height: 20.0,
//                             width: 70,
//                             child: Row(
//                               children: [
//                                 Icon(Icons.access_time, size: 14),
//                                 Expanded(
//                                   child: Text(
//                                     "${TimeAgo.timeAgoSinceDate(items[countNum].date).toString()}",
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     },
//   );
//   return listView;
// }
}
