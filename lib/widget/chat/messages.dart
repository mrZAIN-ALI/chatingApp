import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//
import '/widget/chat/messageBubble.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: Future(() => (FirebaseAuth.instance.currentUser),),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text("Error: ${snapshot.error}"),
          );
        }

        final currentUser = snapshot.data;

        return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("chat")
              .orderBy("timeSent", descending: true)
              .snapshots(),
          builder: (context, chatsnapshot) {
            if (chatsnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (chatsnapshot.hasError) {
              return Center(
                child: Text("Error: ${chatsnapshot.error}"),
              );
            }

            final chatDocs = chatsnapshot.data!.docs;

            return ListView.builder(
              reverse: true,
              itemCount: chatDocs.length,
              itemBuilder: (context, index) {
                return MessageBubble(
                  chatDocs[index]["text"],
                  chatDocs[index]["userId"] == currentUser?.uid,
                );
              },
            );
          },
        );
      },
    );
  }
}
