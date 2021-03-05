import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/config.dart';
import '../helper/helper.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';
import 'screens.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<Advertising> listAdvertising =
      Provider.of<Advertisement>(providerContext, listen: false)
          .listAdvertisingForUser;
  List<Comment> comment = Provider.of<Comments>(providerContext, listen: false)
      .commentNotificationList;

  @override
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: isLeft ? TextDirection.ltr : TextDirection.rtl,
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(0),
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                  top: 10.0, bottom: 0.0, left: 30, right: 30.0),
              height: 60.0,
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white12,
                    Colors.white12,
                    Colors.white,
                    Colors.white,
                    Colors.white,
                    Colors.white12.withOpacity(0.1),
                  ],
                ),
              ),
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                height: double.maxFinite,
                width: double.maxFinite,
                child: ListView.builder(
                  itemCount: comment.length,
                  itemBuilder: (BuildContext context, index) {
                    final Advertising advertising = listAdvertising.firstWhere(
                        (advertising) => (advertising.idAdvertising ==
                            comment[index].idAdvertising));
                    return _CustomNotification(
                      comment: comment[index],
                      advertising: (advertising),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomNotification extends StatelessWidget {
  final Comment comment;
  final Advertising advertising;

  _CustomNotification({@required this.comment, @required this.advertising});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(comment.idAdvertising);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    ShowAdvertisingScreen(advertising: advertising)));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6.0),
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
        height: 85.0,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    isLeft
                        ? "Comments in your advertising"
                        : "تم إضافة تعليق على إعلانك...",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "${TimeAgo.timeAgoSinceDate(comment.dateAdded).toString()}",
                      overflow: TextOverflow.ellipsis,
                    ),
                    Icon(Icons.access_time, size: 20.0),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    advertising.title.toString(),
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    comment.userNameAddedAdvertising.toString(),
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Text(
                comment.textComment.toString(),
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
