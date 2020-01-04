import 'package:flutter/material.dart';

class CustomWidgetDemo extends StatefulWidget {
  CustomWidgetDemo() : super();

  final String title = "Custom Widget Demo";

  @override
  _CustomWidgetDemoState createState() => _CustomWidgetDemoState();
}

class _CustomWidgetDemoState extends State<CustomWidgetDemo> {
  //
  String name = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          OutlineButton(
            child: Text('Tap Me'),
            onPressed: () {
              setState(() {
                //name = 'google'.firstLetterToUpperCase();
                name = Util.firstLetterToUpperCase('google');
              });
            },
          ),
          Text(name),
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            color: Colors.yellow,
            child: Text('Extended Text'),
          ),
          Text('Extended Text').setWhiteColor().addContainer(),
        ],
      ),
    );
  }
}

extension StringExtension on String {
  get firstLetterToUpperCase {
    if (this != null)
      return this[0].toUpperCase() + this.substring(1);
    else
      return null;
  }
}

class Util {
  static String firstLetterToUpperCase(String someString) {
    if (someString != null)
      return someString[0].toUpperCase() + someString.substring(1);
    else
      return null;
  }
}

// extension ExtendedText on Text {
extension ExtendedText on Widget {
  //
  Container addContainer() {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      color: Colors.yellow,
      child: this,
    );
  }

  Text setWhiteColor() {
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
