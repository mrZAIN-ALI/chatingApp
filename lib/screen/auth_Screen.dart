import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
//
import '../widget/auth/authForm.dart';

class Auth_Scren extends StatefulWidget {
  const Auth_Scren({super.key});

  @override
  State<Auth_Scren> createState() => _Auth_ScrenState();
}

class _Auth_ScrenState extends State<Auth_Scren> {
  //
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;
  void _submitFormData(
    String email_,
    String userName_,
    String password_,
    bool isLogedIn,
    XFile image,
    BuildContext context,
  ) async {
    UserCredential authResult;

    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogedIn) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email_, password: password_);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email_, password: password_);
        
        final refToFile =
            FirebaseStorage.instance.ref().child("userProfile_images").child(
                  "${authResult.user!.uid}.jpg",
                );
        await refToFile.putFile(
          (File(
            image.path,
          )),
        ).whenComplete;

        await FirebaseFirestore.instance
            .collection("users")
            .doc(authResult.user!.uid)
            .set({
          "email": email_,
          "userName": userName_,
        });
      }
    } on PlatformException catch (err) {
      var message = "error occured please check credentials";
      if (err.message != null) {
        message = err.message.toString();
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
          ),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            error.toString(),
          ),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      print("Printing error " + error.toString());
      setState(() {
        _isLoading = false;
      });
    }
  }

  //
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
        child: Auth_Form(submitFormFun: _submitFormData, isLoading: _isLoading),
      ),
    );
  }
}
