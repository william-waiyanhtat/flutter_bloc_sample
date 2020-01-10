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
  List<Message> messagesList;

  @override
  void initState() {
    super.initState();
    messagesList = List<Message>();
    _getToken();
    _configureFirebaseListeners();
  }

  _getToken() {
    _firebaseMessaging.getToken().then((token) {
      print("Device Token: $token");
    });
  }

  _configureFirebaseListeners() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage: $message');
        _setMessage(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch: $message');
        _setMessage(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print('onResume: $message');
        _setMessage(message);
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: true),
    );
  }

  _setMessage(Map<String, dynamic> message) {
    final notification = message['notification'];
    final data = message['data'];
    final String title = notification['title'];
    final String body = notification['body'];
    String dataKey = data['key1'];
    print("Title: $title, body: $body, Key1: $dataKey");
    setState(() {
      Message msg = Message(title, body, dataKey);
      messagesList.add(msg);
    });
  }

  @override
  Widget build(BuildContext context) {
    print('here');
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: _getMessageCount(),
        itemBuilder: (BuildContext context, int index) {
          return row(index);
        },
      ),
    );
  }

  _getMessageCount() {
    print("len ${messagesList.length}");
    return null == messagesList ? 0 : messagesList.length;
  }

  Widget row(int index) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              messagesList[index].dataKey1,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Message {
  String title;
  String body;
  String dataKey1;
  Message(title, body, dataKey1) {
    this.title = title;
    this.body = body;
    this.dataKey1 = dataKey1;
  }
}
