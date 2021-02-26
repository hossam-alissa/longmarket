// import 'dart:convert';
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;

class UserInformation with ChangeNotifier {
  String idInDataBase;
  String email;
  String _passwordUserName;
  String username;
  String mobileNumber;
  String firstName;
  String secondName;
  String lastName;
  String city;
  String _token;
  DateTime _expiryDate;

  DateTime get dateExp {
    return _expiryDate;
  }

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    } else
      return null;
  }

  Future<void> singUpInDataBase({
    @required String email,
    @required String passwordUser,
  }) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: passwordUser,
      );

      // Firebase.initializeApp();
      // final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
      //   email: 'an email',
      //   password: 'a password',
      // ))
      //     .user;
      // await FirebaseFirestore.instance.collection('/Users').add(
      //   {
      //     'uid': _res.user.uid,
      //     'email': email.toString(),
      //     'username': username.toString(),
      //     'mobileNumber': mobileNumber.toString(),
      //     'firstName': firstName.toString(),
      //     'secondName': secondName.toString(),
      //     'lastName': lastName,
      //     'city': city,
      //
      //   },
      // );
      // print('++++++++++++');
      // print(json.decode(res.body)['name']);
      // var _res = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: passwordUser);

      // try {
      //   userCredential.user.sendEmailVerification();
      //   print("+++++ +++++ Done in user information sendEmailVerification");
      // } catch (error) {
      //   print("+++++ +++++ error in user information sendEmailVerification");
      //   print(error);
      // }

      // print(_res.user.getIdToken().then((value) => (value.token.toString())));
      print(await userCredential.user.getIdToken());

      this.idInDataBase = userCredential.user.uid;
      this.email = email;
      this._passwordUserName = passwordUser;
      this.username = "New User";
      this.mobileNumber = '0000000000';
      this.firstName = "New User F";
      this.secondName = 'New User S';
      this.lastName = 'New User L';
      this.city = "New User city";
      this._token = await userCredential.user.getIdToken();
      this._expiryDate =
          DateTime.now().add(Duration(seconds: int.parse("3600")));

      // ((await _res.user.getIdToken().then((value) => (value.token))).toString());

      SharedPreferences _userInfoInSharedPref =
          await SharedPreferences.getInstance();
      _userInfoInSharedPref.setString('idInDataBase', idInDataBase);
      _userInfoInSharedPref.setString('email', email);
      _userInfoInSharedPref.setString('passwordUser', _passwordUserName);
      _userInfoInSharedPref.setString('username', username);
      _userInfoInSharedPref.setString('mobileNumber', mobileNumber);
      _userInfoInSharedPref.setString('firstName', firstName);
      _userInfoInSharedPref.setString('secondName', secondName);
      _userInfoInSharedPref.setString('lastName', lastName);
      _userInfoInSharedPref.setString('city', city);
      _userInfoInSharedPref.setString('Token', _token);
      _userInfoInSharedPref.setString(
          'expiryDate', _expiryDate.toIso8601String());
      notifyListeners();
      print('+++++ +++++  Done SingUp');
    } catch (error) {
      print('+++++ +++++  Error SingUp');
      print(error);
      throw error;
    }
  }

  Future<void> singInInDataBase(
      {@required String emailUserName, @required String passwordUser}) async {
    try {
      // await Firebase.initializeApp();
      // var _res = await FirebaseAuth.instance.signInWithEmailAndPassword(
      //   email: emailUserName,
      //   password: passwordUser,
      // );
      // final _auth = FirebaseAuth.instance;
      // final  AuthResult user = ( await _auth.signInWithEmailAndPassword( email: emailUserName, password: passwordUser));
      // final FirebaseUser currentUser = await _auth.currentUser();
      //
      // assert(user.user.uid == currentUser.uid);
      // currentUser.getIdToken().then((id){
      //   print(  id.token);
      // }) ;

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailUserName,
        password: passwordUser,
      );

      try {
        // final String url = 'https://long-market-default-rtdb.firebaseio.com/users.json';
        // final http.Response res = await http.get(url);
        // final Map<String, dynamic> extractedData = json.decode(res.body) as Map<String, dynamic>;
        // extractedData.forEach((idDatabase, value) {
        //   if (value['uid'] == _res.user.uid) {
        //     this.idInDataBase = value['uid'];
        //     this.email = value['email'];
        //     this._passwordUserName = passwordUser;
        //     this.username = value['username'];
        //     this.mobileNumber = value['mobileNumber'];
        //     this.firstName = value['firstName'];
        //     this.secondName = value['secondName'];
        //     this.lastName = value['lastName'];
        //     this.city = value['city'];
        //   }
        // });
        this._token = await userCredential.user.getIdToken();
        print(_token);
        this._expiryDate = DateTime.now().add(Duration(seconds: int.parse("3600")));
        SharedPreferences _userInfoInSharedPref =
            await SharedPreferences.getInstance();
        _userInfoInSharedPref.setString('idInDataBase', idInDataBase);
        _userInfoInSharedPref.setString('email', email);
        _userInfoInSharedPref.setString('passwordUser', _passwordUserName);
        _userInfoInSharedPref.setString('username', username);
        _userInfoInSharedPref.setString('mobileNumber', mobileNumber);
        _userInfoInSharedPref.setString('firstName', firstName);
        _userInfoInSharedPref.setString('secondName', secondName);
        _userInfoInSharedPref.setString('lastName', lastName);
        _userInfoInSharedPref.setString('city', city);
        _userInfoInSharedPref.setString('Token', _token);
        _userInfoInSharedPref.setString(
            'expiryDate', _expiryDate.toIso8601String());
      } catch (e) {
        print(e);
        throw e;
      }
      notifyListeners();
      print('+++++ +++++  Done SingIn');
    } catch (error) {
      print('+++++ +++++  Error SingIn');
      print(error);
      throw error;
    }
  }

  Future<void> startApp() async {
    SharedPreferences _userInfoInSharedPref =
        await SharedPreferences.getInstance();
    try {
      if (_userInfoInSharedPref.getString('expiryDate').isNotEmpty) {
        try {
          idInDataBase = _userInfoInSharedPref.getString('idInDataBase');
          email = _userInfoInSharedPref.getString('email');
          _passwordUserName = _userInfoInSharedPref.getString('passwordUser');
          username = _userInfoInSharedPref.getString('username');
          mobileNumber = _userInfoInSharedPref.getString('mobileNumber');
          firstName = _userInfoInSharedPref.getString('firstName');
          secondName = _userInfoInSharedPref.getString('secondName');
          lastName = _userInfoInSharedPref.getString('lastName');
          city = _userInfoInSharedPref.getString('city');
          _token = _userInfoInSharedPref.getString('Token');
          _expiryDate =
              DateTime.tryParse(_userInfoInSharedPref.getString('expiryDate'));

          if (_expiryDate.isBefore(DateTime.now())) {
            print(_passwordUserName);
            UserCredential userCredential = await FirebaseAuth.instance
                .signInWithEmailAndPassword(
                    email: email, password: _passwordUserName);

            this._token = await userCredential.user.getIdToken();
            this._expiryDate =
                DateTime.now().add(Duration(seconds: int.parse("3600")));
            _userInfoInSharedPref.setString('Token', _token);
            _userInfoInSharedPref.setString(
                'expiryDate', _expiryDate.toIso8601String());
          }
          notifyListeners();
          print('+++++ +++++ Done Start App');
        } catch (error) {
          print('+++++ +++++  Error Start App');
          print(error);
          throw error;
        }
      }
    } catch (errorSharedPref) {
      print("+++ user information expiry date empty");
      // print(errorSharedPref.toString());
    }
  }

  logOutUserInformation() async {
    try {
      await FirebaseAuth.instance.signOut();
      idInDataBase = null;
      email = null;
      _passwordUserName = null;
      username = null;
      mobileNumber = null;
      firstName = null;
      secondName = null;
      lastName = null;
      city = null;
      _token = null;
      _expiryDate = null;

      SharedPreferences _userInfoInSharedPref =
          await SharedPreferences.getInstance();
      _userInfoInSharedPref.clear();
    } catch (e) {
      throw e;
    }
    notifyListeners();
  }

