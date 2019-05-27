import 'package:flutter/material.dart';

class UserFilterDemo extends StatefulWidget {
  UserFilterDemo() : super();

  final String title = "User List Demo";

  @override
  UserFilterDemoState createState() => UserFilterDemoState();
}

class UserFilterDemoState extends State<UserFilterDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users List'),
      ),
      body: Container(),
    );
  }
}
