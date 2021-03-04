import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      height: double.maxFinite,
      width: double.maxFinite,
      child: Text("0",style: TextStyle(fontSize: 30)),
      );
  }
}
