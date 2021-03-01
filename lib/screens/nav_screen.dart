import 'package:flutter/material.dart';

import '../widgets/widgets.dart';
import '../screens/screens.dart';
import '../config/config.dart';


class NavScreen extends StatefulWidget {
  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int _selectedIndexScreen = 0;
  List mainScreen = [
    HomeScreen(),
    ExploreScreen(),
    AddAdvertisingScreen(),
    MessageScreen(),
    AccountScreen(),
  ];
  onTapped(int index) async {
    // if (index == 0) {
      setState(() {
        _selectedIndexScreen = index;
      });
    //   await Provider.of<UserInformation>(context, listen: false).startApp();
    // } else if (Provider.of<UserInformation>(context, listen: false).token != null) {
    //   setState(() {
    //     _selectedIndex = index;
    //   });
    //   if (_selectedIndex == 4) {
    //     Provider.of<Advertisement>(providerContext, listen: false).getData(Provider.of<UserInformation>(providerContext, listen: false).idInDataBase);
    //   }
    // } else {
    //   toastShow(getTranslated(context, "Please SingUp or SingIn"), context);
    // }
  }

  @override
  void initState() {
    setState(() {
      providerContext = context;
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: isLeft ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        endDrawer: CustomEndDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.white,
          backwardsCompatibility: false,
          leadingWidth: 50.0,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsets.zero,
            title: Container(
              padding: isLeft
                  ? EdgeInsets.all(7.0)
                  : EdgeInsets.only(bottom: 1.0, left: 5.0, right: 9.0),
              height: 103.0,
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
                      fontSize: 30.0,
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
                  Expanded(child: SizedBox(width: double.maxFinite)),
                  // Padding(
                  //   padding: isLeft
                  //       ? EdgeInsets.only(bottom: 5.0)
                  //       : EdgeInsets.only(bottom: 10.0),
                  //   child: InkWell(
                  //     child: Icon(
                  //       Icons.notifications_outlined,
                  //       size: 30.0,
                  //       color: Colors.white,
                  //     ),
                  //     onTap: () async {
                  //       AlertDialog aDI = AlertDialog(
                  //         insetPadding: EdgeInsets.symmetric(vertical: 30),
                  //         backgroundColor: Colors.white70.withOpacity(0.1),
                  //         elevation: double.maxFinite,
                  //         contentPadding: EdgeInsets.all(0),
                  //         content: NotificationsScreen(),
                  //       );
                  //       showDialog(
                  //         context: context,
                  //         barrierDismissible: false,
                  //         barrierColor: Colors.black.withOpacity(0.6),
                  //         builder: (context) => aDI,
                  //       );
                  //       print("notifications");
                  //       MyBuildAlertDialog(context, NotificationsScreen());
                  //     },
                  //   ),
                  // ),
                  SizedBox(width: 38.0),
                ],
              ),
            ),
          ),
        ),
        body: mainScreen[_selectedIndexScreen],
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
              onTapped(2);
          },
          shape: _CustomBorder(),
          backgroundColor: _selectedIndexScreen == 2
              ? Colors.lightBlueAccent.withOpacity(0.7)
              : Colors.black12,
          child: CustomPaint(
            child: Icon(
              Icons.add,
              size: 40.0,
              color: Colors.white,
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: Container(
            height: 50.0,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(1.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(2, 2),
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 2,
                  child: columnX(
                    _selectedIndexScreen == 0 ? Icons.home : Icons.home_outlined,
                      isLeft ? "Home": "الرئيسية",
                    0,
                  ),
                ),
                // Expanded(
                //   flex: 2,
                //   child: columnX(
                //     _selectedIndexScreen == 1 ? Icons.explore : Icons.explore_outlined,
                //    isLeft ? "Explore" : "المستكشف",
                //     1,
                //   ),
                // ),
                //Location Floating Action Button
                Expanded(
                  flex: 1,
                  child: SizedBox(width: 1),
                ),
                // Expanded(
                //   flex: 2,
                //   child: columnX(
                //     _selectedIndexScreen == 3 ? Icons.message : Icons.message_outlined,
                //   isLeft ? "Message" : "الرسائل",
                //     3,
                //   ),
                // ),
                Expanded(
                  flex: 2,
                  child: columnX(
                    _selectedIndexScreen == 4 ? Icons.person : Icons.person_outline,
                    isLeft ? "Account": "حسابك",
                    4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  InkWell columnX(iconType, String name, int screenNumber) {
    return InkWell(
      onTap: () => onTapped(screenNumber),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            iconType,
            color: _selectedIndexScreen == screenNumber
                ? Colors.lightBlueAccent
                : Colors.black38,
          ),
          Text(
            name,
            style: TextStyle(
                color: _selectedIndexScreen == screenNumber
                    ? Colors.lightBlueAccent
                    : Colors.black38),
          ),
        ],
      ),
    );
  }
}

class _CustomBorder extends ShapeBorder {
  const _CustomBorder();

  @override
  EdgeInsetsGeometry get dimensions {
    return const EdgeInsets.only();
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    return getOuterPath(rect, textDirection: textDirection);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    return Path()
      ..moveTo(rect.left + rect.width / 2.0, rect.top)
      ..lineTo(rect.right - rect.width / 3, rect.top + rect.height / 3)
      ..lineTo(rect.right, rect.top + rect.height / 2.0)
      ..lineTo(rect.right - rect.width / 3, rect.top + 2 * rect.height / 3)
      ..lineTo(rect.left + rect.width / 2.0, rect.bottom)
      ..lineTo(rect.left + rect.width / 3, rect.top + 2 * rect.height / 3)
      ..lineTo(rect.left, rect.top + rect.height / 2.0)
      ..lineTo(rect.left + rect.width / 3, rect.top + rect.height / 3)
      ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {}

  // This border doesn't support scaling.
  @override
  ShapeBorder scale(double t) {
    return null;
  }
}
