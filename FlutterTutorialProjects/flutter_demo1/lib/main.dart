import 'package:flutter/material.dart';
import 'widgets/layout_builder/layout_builder.dart';

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
      home: new LayoutBuilderDemo(),
    );
  }
}
