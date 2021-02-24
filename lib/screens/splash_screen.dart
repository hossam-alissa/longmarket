import 'package:flutter/material.dart';
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
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: SplashScreen(
            navigateAfterSeconds: MultiProvider(
              providers: [
                ChangeNotifierProvider<UserInformation>(
                    create: (_) => UserInformation()),
                // ChangeNotifierProvider<MyProvider>(create: (_) => MyProvider()),
                ChangeNotifierProxyProvider<UserInformation, Advertisement>(
                    create: (_) => Advertisement(),
                    update: (ctx, valueUI, valueAdv) =>
                    valueAdv..getDataAuthToken(authToken: valueUI.token)),
                ChangeNotifierProxyProvider<UserInformation, Comments>(
                    create: (_) => Comments(),
                    update: (ctx, valueUI, valueCom) =>
                    valueCom..getDataAuthToken(authToken: valueUI.token)),
              ],
              child: MyApp(),
            ),
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
