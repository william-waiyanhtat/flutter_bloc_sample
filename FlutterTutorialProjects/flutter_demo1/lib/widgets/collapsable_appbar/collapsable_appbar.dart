import 'package:flutter/material.dart';

class CollapsableAppbarDemo extends StatefulWidget {
  CollapsableAppbarDemo() : super();

  final String title = "Collpasable Appbar Demo";

  @override
  CollapsableAppbarDemoState createState() => CollapsableAppbarDemoState();
}

class CollapsableAppbarDemoState extends State<CollapsableAppbarDemo> {
  //

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
