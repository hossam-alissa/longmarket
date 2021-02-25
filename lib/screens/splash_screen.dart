import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:longmarket/config/config.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';

import '../main.dart';
import '../models/models.dart';
class MainSplashScreen extends StatefulWidget {
  @override
  _MainSplashScreenState createState() => _MainSplashScreenState();
}

class _MainSplashScreenState extends State<MainSplashScreen> {


  @override
  void initState() {
    getLanguage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: SplashScreen(
            navigateAfterSeconds: MyApp(),
            seconds: 3,
            imageBackground: AssetImage('images/splash-packgraound.png'),
            photoSize: 100,
            title: Text("Long Market",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            useLoader: false,
          ),
        ),
      ),
    );
  }
}
