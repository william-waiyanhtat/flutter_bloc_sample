import 'package:flutter/material.dart';

class DropDown extends StatefulWidget {
  DropDown() : super();

  final String title = "DropDown Demo";

  @override
  DropDownState createState() => DropDownState();
}

class DropDownState extends State<DropDown> {
  //

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("DropDown Button Example"),
        ),
        body: new Container(),
      ),
    );
  }
}
