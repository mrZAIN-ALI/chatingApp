import 'dart:io';

import 'package:flutter/material.dart';

class Auth_Form extends StatefulWidget {
  final Function(String email, String userName, String password, bool isLogedin,BuildContext ctx)
      submitFormFun;
  var isLoading;
  Auth_Form({required this.submitFormFun,required this.isLoading});

  @override
  State<Auth_Form> createState() => _Auth_FormState();
}

class _Auth_FormState extends State<Auth_Form> {
  //
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    //
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
      widget.submitFormFun(
        _email.trim(),
        _userName.trim(),
        _password.trim(),
        _isLogin,
        context,
      );
    }
  }

  String _password = "default";
  String _email = "default";
  String _userName = "default";

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
                    key: ValueKey("Email"),
                    validator: (value) {
                      if (value!.isEmpty || !value!.contains("@")) {
                        return "Please Enter Valid Email Adress";
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email Address",
                    ),
                    onSaved: (newValue) {
                      _email = newValue as String;
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey("UserName"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter valid Username";
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "User Name",
                      ),
                      onSaved: (newValue) {
                        _userName = newValue as String;
                      },
                    ),
                  TextFormField(
                    key: ValueKey("Password"),
                    validator: (value) {
                      if (value!.length < 8 || value!.isEmpty) {
                        return "Password must me atleast 8 charachters long";
                      }
                    },
                    decoration: InputDecoration(labelText: "Password"),
                    obscureText: true,
                    onSaved: (newValue) {
                      _password = newValue as String;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if(widget.isLoading) CircularProgressIndicator(),
                  if(!widget.isLoading)
                  FloatingActionButton.extended(
                    heroTag: "log in",
                    label: Text(_isLogin ? "Sign in" : "Sign up"),
                    icon: Icon(Icons.login),
                    onPressed: _trySubmit,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if(!widget.isLoading)
                  TextButton(
                    child: Text(_isLogin
                        ? "Create New Account"
                        : "Already have account ? Sing in"),
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
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
