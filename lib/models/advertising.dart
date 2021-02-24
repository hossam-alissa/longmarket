import 'dart:convert';

// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Advertising {
  String idAdvertising;
  String idAddedAdvertising;
  String title;
  String details;
  String city;
  String department;
  String category;
  String date;
  String imgUrl;
  String userNameAddedAdvertising;
  String mobileNumber;

  Advertising({
    @required this.idAdvertising,
    @required this.idAddedAdvertising,
    @required this.title,
    @required this.details,
    @required this.city,
    @required this.department,
    @required this.category,
    @required this.date,
    @required this.imgUrl,
    @required this.userNameAddedAdvertising,
    @required this.mobileNumber,
  });
}

class Advertisement with ChangeNotifier {
  String authToken;
  List<Advertising> listAdvertising = [];
  List<Advertising> listAdvertisingForUser = [];

  void getData(String userID) {
    listAdvertisingForUser.clear();
    listAdvertising.forEach((element) {
      if (element.idAddedAdvertising == userID) {
        listAdvertisingForUser.add(element);
      }
    });
  }

  getListAdvertisingBySort(String sortEN, String sortAR) {
    List<Advertising> listAdvertisingBySort = [];
    listAdvertising.forEach((element) {
      if (element.department == sortEN || element.department == sortAR) {
        listAdvertisingBySort.add(element);
      }
    });

    return listAdvertisingBySort;
  }

  getDataAuthToken({@required String authToken}) {
    this.authToken = authToken;
    notifyListeners();
  }

  fetchData() async {
    final String url =
        'https://long-market-default-rtdb.firebaseio.com/advertising.json';
    try {
      http.Response res = await http.get(url);
      final Map<String, dynamic> extractedData =
          json.decode(res.body) as Map<String, dynamic>;
      extractedData.forEach((idAdvertising, value) {
        if (value['imgUrl'] != '') {
          final advertisingIndex = listAdvertising
              .indexWhere((element) => element.idAdvertising == idAdvertising);
          if (advertisingIndex >= 0) {
            listAdvertising[advertisingIndex] = Advertising(
              idAdvertising: idAdvertising,
              idAddedAdvertising: value['idAddedAdvertising'],
              title: value['title'],
              details: value['details'],
              city: value['city'],
              department: value['department'],
              category: value['category'],
              date: value['date'],
              imgUrl: value['imgUrl'],
              userNameAddedAdvertising: value['userNameAddedAdvertising'],
              mobileNumber: value['mobileNumber'],
            );
          } else {
            listAdvertising.insert(
                0,
                Advertising(
                  idAdvertising: idAdvertising,
                  idAddedAdvertising: value['idAddedAdvertising'],
                  title: value['title'],
                  details: value['details'],
                  city: value['city'],
                  department: value['department'],
                  category: value['category'],
                  date: value['date'],
                  imgUrl: value['imgUrl'],
                  userNameAddedAdvertising: value['userNameAddedAdvertising'],
                  mobileNumber: value['mobileNumber'],
                ));
          }
        }
      });
      notifyListeners();
      print('Done fetch data');
    } catch (error) {
      print("+++++ +++++ error in fetch Data advertising models");
      print(error);
      throw error;
    }
  }

  // void addAdvertising({
  //   @required String idAddedAdvertising,
  //   @required String title,
  //   @required String details,
  //   @required String city,
  //   @required String department,
  //   @required String category,
  //   @required String date,
  //   @required var imageFile,
  //   @required String userNameAddedAdvertising,
  //   @required String mobileNumber,
  // }) async {
  //   try {
  //     final String url =
  //         'https://long-market-default-rtdb.firebaseio.com/advertising.json?auth=$authToken';
  //     http.Response res = await http.post(
  //       url,
  //       body: jsonEncode(
  //         {
  //           'idAddedAdvertising': idAddedAdvertising.toString(),
  //           'title': title.toString(),
  //           'details': details.toString(),
  //           'city': city.toString(),
  //           'department': department.toString(),
  //           'category': category.toString(),
  //           'date': date.toString(),
  //           'imgUrl': '',
  //           'userNameAddedAdvertising': userNameAddedAdvertising.toString(),
  //           'mobileNumber': mobileNumber.toString(),
  //         },
  //       ),
  //     );
  //     StorageReference refImage = FirebaseStorage.instance
  //         .ref()
  //         .child('advertisingPhoto')
  //         .child('${json.decode(res.body)['name']}.jpg');
  //     StorageUploadTask x = refImage.putFile(imageFile);
  //     String newUrlImage =
  //         (await (await x.onComplete).ref.getDownloadURL()).toString();
  //
  //     try {
  //       final String urlUpdate =
  //           'https://long-market-default-rtdb.firebaseio.com/advertising/${json.decode(res.body)['name']}.json?auth=$authToken';
  //       await http.patch(urlUpdate,
  //           body: json.encode({
  //             'imgUrl': newUrlImage.toString(),
  //           }));
  //       print("+++++ +++++ Done upData url Image");
  //     } catch (ee) {
  //       print("+++++ +++++ Error upData url Image");
  //       print(ee);
  //     }
  //
  //     if (json.decode(res.body)['name'] != null) {
  //       listAdvertising.insert(
  //           0,
  //           Advertising(
  //             idAdvertising: json.decode(res.body)['name'],
  //             idAddedAdvertising: idAddedAdvertising,
  //             title: title,
  //             details: details,
  //             city: city,
  //             department: department,
  //             category: category,
  //             date: date,
  //             imgUrl: newUrlImage,
  //             userNameAddedAdvertising: userNameAddedAdvertising,
  //             mobileNumber: mobileNumber,
  //           ));
  //       listAdvertisingForUser.insert(0,
  //           Advertising(
  //         idAdvertising: json.decode(res.body)['name'],
  //         idAddedAdvertising: idAddedAdvertising,
  //         title: title,
  //         details: details,
  //         city: city,
  //         department: department,
  //         category: category,
  //         date: date,
  //         imgUrl: newUrlImage,
  //         userNameAddedAdvertising: userNameAddedAdvertising,
  //         mobileNumber: mobileNumber),);
  //     }
  //     notifyListeners();
  //     print("+++++ +++++ Done in Add Advertising models");
  //   } catch (error) {
  //     print("+++++ +++++ Error in Add Advertising models");
  //     print(error);
  //     throw error;
  //   }
  // }

  Future<Advertising> getDataAdvertising(
      {@required String idAdvertising}) async {
    return listAdvertising
        .firstWhere((element) => element.idAdvertising == idAdvertising);
  }

  void addReport(
      {@required String idAddedReport,
      @required String idAdvertising,
      @required String comment}) async {
    final String url =
        'https://long-market-default-rtdb.firebaseio.com/reports.json?auth=$authToken';
    try {
      await http.post(url,
          body: json.encode({
            "idUserAddedReport": idAddedReport,
            'idAdvertising': idAdvertising.toString(),
            "comment": comment,
          }));
      print("+++++ +++++ Done in advertising Add Report");
    } catch (error) {
      print("+++++ +++++ Error in advertising Add Report ");
      print(error);
      throw (error);
    }
  }
}
