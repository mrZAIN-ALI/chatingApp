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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("chats/Szd4bRarYvsFYY12oKC5/messages")
            .snapshots(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final msgs_Collection = snapshot.data!.docs;
          return ListView.builder(
            itemCount: msgs_Collection.length,
            itemBuilder: (context, index) => Container(
              padding: EdgeInsets.all(10),
              child: Text(msgs_Collection[index]["text"]),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.woman_2_outlined),
        onPressed: () {
          FirebaseFirestore.instance.collection("chats/Szd4bRarYvsFYY12oKC5/messages").add({
            "text":"This was added by clicking lady",
          },);
        },
      ),
    );
  }
}
