import 'package:flutter/material.dart';
import 'widgets/data_table/data_table.dart';
import 'inherited_widgets/demo/homescreen.dart';
import 'tips/transform_demo.dart';
import 'widgets/tranformdemo/transform_demo.dart';
import 'widgets/radio_widget_demo/radio_widget_demo.dart';

void main() {
  runApp(
    new HomeApp(),
  );
}

class HomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Demo',
      home: new RadioWidgetDemo(),
    );
  }
}
