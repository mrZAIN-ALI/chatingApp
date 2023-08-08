import 'package:flutter/material.dart';
//
import '../widget/auth/authForm.dart';

class Auth_Scren extends StatefulWidget {
  const Auth_Scren({super.key});

  @override
  State<Auth_Scren> createState() => _Auth_ScrenState();
}

class _Auth_ScrenState extends State<Auth_Scren> {
  void _submitFormData(
    String email,
    String userName,
    String password,
    bool isLogedIn,
  ) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              Color.fromARGB(255, 195, 182, 232)
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Auth_Form(_submitFormData),
      ),
    );
  }
}
