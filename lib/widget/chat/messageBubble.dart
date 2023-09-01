import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  //
  final message;
  final isMe;
  final userName;

  ///
  const MessageBubble(
    this.message,
    this.isMe,
    this.userName,
  );
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Column(
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
              // width: 250,
              constraints: BoxConstraints(maxWidth: 350),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              child: Text(
                message,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 18),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric( horizontal: 16),
              margin: EdgeInsets.symmetric( horizontal: 8),
              child: Text(
                userName,
                style: TextStyle(fontSize: 15),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
