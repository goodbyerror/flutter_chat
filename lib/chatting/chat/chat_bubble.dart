import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_8.dart';

class ChatBubbles extends StatelessWidget {
  const ChatBubbles(this.message, this.isMe, this.userName, this.userImage,
      {Key? key})
      : super(key: key);

  final String message;
  final String userName;
  final bool isMe;
  final String userImage;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (isMe)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ChatBubble(
                margin: EdgeInsets.fromLTRB(0, 10, 45, 0),
                alignment: Alignment.topRight,
                backGroundColor: Colors.blue,
                child: Column(
                  crossAxisAlignment:
                      isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    Text(
                      message,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                clipper: ChatBubbleClipper8(type: BubbleType.sendBubble),
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.fromLTRB(45, 10, 0, 0),
              child: ChatBubble(
                margin: EdgeInsets.only(top: 20),
                alignment: Alignment.topRight,
                backGroundColor: Colors.grey[400],
                child: Column(
                  crossAxisAlignment:
                      isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    Text(
                      message,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                clipper: ChatBubbleClipper8(type: BubbleType.receiverBubble),
              ),
            )
        ],
        // children: [
        //   Container(
        //     decoration: BoxDecoration(
        //       color: isMe ? Colors.grey[300] : Colors.blue,
        //       borderRadius: BorderRadius.only(
        //         topLeft: Radius.circular(12),
        //         topRight: Radius.circular(12 ),
        //         bottomRight: isMe? Radius.circular(0) : Radius.circular(12),
        //         bottomLeft: isMe? Radius.circular(12) : Radius.circular(0)
        //       )
        //     ),
        //     width: 145,
        //     padding: EdgeInsets.symmetric(
        //       horizontal: 10,
        //       vertical: 16
        //     ),
        //     margin: EdgeInsets.symmetric(
        //       horizontal: 8,
        //       vertical: 4
        //     ),
        //     child: Text(message,
        //     style: TextStyle(
        //       color: isMe? Colors.black87 : Colors.white,)
        //     ),
        //   ),
        // ],
      ),
      Positioned(
        top: 0,
        right: isMe? 5 : null,
        left: isMe? null : 5,
        child: CircleAvatar(
          backgroundImage: NetworkImage(userImage),
        ),
      )
    ]);
  }
}
