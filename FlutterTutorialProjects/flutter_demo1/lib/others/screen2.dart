import 'package:flutter/material.dart';

class ScreenTwo extends StatefulWidget {
  ScreenTwo(this.title) : super();

  final String title;

  @override
  _ScreenTwoState createState() => _ScreenTwoState();
}

class _ScreenTwoState extends State<ScreenTwo> {
  void goBack(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              widget.title,
            ),
            RaisedButton(
              child: Text("Go Back"),
              onPressed: () {
                goBack(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
