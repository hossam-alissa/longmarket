import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:longmarket/config/config.dart';
import 'package:longmarket/models/chat_message.dart';
import 'package:longmarket/models/models.dart';
import 'package:longmarket/screens/chat_screen.dart';
import 'package:longmarket/widgets/widgets.dart';
import 'package:provider/provider.dart';

class MessageScreen extends StatefulWidget {
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  bool _isSearching = false;
  Stream usersStream;
  Stream chatRoomsStream;

  Widget chatRoomsList() {
    return StreamBuilder(
      stream: chatRoomsStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return Column(
                    children: [
                      ChatRoomListTitle(otherUidUserName: (ds.id.replaceAll(
                          Provider.of<UserInformation>(providerContext, listen: false).idInDataBase,
                          "").replaceAll("_", ""))),
                      myDivider(),
                    ],
                  );
                },
              )
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }

  getChatRooms() async {
    chatRoomsStream = await ChatMessageDataBase().getChatRooms(
        Provider.of<UserInformation>(providerContext, listen: false)
            .idInDataBase);
    setState(() {});
  }

  onScreenLoaded() async {
    // await getMyInfoFromSharedPreferences();
    await getChatRooms();
  }

  @override
  void initState() {
    onScreenLoaded();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 10.0),
          Expanded(child: chatRoomsList()),
        ],
      ),
    );
  }
}

class ChatRoomListTitle extends StatefulWidget {
  final String otherUidUserName;

  ChatRoomListTitle({
    @required this.otherUidUserName,
  });

  @override
  _ChatRoomListTitleState createState() => _ChatRoomListTitleState();
}

class _ChatRoomListTitleState extends State<ChatRoomListTitle> {
  String otherUserName = "";

  getOtherUserName()async{
    otherUserName = await ChatMessageDataBase().getUserNameByUID(widget.otherUidUserName);
    setState(() {

    });
  }
  @override
  void initState() {
    getOtherUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen(uidUserNameSend:
        Provider.of<UserInformation>(providerContext,listen: false).idInDataBase, uidUserNameReceive: widget.otherUidUserName,otherUserName: otherUserName)));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 0.0),
        padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 16.0),
        height: 60.0,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              isLeft == true ? Colors.grey[400] : Colors.white,
              isLeft == true ? Colors.white : Colors.grey[400],
            ],
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.message),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                otherUserName ,
                style: TextStyle(fontSize: 18.0 ,fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
