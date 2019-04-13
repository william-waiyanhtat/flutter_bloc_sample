import 'package:flutter/material.dart';
import 'others/GradientDemo/GradientDemo.dart';
import 'widgets/CustomFonts/CustomFontDemo.dart';
import 'widgets/DropDown/DropDownButton.dart';

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
      home: new DropDown(),
    );
  }
}
