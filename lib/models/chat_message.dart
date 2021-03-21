import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessageDataBase{
  createChatRoom(String chatRoomId, Map chatRoomInfoMap) async {
    final snapShot = await FirebaseFirestore.instance
        .collection("chatRooms")
        .doc(chatRoomId)
        .get();

    if (snapShot.exists) {
      //chat room already exists
      return true;
    } else {
      return await FirebaseFirestore.instance
          .collection("chatRooms")
          .doc(chatRoomId)
          .set(chatRoomInfoMap);
    }
  }

  Future addMessage(
      String chatRoomId, String messageId, Map messageInfoMap) async {
    return await FirebaseFirestore.instance
        .collection("chatRooms")
        .doc(chatRoomId)
        .collection("chats")
        .doc(messageId)
        .set(messageInfoMap);
  }

  updateLastMessageSend(String chatRoomId, Map lastMessageInfoMap) async {
    return await FirebaseFirestore.instance
        .collection("chartRooms")
        .doc(chatRoomId)
        .update(lastMessageInfoMap);
  }

  Future<Stream<QuerySnapshot>> getChatRoomMessages(chatRoomId) async {
    return FirebaseFirestore.instance
        .collection("chatRooms")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("ts", descending: true)
    // .orderBy("ts")
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getChatRooms(String idUserName) async {
    return  FirebaseFirestore.instance
        .collection("chatRooms")
        // .orderBy("lastMessageSendTs", descending: true)
        .where("users", arrayContains: idUserName)
        .snapshots();
  }
  
  getUserNameByUID(String uid)async{
    var x = await FirebaseFirestore.instance.collection("Users").doc(uid).get();
    String userName = x.data()["userName"].toString();
    
    return userName;
  }
  // Key key;
  // String textMessage;
  // String userName;
  // bool isMe;
  //
  // chatDesign ({@required Key key,@required String textMessage,@required String  userName,@required bool isMe}){
  //   return Row(
  //     mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
  //     children: [
  //       Container(
  //         decoration: BoxDecoration(
  //           color: isMe? Colors.grey : Colors.blueAccent,
  //           borderRadius: BorderRadius.only(
  //             topLeft: Radius.circular(14),
  //             topRight: Radius.circular(14),
  //             bottomLeft: isMe ? Radius.circular(14): Radius.circular(0),
  //             bottomRight: isMe? Radius.circular(0): Radius.circular(14),
  //           )
  //         ),
  //      //   width: 150,
  //         padding: EdgeInsets.symmetric(vertical: 10 , horizontal: 16),
  //         margin: EdgeInsets.symmetric(vertical: 4,horizontal: 8),
  //         child: Column(
  //        //   mainAxisAlignment: isMe? MainAxisAlignment.end: MainAxisAlignment.start,
  //           children: [
  //             Text(userName.toString(),textAlign: isMe? TextAlign.left:TextAlign.right),
  //             Text(textMessage.toString(),textAlign: isMe? TextAlign.left:TextAlign.right),
  //           ],
  //         ),
  //       )
  //     ],
  //   );
  // }
}
