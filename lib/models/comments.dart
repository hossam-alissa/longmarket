import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/config.dart';
import 'models.dart';

class Comment {
  final String idComment;
  final String idAdvertising;
  final String userIdAddedComment;
  final String textComment;
  final String userNameAddedAdvertising;
  final String dateAdded;

  Comment(
      {@required this.idComment,
      @required this.userIdAddedComment,
      @required this.idAdvertising,
      @required this.textComment,
      @required this.userNameAddedAdvertising,
      @required this.dateAdded});
}

class Comments with ChangeNotifier {
  String authToken;
  List<Comment> commentList = [];
  List<Comment> commentNotificationList = [];

  getDataAuthToken({@required String authToken}) {
    this.authToken = authToken;
    notifyListeners();
  }

  setNumberOfComments(int numberOfComments) async {
    SharedPreferences _notification = await SharedPreferences.getInstance();
    try {
      await _notification.setInt("numberOfComments", numberOfComments);
    } catch (e) {
      print("+++ +++ error set Number Of Comments");
      print(e);
    }
  }

  getNumberOfComments() async {
    SharedPreferences _notification = await SharedPreferences.getInstance();
    int numberOfComments = 0;
    try {
      if (await _notification.getInt("numberOfComments") != null)
        numberOfComments = await _notification.getInt("numberOfComments");
    } catch (e) {
      print("+++ +++ error get Number Of Comments");
      print(e);
    }
    return numberOfComments;
  }

  Future<void> commentsNotification(
      List<Advertising> listAdvertisingForUser) async {
    final String url =
        'https://long-market-default-rtdb.firebaseio.com/comments.json';
    try {
      final http.Response res = await http.get(Uri.parse(url));
      final Map<String, dynamic> extractedData =
          json.decode(res.body) as Map<String, dynamic>;
      listAdvertisingForUser.forEach((advertising) {
        extractedData.forEach((idComment, value) {
          if (value['idAdvertising'] == advertising.idAdvertising) {
            final commentIndex = commentNotificationList
                .indexWhere((element) => element.idComment == idComment);
            if (commentIndex >= 0) {
              commentNotificationList[commentIndex] = Comment(
                idComment: idComment,
                userIdAddedComment: value['userIdAddedComment'],
                idAdvertising: value['idAdvertising'],
                textComment: value['textComment'],
                userNameAddedAdvertising: value['userNameAddedAdvertising'],
                dateAdded: value['dateAdded'],
              );
            } else {
              commentNotificationList.add(
                Comment(
                  idComment: idComment,
                  userIdAddedComment: value['userIdAddedComment'],
                  idAdvertising: value['idAdvertising'],
                  textComment: value['textComment'],
                  userNameAddedAdvertising: value['userNameAddedAdvertising'],
                  dateAdded: value['dateAdded'],
                ),
              );
            }
          }
        });
      });

      commentNotificationList
          .sort((a, b) => b.dateAdded.compareTo(a.dateAdded));

      if (commentNotificationList.length > await getNumberOfComments()) {
        Provider.of<UserInformation>(providerContext, listen: false)
            .notification = true;
        print("+++ +++ commentNotificationList" +
            commentNotificationList.length.toString());
      }
      notifyListeners();
    } catch (error) {
      print(error);
      throw (error);
    }
  }

  Future<void> fetchData({@required String idAdvertising}) async {
    commentList.clear();
    final String url =
        'https://long-market-default-rtdb.firebaseio.com/comments.json';
    try {
      final http.Response res = await http.get(Uri.parse(url));
      final Map<String, dynamic> extractedData =
          json.decode(res.body) as Map<String, dynamic>;

      // commentList.removeWhere((element) => element.idAdvertising != idAdvertising);

      extractedData.forEach((idComment, value) {
        if (value['idAdvertising'] == idAdvertising) {
          final commentIndex = commentList
              .indexWhere((element) => element.idComment == idComment);
          if (commentIndex >= 0) {
            commentList[commentIndex] = Comment(
              idComment: idComment,
              userIdAddedComment: value['userIdAddedComment'],
              idAdvertising: value['idAdvertising'],
              textComment: value['textComment'],
              userNameAddedAdvertising: value['userNameAddedAdvertising'],
              dateAdded: value['dateAdded'],
            );
          } else {
            commentList.insert(
                0,
                Comment(
                  idComment: idComment,
                  userIdAddedComment: value['userIdAddedComment'],
                  idAdvertising: value['idAdvertising'],
                  textComment: value['textComment'],
                  userNameAddedAdvertising: value['userNameAddedAdvertising'],
                  dateAdded: value['dateAdded'],
                ));
          }
        }
      });
      notifyListeners();
    } catch (error) {
      print(error);
      throw (error);
    }
  }

