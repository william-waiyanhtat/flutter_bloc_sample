import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class FBRealTimeDB extends StatefulWidget {
  FBRealTimeDB() : super();

  final String title = "Firebase Realtime DB";
  @override
  FBRealTimeDBState createState() => FBRealTimeDBState();
}

class FBRealTimeDBState extends State<FBRealTimeDB> {

  @override
  void initState() {
    super.initState();

    final mainReference = FirebaseDatabase.instance.reference();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(40.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,

          ),
        ),
      ),
    );
  }
}
