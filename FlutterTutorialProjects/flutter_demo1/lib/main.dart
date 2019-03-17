import 'package:flutter/material.dart';
import 'package:flutter_demo1/sqlite/db_page.dart';

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
      home: new DBTestPage(),
    );
  }
}
