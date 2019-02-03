import 'package:flutter/material.dart';

class BackDropFilterDemo extends StatefulWidget {
  BackDropFilterDemo() : super();

  final String title = "Image Filter Demo";

  @override
  BackDropFilterDemoState createState() => BackDropFilterDemoState();
}

class BackDropFilterDemoState extends State<BackDropFilterDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        color: Colors.white,
        child: Center(),
      ),
    );
  }
}
