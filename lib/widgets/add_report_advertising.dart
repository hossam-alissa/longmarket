import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/config.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';

class AddReportAdvertising extends StatelessWidget {
  final idAdvertising;
  final idAddedAdvertising;

  AddReportAdvertising({@required this.idAdvertising,@required this.idAddedAdvertising});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: isLeft ? TextDirection.ltr : TextDirection.rtl,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        height: 230.0,
        width: 190.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: Colors.red,width: 3.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isLeft
                  ? '+++'
                  : 'سوف نقوم بمراجة البلاغ نرجو منك بأن لا يكون بلاغ كاذب في حال تم التأكد من صحة بلاغك سوف نقوم بإضافة نقاط شكر إلى حسابك. وشكرا ',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              isLeft
                  ? 'do you want send report ?'
                  : 'هل أنت متأكد من إرسال البلاغ؟',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
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
                            return Colors.redAccent;
                          return Colors.red.withOpacity(0.1); // Use the component's default.
                        },
                      ),
                    ),
                    child: Text(
                      isLeft ? "Yes" : "نعم",
                      style: TextStyle(color: Colors.redAccent,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      try {
                        Provider.of<Advertisement>(providerContext,
                                listen: false)
                            .addReport(
                          idAddedReport: Provider.of<UserInformation>(
                                  providerContext,
                                  listen: false)
                              .idInDataBase,
                          idAdvertising: idAdvertising,
                          comment: "comment",
                            idAddedAdvertising: idAddedAdvertising,
                        );
                        toastShow(
                            isLeft ? "Done Send Report" : "تم إرسال البلاغ",
                            context);
                        Navigator.pop(context);
                      } catch (error) {
                        print(error);
                        toastShow("No add", context);
                      }
                    },
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed))
                              return Colors.white;
                            return Colors.blue.withOpacity(0.1); // Use the component's default.
                          },
                        ),
                      ),
                    child: Text(
                      isLeft ? "No" : "لا",
                      style: TextStyle(color: Colors.black,
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
