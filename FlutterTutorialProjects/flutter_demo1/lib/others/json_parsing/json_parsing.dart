import 'package:flutter/material.dart';

class JSONDemo extends StatefulWidget {
  JSONDemo() : super();

  final String title = "JSON Parse Demo";

  @override
  _JSONDemoState createState() => _JSONDemoState();
}

class _JSONDemoState extends State<JSONDemo> {
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
    );
  }
}
