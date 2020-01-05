import 'package:flutter/material.dart';

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
          Text(Utils.firstLetterToUpperCase('hello world')),
          Text('hello world'.firstLetterToUpperCase()),
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            color: Colors.green,
            child: Text(
              'Hello World',
              style: TextStyle(
                fontSize: 50.0,
                color: Colors.white,
              ),
            ),
          ),
          Text('Hello World').setBigWhiteText().addBox(),
        ],
      ),
    );
  }
}

class Utils {
  static String firstLetterToUpperCase(String string) {
    if (null != string) {
      return string[0].toUpperCase() + string.substring(1);
    }
    return null;
  }
}

extension ExtendedString on String {
  // int
  get firstLetterToUpperCase {
    if (null != this) {
      return this[0].toUpperCase() + this.substring(1);
    }
    return null;
  }
}

// extension ExtendedText on Text {
extension ExtendedText on Widget {
  //
  Container addBox() {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      color: Colors.green,
      child: this,
    );
  }

  Text setBigWhiteText() {
    if (this is Text) {
      Text t = this;
      return Text(
        t.data,
        style: TextStyle(
          fontSize: 50.0,
          color: Colors.white,
        ),
      );
    }
    return null;
  }
}
