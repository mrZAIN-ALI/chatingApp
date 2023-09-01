import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  //

  var _enteredMessage = "";
  void _sendMessage()  async{
    FocusScope.of(context).unfocus();
    // final userId= await FirebaseAuth.instance.currentUser!.getIdToken;
    final userInfo = (await FirebaseAuth.instance.currentUser); // Using 'uid' to get the user's ID
    final userData= await FirebaseFirestore.instance.collection("users").doc(userInfo!.uid).get();
     FirebaseFirestore.instance.collection("chat").add(
      {
        "text": _enteredMessage,
        "timeSent": Timestamp.now(),
        "userId": userInfo!.uid,
        "userName": userData["userName"],
      },
    );
    _messsageFieldController.clear();
  }

  final _messsageFieldController = TextEditingController();
  //
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messsageFieldController,
              decoration: InputDecoration(labelText: "Input Message"),
              onChanged: (value) {
                setState(() {
                  _enteredMessage = value;
                });
              },
            ),
          ),
          IconButton(
            onPressed:
                _enteredMessage.toString().trim().isEmpty ? null : _sendMessage,
            icon: Icon(Icons.send),
            color: _enteredMessage.toString().trim().isEmpty ? Colors.black : Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }
}
