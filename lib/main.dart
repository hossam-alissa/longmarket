import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../config/config.dart';
import '../screens/screens.dart';
import '../screens/nav_screen.dart';

void main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MainSplashScreen());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Future getFireBase()async{
  //   // WidgetsFlutterBinding.ensureInitialized();
  //   // await Firebase.initializeApp();
  // }
  @override
  void initState() {
    setState(() {
      providerContext = context;
    });

    // getFireBase();
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
      home: NavScreen(),
    );
  }
}
