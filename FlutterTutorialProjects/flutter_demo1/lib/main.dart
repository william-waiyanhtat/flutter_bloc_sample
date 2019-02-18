import 'package:flutter/material.dart';
import 'package:flutter_demo1/others/json_parsing/json_parsing.dart';

void main() {
  runApp(
    new HomeApp(),
  );
}

class HomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Demo',
      home: new JSONDemo(),
    );
  }
}
