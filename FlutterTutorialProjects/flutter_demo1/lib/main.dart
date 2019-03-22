import 'package:flutter/material.dart';
import 'widgets/webview/webview2.dart';
import 'widgets/webview/web2.dart';

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
      home: new WebviewDemo(),
    );
  }
}
