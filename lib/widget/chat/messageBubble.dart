import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  //
  final message;
  final isMe;

  ///
  const MessageBubble(
    this.message,
    this.isMe,
  );
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(12),
          ),
          width: 150,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          child: Text(
            message,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
