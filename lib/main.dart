import 'package:flutter/material.dart';
import './screens/screens.dart';

import 'screens/nav_screen.dart';

void main() {
  runApp(MainSplashScreen());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Long Market',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NavScreen(),
    );
  }
}

