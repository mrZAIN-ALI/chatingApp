import 'dart:io';

import 'package:flutter/material.dart';

class Auth_Form extends StatefulWidget {
  final Function(String email, String userName, String password, bool isLogedin)
      submitFormFun;

  Auth_Form({required this.submitFormFun});

  @override
  State<Auth_Form> createState() => _Auth_FormState();
}

class _Auth_FormState extends State<Auth_Form> {
  //
  final _formKey = GlobalKey<FormState>();

  void _trySubmit(){
    final isValid =_formKey.currentState!.validate();
    //
    FocusScope.of(context).unfocus();
    if(isValid){
      _formKey.currentState!.save();
    }
  }
  String _password="default";
  String _email="default";
  String _userName="default";
  //
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty || !value!.contains("@")) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Error"),
                              content: Text("Please Enter Valid Email Adress"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('OK'),
                                ), 
                              ],
                            );
                          },
                        );
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email Address",
                    ),
                    onSaved: (newValue) {
                      _email=newValue as String;
                    },
                  ),
                  TextFormField(
                    validator: (value) {
                      if(value!.isEmpty){
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Error"),
                              content: Text("Please Enter valid Username"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('OK'),
                                ), 
                              ],
                            );
                          },
                        );
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "User Name",
                    ),
                    onSaved: (newValue) {
                      _userName=newValue as String;
                    },
                  ),
                  TextFormField(
                    validator: (value) {
                      if(value!.length<8 || value!.isEmpty){
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Password Error"),
                              content: Text("Password must me atleast 8 charachters long"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('OK'),
                                ), 
                              ],
                            );
                          },
                        );
                      }
                    },
                    decoration: InputDecoration(labelText: "Password"),
                    obscureText: true,
                    onSaved: (newValue) {
                      _password=newValue as String;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FloatingActionButton.extended(
                    heroTag: "log in",
                    label: Text("Sign in"),
                    icon: Icon(Icons.login),
                    onPressed: () {},
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    child: Text("Singn up"),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
