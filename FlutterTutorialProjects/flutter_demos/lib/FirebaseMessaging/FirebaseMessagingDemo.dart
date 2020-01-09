import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FirebaseMessagingDemo extends StatefulWidget {
  //
  FirebaseMessagingDemo() : super();

  final String title = "Firebase Messaging Demo";

  @override
  _FirebaseMessagingDemoState createState() => _FirebaseMessagingDemoState();
}

class _FirebaseMessagingDemoState extends State<FirebaseMessagingDemo> {
  //
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.getToken().then((token) {
      print("Device Token: $token");
    });
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage: $message');
        final notification = message['notification'];
        final data = message['data'];
        print(
            "Title: ${notification['title']}, body: ${notification['body']} , key1: body: ${data['key1']}");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch: $message');
        final notification = message['notification'];
        print("Title: ${notification['title']}, body: ${notification['body']}");
      },
      onResume: (Map<String, dynamic> message) async {
        print('onResume: $message');
        final notification = message['notification'];
        print("Title: ${notification['title']}, body: ${notification['body']}");
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(),
    );
  }
}
