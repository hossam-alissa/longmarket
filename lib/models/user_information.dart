import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  bool validation;
  String _token;
  DateTime _expiryDate;
  bool notification = false;

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

      // UserCredential userCredentialPhoneNumber =
      // await FirebaseAuth.instance.

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

      try {
        userCredential.user.sendEmailVerification();
        print("+++++ +++++ Done in user information sendEmailVerification");
      } catch (error) {
        print("+++++ +++++ error in user information sendEmailVerification");
        print(error);
        throw error;
      }

      this.idInDataBase = userCredential.user.uid;
      this.email = email;
      this._passwordUserName = passwordUser;
      this.username = email;
      this.mobileNumber = '0000000000';
      this.firstName = "New User F";
      this.secondName = 'New User S';
      this.lastName = 'New User L';
      this.city = "New User City";
      this.validation = false;
      this._token = await userCredential.user.getIdToken();
      this._expiryDate =
          DateTime.now().add(Duration(seconds: int.parse("3600")));

      try {
        await FirebaseFirestore.instance
            .collection('/Users')
            .doc(userCredential.user.uid.toString())
            .set(
          {
            'email': email.toString(),
            'userName': username.toString(),
            'mobileNumber': mobileNumber.toString(),
            'firstName': firstName.toString(),
            'secondName': secondName.toString(),
            'lastName': lastName,
            'city': city,
          },
        );

        notifyListeners();
        print("+++ Done Edit user Information");
      } catch (error) {
        print("+++ Error Edit user Information" + error.toString());
        throw (error);
      }

      SharedPreferences _userInfoInSharedPref =
          await SharedPreferences.getInstance();
      await _userInfoInSharedPref.setString('idInDataBase', idInDataBase);
      await _userInfoInSharedPref.setString('email', email);
      await _userInfoInSharedPref.setString('passwordUser', _passwordUserName);
      await _userInfoInSharedPref.setString('username', username);
      await _userInfoInSharedPref.setString('mobileNumber', mobileNumber);
      await _userInfoInSharedPref.setString('firstName', firstName);
      await _userInfoInSharedPref.setString('secondName', secondName);
      await _userInfoInSharedPref.setString('lastName', lastName);
      await _userInfoInSharedPref.setBool("validation", validation);
      await _userInfoInSharedPref.setString('city', city);
      await _userInfoInSharedPref.setString('Token', _token);
      await _userInfoInSharedPref.setString(
          'expiryDate', _expiryDate.toIso8601String());
      notifyListeners();
      print('+++++ +++++  Done SingUp');
    } catch (error) {
      print('+++++ +++++  Error SingUp');
      print(error);
      throw error;
    }
  } //End Sing UP

  Future<void> singInInDataBase(
      {@required String emailUserName, @required String passwordUser}) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailUserName,
        password: passwordUser,
      );
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

      if (userCredential.user.emailVerified == false) {
        try {
          userCredential.user.sendEmailVerification();
          print("+++++ +++++ Done in user information sendEmailVerification");
        } catch (error) {
          print("+++++ +++++ error in user information sendEmailVerification");
          print(error);
          throw error;
        }
      }

      try {
        //
        // final String url = 'https://long-market-default-rtdb.firebaseio.com/users.json';
        // final http.Response _res = await http.get(Uri.parse(url));
        // final Map<String, dynamic> extractedData = json.decode(_res.body) as Map<String, dynamic>;
        // extractedData.forEach((idDatabase, value) {
        //   if (value['uid'] == userCredential.user.uid) {
        //     this.uidUserInformation = idDatabase;
        //     this.idInDataBase = value['uid'];
        //     this.username = value['userName'];
        //     this.mobileNumber = value['mobileNumber'];
        //     this.firstName = value['firstName'];
        //     this.secondName = value['secondName'];
        //     this.lastName = value['lastName'];
        //     this.city = value['city'];
        //   }
        // });

        print(userCredential.user.uid);
        var userInformation = await FirebaseFirestore.instance
            .collection("/Users")
            .doc(userCredential.user.uid)
            .get();

        // print(x.data());

        this.idInDataBase = userCredential.user.uid;
        this.username = userInformation.data()['userName'].toString();
        this.mobileNumber = userInformation.data()['mobileNumber'].toString();
        this.firstName = userInformation.data()['firstName'].toString();
        this.secondName = userInformation.data()['secondName'].toString();
        this.lastName = userInformation.data()['lastName'].toString();
        this.city = userInformation.data()['city'];

        this.idInDataBase = userCredential.user.uid;
        this.email = emailUserName;
        this._passwordUserName = passwordUser;
        this.validation = userCredential.user.emailVerified;
        this._token = await userCredential.user.getIdToken();
        this._expiryDate =
            DateTime.now().add(Duration(seconds: int.parse("3600")));
        SharedPreferences _userInfoInSharedPref =
            await SharedPreferences.getInstance();
        await _userInfoInSharedPref.setString('idInDataBase', idInDataBase);
        await _userInfoInSharedPref.setString('email', email);
        await _userInfoInSharedPref.setString(
            'passwordUser', _passwordUserName);
        await _userInfoInSharedPref.setString('username', username);
        await _userInfoInSharedPref.setString('mobileNumber', mobileNumber);
        await _userInfoInSharedPref.setString('firstName', firstName);
        await _userInfoInSharedPref.setString('secondName', secondName);
        await _userInfoInSharedPref.setString('lastName', lastName);
        await _userInfoInSharedPref.setString('city', city);
        await _userInfoInSharedPref.setBool("validation", validation);
        await _userInfoInSharedPref.setString('Token', _token);
        await _userInfoInSharedPref.setString(
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
  } //End Sing In

  Future<void> editInformation({
    @required String idInDataBase,
    @required String userName,
    @required String mobileNumber,
    @required String firstName,
    @required String secondName,
    @required String lastName,
    @required String city,
  }) async {
    // final String url = 'https://long-market-default-rtdb.firebaseio.com/users/$uidUserInformation.json?auth=$_token';
    try {
      // await http.patch(Uri.parse(url),
      //         body: json.encode({
      //           'userName': userName,
      //           'mobileNumber': mobileNumber,
      //           'firstName': firstName,
      //           'secondName': secondName,
      //           'lastName': lastName,
      //           'city': city,
      //         }));

      await FirebaseFirestore.instance
          .collection('/Users')
          .doc(idInDataBase)
          .set(
        {
          'email': email.toString(),
          'userName': userName.toString(),
          'mobileNumber': mobileNumber.toString(),
          'firstName': firstName.toString(),
          'secondName': secondName.toString(),
          'lastName': lastName,
          'city': city,
        },
      );

      this.username = userName;
      this.mobileNumber = mobileNumber;
      this.firstName = firstName;
      this.secondName = secondName;
      this.lastName = lastName;
      this.city = city;

      SharedPreferences _userInfoInSharedPref = await SharedPreferences.getInstance();
      await _userInfoInSharedPref.setString('username', userName);
      await _userInfoInSharedPref.setString('mobileNumber', mobileNumber);
      await _userInfoInSharedPref.setString('firstName', firstName);
      await _userInfoInSharedPref.setString('secondName', secondName);
      await _userInfoInSharedPref.setString('lastName', lastName);
      await _userInfoInSharedPref.setString('city', city);

      // http.Response res = await http.post(url,
      //     body: json.encode({
      //       'idInDataBase': idInDataBase,
      //       'userName': userName,
      //       'mobileNumber': mobileNumber,
      //       'firstName': firstName,
      //       'secondName': secondName,
      //       'lastName': lastName,
      //       'city': city,
      //     }));
      //
      // if (json.decode(res.body)['name'] != null) {
      //   print(json.decode(res.body)['name']);
      //
      // }
      notifyListeners();
      print("+++ Done Edit user Information");
    } catch (error) {
      print("+++ Error Edit user Information" + error.toString());
      throw (error);
    }
  }

  Future<void> startApp() async {
    SharedPreferences _userInfoInSharedPref =
        await SharedPreferences.getInstance();
    try {
      if (await _userInfoInSharedPref.getString('expiryDate').isNotEmpty) {
        try {
          idInDataBase = await _userInfoInSharedPref.getString('idInDataBase');
          email = await _userInfoInSharedPref.getString('email');
          _passwordUserName =
              await _userInfoInSharedPref.getString('passwordUser');
          username = await _userInfoInSharedPref.getString('username');
          mobileNumber = await _userInfoInSharedPref.getString('mobileNumber');
          firstName = await _userInfoInSharedPref.getString('firstName');
          secondName = await _userInfoInSharedPref.getString('secondName');
          lastName = await _userInfoInSharedPref.getString('lastName');
          city = await _userInfoInSharedPref.getString('city');
          validation = await _userInfoInSharedPref.getBool("validation");
          _token = await _userInfoInSharedPref.getString('Token');
          _expiryDate = DateTime.tryParse(
              await _userInfoInSharedPref.getString('expiryDate'));

          if (_expiryDate.isBefore(DateTime.now())) {
            print(_passwordUserName);
            UserCredential userCredential = await FirebaseAuth.instance
                .signInWithEmailAndPassword(
                    email: email, password: _passwordUserName);

            this._token = await userCredential.user.getIdToken();
            this._expiryDate =
                DateTime.now().add(Duration(seconds: int.parse("3600")));
            await _userInfoInSharedPref.setString('Token', _token);
            await _userInfoInSharedPref.setString(
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
      print(errorSharedPref.toString());
    }
  } //End Start App

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
      validation = null;

      SharedPreferences _userInfoInSharedPref =
          await SharedPreferences.getInstance();
      await _userInfoInSharedPref.clear();
    } catch (e) {
      throw e;
    }
    notifyListeners();
  } //ِend Log OUT

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