  Future<void> add(
      {@required String idAdvertising,
      @required String userIdAddedComment,
      @required String textComment,
      @required String userNameAddedAdvertising}) async {
    final String url =
        'https://long-market-default-rtdb.firebaseio.com/comments.json?auth=$authToken';
    try {
      http.Response res = await http.post(Uri.parse(url),
          body: json.encode({
            'idAdvertising': idAdvertising.toString(),
            'userIdAddedComment': userIdAddedComment.toString(),
            'textComment': textComment.toString(),
            'userNameAddedAdvertising': userNameAddedAdvertising.toString(),
            'dateAdded': DateTime.now().toIso8601String(),
          }));

      if (json.decode(res.body)['name'] != null) {
        // print(json.decode(res.body)['name']);
        commentList.insert(
            0,
            Comment(
              idComment: json.decode(res.body)['name'],
              userIdAddedComment: userIdAddedComment,
              idAdvertising: idAdvertising,
              textComment: textComment,
              userNameAddedAdvertising: userNameAddedAdvertising,
              dateAdded: DateTime.now().toIso8601String(),
            ));
        notifyListeners();
      }
      notifyListeners();
      print("+++ Done Added Comment");
    } catch (error) {
      print("+++ Error in Added Comment" + error.toString());
      throw (error);
    }
  }

  Future<void> upDateData(
      {@required String idComment,
      @required String idAdvertising,
      @required String userIdAddedComment,
      @required String textComment}) async {
    final String url =
        'https://long-market-default-rtdb.firebaseio.com/comments/$idComment.json?auth=$authToken';
    final commentIndex =
        commentList.indexWhere((element) => element.idComment == idComment);

    if (commentIndex >= 0) {
      try {
        await http.patch(Uri.parse(url),
            body: json.encode({
              'idAdvertising': idAdvertising.toString(),
              'userIdAddedComment': userIdAddedComment.toString(),
              'textComment': textComment.toString(),
            }));
        commentList[commentIndex] = Comment(
          idComment: idComment,
          userIdAddedComment: userIdAddedComment,
          idAdvertising: idAdvertising,
          textComment: textComment,
          userNameAddedAdvertising: userIdAddedComment,
          dateAdded: DateTime.now().toIso8601String(),
        );
        notifyListeners();
      } catch (error) {
        throw (error);
      }
    } else {
      print("not update");
    }
  }

  Future<void> deleteComment({@required String idComment}) async {
    final String url =
        'https://long-market-default-rtdb.firebaseio.com/comments/$idComment.json?auth=$authToken';
    var commentIndex =
        commentList.indexWhere((element) => element.idComment == idComment);
    var commentItem = commentList[commentIndex];
    commentList.removeAt(commentIndex);
    notifyListeners();

    try {
      var _res = await http.delete(Uri.parse(url));
      if (_res.statusCode >= 400) {
        print('not deleted');
        commentList.insert(commentIndex, commentItem);
        notifyListeners();
      } else {
        print('Done deleted');
        commentItem = null;
      }
      notifyListeners();
    } catch (error) {
      print('delete comment catch');
      throw error;
    }
  }

  double sizeContainerBox() {
    if (commentList.length == 1) return 63.0;
    if (commentList.length == 2) return 127.0;
    if (commentList.length == 3) return 190.0;
    if (commentList.length >= 4)
      return 255.0;
    else
      return 0.0;
  }
}
