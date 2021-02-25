import 'package:flutter/material.dart';

import '../config/config.dart';
import '../screens/screens.dart';
import '../screens/nav_screen.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(MainSplashScreen());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    providerContext = context;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Long Market',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:NavScreen(),
    );
  }
}

