import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

//
import '/widget/chat/messageBubble.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});
  Future<void> getAndPrintToken() async {
    final PermissionStatus status = await Permission.notification.request();

    if (status.isGranted) {
      String? token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        //
        // final userData =
        //     await FirebaseFirestore.instance.collection("fcmToken").add(
        //   {
        //     "${DateTime.now().toString()}": token,
        //   },
        // );
        //
        print("The FCM token is: $token");
      } else {
        print("FCM token is null");
      }
    } else if (status.isDenied) {
      // The user denied the permission, you can show a message or request again.
    } else if (status.isPermanentlyDenied) {
      // The user permanently denied the permission, usually open app settings.
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: Future(
        () => (FirebaseAuth.instance.currentUser),
      ),
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
        getAndPrintToken();
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
                  chatDocs[index]["userName"],
                  chatDocs[index]["userImage"],
                );
              },
            );
          },
        );
      },
    );
  }
}
