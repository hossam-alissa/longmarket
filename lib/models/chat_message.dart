import 'package:flutter/material.dart';

class ChatMessage{
  Key key;
  String textMessage;
  String userName;
  bool isMe;

  chatDesign ({@required Key key,@required String textMessage,@required String  userName,@required bool isMe}){
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: isMe? Colors.grey : Colors.blueAccent,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14),
              topRight: Radius.circular(14),
              bottomLeft: isMe ? Radius.circular(14): Radius.circular(0),
              bottomRight: isMe? Radius.circular(0): Radius.circular(14),
            )
          ),
       //   width: 150,
          padding: EdgeInsets.symmetric(vertical: 10 , horizontal: 16),
          margin: EdgeInsets.symmetric(vertical: 4,horizontal: 8),
          child: Column(
         //   mainAxisAlignment: isMe? MainAxisAlignment.end: MainAxisAlignment.start,
            children: [
              Text(userName.toString(),textAlign: isMe? TextAlign.left:TextAlign.right),
              Text(textMessage.toString(),textAlign: isMe? TextAlign.left:TextAlign.right),
            ],
          ),
        )
      ],
    );
  }
}
