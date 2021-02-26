import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/screens.dart';
import '../screens/nav_screen.dart';
import '../models/models.dart';

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Long Market',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiProvider(
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
        child:  NavScreen(),
      ),
    );
  }
}
