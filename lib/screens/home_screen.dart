import 'package:flutter/material.dart';
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
          CustomAppBarMobile(),
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
