import 'package:flutter/material.dart';
import 'widgets/Share/LaunchUrl.dart';

void main() {
  runApp(
    new HomeApp(),
  );
}

class HomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Tutorials',
      home: new LaunchUrlDemo(),
    );
  }
}
