import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("chat").snapshots(),
      builder: (context, chatsnapshot) {
        if(chatsnapshot.connectionState ==ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);
        }
        
          final chatDocs=chatsnapshot.data!.docs;
          return ListView.builder(itemCount: chatDocs.length , itemBuilder: (context, index) {
            return Text(chatDocs[index]["text"]);
          },);
        
      },
    );
  }
}
