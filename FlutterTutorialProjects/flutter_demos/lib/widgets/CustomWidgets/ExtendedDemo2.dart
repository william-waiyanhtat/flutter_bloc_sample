import 'package:flutter/material.dart';
import 'ExtendedDemo.dart' show ExtendedString, ExtendedText;

class ExtendedDemo extends StatefulWidget {
  //
  ExtendedDemo() : super();

  final String title = "Extended Demo";

  @override
  _ExtendedDemoState createState() => _ExtendedDemoState();
}

class _ExtendedDemoState extends State<ExtendedDemo> {
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('hello world'.firstLetterToUpperCase()),
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            color: Colors.yellow,
            child: Text('Hello World'),
          ),
          Text('Hello World').setBigWhiteText().addBox(),
        ],
      ),
    );
  }
}
