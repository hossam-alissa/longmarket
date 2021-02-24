import 'package:flutter/material.dart';
import '../config/config.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: CustomEndDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            backwardsCompatibility: false,
            forceElevated: true,
            floating: true,
            expandedHeight: 60.0,
            leadingWidth: 50.0,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.zero,
              title: Container(
                padding: isLeft
                    ? EdgeInsets.all(7.0)
                    : EdgeInsets.only(bottom: 1.0, left: 5.0, right: 9.0),
                height: 73.0,
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
                        fontSize: 21.0,
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
                    Expanded(
                        child: SizedBox(
                          width: double.maxFinite,
                        )),
                    Padding(
                      padding: isLeft
                          ? EdgeInsets.only(bottom: 4.0)
                          : EdgeInsets.only(bottom: 9.0),
                      child: InkWell(
                        child: Icon(
                          Icons.notifications_outlined,
                          size: 20.0,
                          color: Colors.white,
                        ),
                        onTap: () async {
                          print("notifications");

                        },
                      ),
                    ),
                    SizedBox(width: 27.0),
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
             return Container(
               margin: const EdgeInsets.all(20.0),
               height: 200.0,
               color: Colors.red,
               child: Row(
                 children: [
                   Text("1"),
                   Text("2"),
                 ],
               ),
             );
              },
              childCount: (5), //Number of length
            ),
          ),
        ],
      ),
    );
  }
}
