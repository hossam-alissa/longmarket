import 'package:flutter/material.dart';
import 'package:longmarket/models/models.dart';
import 'package:provider/provider.dart';
import '../config/config.dart';
import '../widgets/widgets.dart';

class VerifiedEmail extends StatefulWidget {
  @override
  _VerifiedEmailState createState() => _VerifiedEmailState();
}

class _VerifiedEmailState extends State<VerifiedEmail> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: isLeft ? TextDirection.ltr : TextDirection.rtl,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        height: 390.0,
        width: 190.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: Colors.lightBlue, width: 3.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isLeft ? 'Verified email' : "توثيق الحساب",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.grey,
                        blurRadius: 2.0,
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            myDivider(),
            Text(
              isLeft
                  ? '+++'
                  : 'يجب عليك توثيق الحساب لحفظ حسابك ومعلوماتك الشخصية لتفادي إقاف الحساب\nالخطوات: إذا كان حسابك غير موثق قم بتسجيل الخروج والدخول مجددا سوف نقوم بإرسال رسالة توثيق على بريدك الإلكتروني',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              isLeft
                  ? '+++'
                  : 'قم بفتح رابط التوثيق داخل الرسالة',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            myDivider(),
            SizedBox(height: 10.0),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed))
                            return Colors.white;
                          return Colors.white
                              .withOpacity(0.7); // Use the component's default.
                        },
                      ),
                    ),
                    child: Text(
                      isLeft ? "Back" : "رجوع",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
