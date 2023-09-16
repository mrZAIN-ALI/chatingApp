import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MessageBubble extends StatelessWidget {
  //
  final message;
  final isMe;
  final userName;
  final userProfile_image;

  ///
  const MessageBubble(
    this.message,
    this.isMe,
    this.userName,
    this.userProfile_image,
  );
  Widget showCircularImage(String url){
    return           Container(
            margin: EdgeInsets.only(left: 5),
            child: CircleAvatar(
              backgroundImage: NetworkImage(url),
            ),
          );
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!isMe)
          showCircularImage(userProfile_image),
        Flexible(
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: isMe
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
                    bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
                  ),
                ),
                constraints: BoxConstraints(maxWidth: 350),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                child: Column(
                  children: [
                    Text(
                      userName,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.lime,
                      ),
                    ),
                    Text(
                      message,
                      style: TextStyle(
                        overflow: TextOverflow.clip,
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (isMe)
         showCircularImage(userProfile_image),

      ],
    );
  }
}
