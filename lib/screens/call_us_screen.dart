import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class CallUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyBuildAlertDialog(
      context,
      SingleChildScrollView(
        child: Container(
          height: double.maxFinite,
        ),
      ),
    );
  }
}