// Future<Map<String, String>> getAllUserInformation() async {
//   SharedPreferences _userInfoInSharedPref = await SharedPreferences.getInstance();
//   Map<String, String> userInfoList = {
//     'idInDataBase': (_userInfoInSharedPref.getString('idInDataBase') == null
//             ? ""
//             : _userInfoInSharedPref.getString('idInDataBase'))
//         .toString(),
//     'email': (_userInfoInSharedPref.getString('email') == null
//         ? ""
//         : _userInfoInSharedPref.getString('email').toString()),
//     'username': (_userInfoInSharedPref.getString('username') == null
//             ? ""
//             : _userInfoInSharedPref.getString('username'))
//         .toString(),
//     'mobileNumber': (_userInfoInSharedPref.getString('mobileNumber') == null
//             ? ""
//             : _userInfoInSharedPref.getString('mobileNumber'))
//         .toString(),
//     'firstName': (_userInfoInSharedPref.getString('firstName') == null
//             ? ""
//             : _userInfoInSharedPref.getString('firstName'))
//         .toString(),
//     'secondName': (_userInfoInSharedPref.getString('secondName') == null
//             ? ""
//             : _userInfoInSharedPref.getString('secondName'))
//         .toString(),
//     'lastName': (_userInfoInSharedPref.getString('lastName') == null
//             ? ""
//             : _userInfoInSharedPref.getString('lastName'))
//         .toString(),
//     'city': (_userInfoInSharedPref.getString('city') == null
//             ? ""
//             : _userInfoInSharedPref.getString('city'))
//         .toString(),
//   };
//   notifyListeners();
//   return userInfoList;
// }
  resetPassword({@required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      print('+++++ +++++  Done user Information resetPassword');
    } catch (error) {
      print('+++++ +++++  Error user Information resetPassword');
      print(error);
      throw error;
    }
    notifyListeners();
  }
}
