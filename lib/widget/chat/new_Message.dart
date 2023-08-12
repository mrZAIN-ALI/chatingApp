import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {

  var _enteredMessage="default";
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(labelText: "Input Message"),
              onChanged: (value) {
                setState(() {
                  _enteredMessage=value ;
                });
              },
            ),
          ),
          IconButton(
            onPressed: 
              _enteredMessage.trim().isEmpty ? null : (){
                
              },
            
            icon: Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
