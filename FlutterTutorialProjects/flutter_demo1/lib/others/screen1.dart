import 'package:flutter/material.dart';
import 'screen2.dart';

class ScreenOne extends StatefulWidget {
  ScreenOne() : super();

  final String title = "Screen One";

  @override
  _ScreenOneState createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {
  void goToNextPage(BuildContext context) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) => new ScreenTwo("Screen Two")));
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
              "Screen One",
            ),
            RaisedButton(
              child: Text("Go to Next Page"),
              onPressed: () {
                goToNextPage(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
