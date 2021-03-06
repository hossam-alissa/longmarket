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
  List<Advertising> advertisingList =
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
        itemCount: advertisingList.length + 2,
        scrollDirection: Axis.vertical,
        itemBuilder: (ctx, index) {
          if (index == 0)
            return _CustomHeader();
          else if (index < advertisingList.length + 1) {
            final Advertising advertising = advertisingList[index - 1];
            return _CustomBody(advertising: advertising);
          } else
            return Container(
              height: 27.0,
              width: double.maxFinite,
              child: Row(
                children: [],
              ),
            );
        },
      ),
    );
  }
}

class _CustomHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16.0, right: 16.0),
      height: 80.0,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(2, 2),
            blurRadius: 1.0,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 67.0,
            width: 67.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.lightBlueAccent,
                  blurRadius: 4.0,
                )
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                40.0,
              ),
              child: Image(
                  height: 67.0,
                  width: 67.0,
                  image: AssetImage('images/profile_image.png'),
                  fit: BoxFit.cover),
            ),
          ),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Provider.of<UserInformation>(providerContext, listen: true)
                        .username,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  // Text(
                  //   "Rate",
                  //   style:
                  //   TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                  //   overflow: TextOverflow.ellipsis,
                  // ),
                ],
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.verified_outlined),
            iconSize: 30.0,
            color: Provider.of<UserInformation>(providerContext,listen: false).validation == true? Colors.green : Colors.red,
            onPressed: () {
              AlertDialog aDI = AlertDialog(
                insetPadding: EdgeInsets.all(20),
                backgroundColor: Colors.white70.withOpacity(0.1),
                elevation: double.maxFinite,
                contentPadding: EdgeInsets.all(0),
                content: VerifiedEmail(),
              );
              showDialog(
                context: context,
                barrierDismissible: false,
                barrierColor: Colors.black.withOpacity(0.6),
                builder: (context) => aDI,
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            iconSize: 30.0,
            onPressed: () {
              AlertDialog aDI = AlertDialog(
                insetPadding: EdgeInsets.all(20),
                backgroundColor: Colors.white70.withOpacity(0.1),
                elevation: double.maxFinite,
                contentPadding: EdgeInsets.all(0),
                content: EditUserInformation(),
              );
              showDialog(
                context: context,
                barrierDismissible: false,
                barrierColor: Colors.black.withOpacity(0.6),
                builder: (context) => aDI,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _CustomBody extends StatelessWidget {
  final Advertising advertising;

  _CustomBody({
    @required this.advertising,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ShowAdvertisingScreen(advertising: advertising),
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
                  tag: advertising.idAdvertising,
                  child: Image.network(
                    advertising.imgUrl,
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
                      Expanded(
                        child: Text(
                          advertising.title,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // Container(
                      //   height: 28,
                      //   width: 28,
                      //   child: IconButton(
                      //     padding: const EdgeInsets.all(0.0),
                      //       icon: Icon(Icons.delete_forever_outlined),
                      //       color: Colors.red,
                      //       iconSize: 32,
                      //       onPressed: () {
                      //         print("Delete ADV");
                      //       }),
                      // ),
                    ],
                  ),
                  myDivider(),
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          advertising.userNameAddedAdvertising,
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
                              Text(
                                "${advertising.city.toString()}",
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
                                  "${advertising.department}",
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
                                  "${advertising.category}",
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
                                  "${TimeAgo.timeAgoSinceDate(advertising.date).toString()}",
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
  }
}
