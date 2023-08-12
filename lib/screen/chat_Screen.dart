import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widget/chat/new_Message.dart';
import '../widget/chat/messages.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Chat"),
        actions: [
          DropdownButton(
            icon: Icon(Icons.more_vert),
            items: [
              DropdownMenuItem(
                child: Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: (Colors.black))),
                  child: Row(
                    children: [
                      Icon(Icons.exit_to_app),
                      SizedBox(
                        width: 8,
                      ),
                      Text("Logout")
                    ],
                  ),
                ),
                value: "Logout",
              ),
            ],
            onChanged: (value) {
              if (value == "Logout") {
                FirebaseAuth.instance.signOut();
              }
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(child: Messages()),
            NewMessage(),
          ],
        ),
      ),
      
    );
  }
}
