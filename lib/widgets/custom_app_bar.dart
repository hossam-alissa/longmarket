import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../models/advertising.dart';
import '../config/config.dart';

AppBar customAppBarMobile(BuildContext ctxScaffold) {
  return AppBar(
    backgroundColor: Colors.white,
    backwardsCompatibility: false,
    leadingWidth: 50.0,
    flexibleSpace: FlexibleSpaceBar(
      titlePadding: EdgeInsets.zero,
      title: Container(
        padding: isLeft
            ? EdgeInsets.all(7.0)
            : EdgeInsets.only(bottom: 1.0, left: 5.0, right: 9.0),
        height: 103.0,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              isLeft == true ? Colors.white : Colors.lightBlue[600],
              isLeft == true ? Colors.lightBlue[600] : Colors.white,
            ],
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              isLeft ? "long market" : "السوق الطويل",
              style: TextStyle(
                fontSize: 30.0,
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
            Expanded(child: SizedBox(width: double.maxFinite)),
            Padding(
              padding: isLeft
                  ? EdgeInsets.only(bottom: 5.0)
                  : EdgeInsets.only(bottom: 10.0),
              child: InkWell(
                child: Icon(
                  Icons.notifications_outlined,
                  size: 30.0,
                  color: Colors.white,
                ),
                onTap: () async {
                  print("notifications");
                  print(Provider.of<Advertisement>(providerContext, listen: false)
                          .listAdvertising
                          .length
                          .toString());
                  print(Provider.of<UserInformation>(providerContext,
                          listen: false)
                      .token);
                },
              ),
            ),
            SizedBox(width: 38.0),
          ],
        ),
      ),
    ),
  );
}