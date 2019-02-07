import 'package:flutter/material.dart';

class FBRealtimeDB extends StatefulWidget {
  FBRealtimeDB(this.title) : super();

  final String title;

  @override
  FBRealtimeDBState createState() => FBRealtimeDBState();
}

class FBRealtimeDBState extends State<FBRealtimeDB> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(40.0),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[],
        ),
      ),
    );
  }
}
