import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:longmarket/config/config.dart';
import 'package:longmarket/helper/helper.dart';
import 'package:longmarket/models/models.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';

class ChatScreen extends StatefulWidget {
  final uidUserNameSend;
  final uidUserNameReceive;
  final otherUserName;

  ChatScreen({
    @required this.uidUserNameSend,
    @required this.uidUserNameReceive,
    @required this.otherUserName,
  });

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String chatRoomId;
  String messageId = "";
  Stream messageStream;
  String myName, myUserName, myEmail;
  TextEditingController messageTextEditingController = TextEditingController();

  Widget chatMessageTitle(String message, bool sendByMy,var ts) {
    return Row(
      mainAxisAlignment: sendByMy ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 4.0),
         width: MediaQuery.of(context).size.width - 60.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0),
              bottomRight:isLeft ?  sendByMy ? Radius.circular(0.0):Radius.circular(25.0) : sendByMy ? Radius.circular(25.0):Radius.circular(.0),
              topRight: Radius.circular(25.0),
              bottomLeft:isLeft ?  sendByMy ? Radius.circular(25.0):Radius.circular(0.0): sendByMy ? Radius.circular(0.0):Radius.circular(25.0),
            ),
            color: Colors.lightBlue[600],
          ),
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                flex: 8,
                child: Text(
                  message,
                  style: TextStyle(color: Colors.white),
                  overflow: TextOverflow.visible,
                ),
              ),
              SizedBox(width: 8.0),
              Expanded(
                flex: 1,
                  child: Text(TimeAgo.timeAgoSinceDate(ts.toString()))),
            ],
          ),
        ),
      ],
    );
  }

  Widget chatMessages() {
    return StreamBuilder(
        stream: messageStream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
              padding: EdgeInsets.only(bottom: 14.0),
              reverse: true,
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.docs[index];
                return chatMessageTitle(ds["message"].toString(),
                    Provider.of<UserInformation>(providerContext,listen: false).idInDataBase == ds["sendBy"].toString(),
                  ds["ts"],
                );
              })
              : Center(child: CircularProgressIndicator());
        });
  }

  getMyInfoFromSharedPreferences() async {
    // myName = await SharedPreferenceHelper().getDisplayName();
    // myProfilePic = await SharedPreferenceHelper().getUserProfilePicKey();
    // myUserName = await SharedPreferenceHelper().getUserName();
    // myEmail = await SharedPreferenceHelper().getUserEmail();

    chatRoomId = getChatRoomIdByUserNames(widget.uidUserNameSend, widget.uidUserNameReceive);
  }

  getChatRoomIdByUserNames(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  addMessage(bool sendClicked) async {
    if (messageTextEditingController.text != "") {
      String message = messageTextEditingController.text;
      var lastMessageTs = DateTime.now().toIso8601String();

      Map<String, dynamic> messageInfoMap = {
        "message": message,
        "sendBy": Provider.of<UserInformation>(providerContext,listen: false).idInDataBase,
        "ts": lastMessageTs,
      };

      if (messageId == "") {
        messageId = randomAlphaNumeric(12);
      }

      await ChatMessageDataBase()
          .addMessage(chatRoomId, messageId, messageInfoMap)
          .then((value) {
        Map<String, dynamic> lastMessageInfoMap = {
          "lastMessage": message,
          "lastMessageSendBy": myUserName,
          "lastMessageSendTs": lastMessageTs,
        };
        // ChatMessage().updateLastMessageSend(chatRoomId, lastMessageInfoMap);
        if (sendClicked) {
          messageTextEditingController.text = "";
          messageId = "";
        }
      });
    }
  }

  getAndSetMessage() async {
    messageStream = await ChatMessageDataBase().getChatRoomMessages(chatRoomId);
    setState(() {});
  }

  doThisOnLaunch() async {
    await getMyInfoFromSharedPreferences();
    getAndSetMessage();
  }

  @override
  void initState() {
    doThisOnLaunch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: isLeft ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.lightBlue[600],
          ),
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
            ),
          ),
          title:Text(
            widget.otherUserName,
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
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(child: chatMessages()),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.black.withOpacity(0.7),
                padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: messageTextEditingController,
                        onChanged: (value) {
                          // addMessage(false);
                        },
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: isLeft ? "type a message" : "أدخل النص",
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await addMessage(true);

                      },
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
