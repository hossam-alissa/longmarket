import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import '../main.dart';

class MainSplashScreen extends StatefulWidget {
  @override
  _MainSplashScreenState createState() => _MainSplashScreenState();
}

class _MainSplashScreenState extends State<MainSplashScreen> {
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
