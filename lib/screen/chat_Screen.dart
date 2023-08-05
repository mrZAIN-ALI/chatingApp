import 'package:flutter/material.dart';
//
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Chat"),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => Container(
          padding: EdgeInsets.all(10),
          child: Text("Hello working"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.woman_2_outlined),
        onPressed: () {
          FirebaseFirestore.instance
              .collection("chats/Szd4bRarYvsFYY12oKC5/messages")
              .snapshots()
              .listen(
                (event) {
                  print(event);
                },
              );
        },
      ),
    );
  }
}
