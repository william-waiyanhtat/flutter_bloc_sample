import 'package:flutter/material.dart';

class CustomDemo extends StatefulWidget {
  CustomDemo() : super();

  final String title = "Custom Paint Demo";

  @override
  CustomDemoState createState() => CustomDemoState();
}

class CustomDemoState extends State<CustomDemo> {
  //
  // https://medium.com/@rjstech/flutter-custom-paint-tutorial-build-a-radial-progress-6f80483494df
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
    );
  }
}
