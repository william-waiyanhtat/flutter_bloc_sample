import 'package:flutter/material.dart';
import 'widgets/data_table/data_table.dart';
import 'inherited_widgets/demo/homescreen.dart';
import 'tips/transform_demo.dart';
import 'widgets/tranformdemo/transform_demo.dart';
import 'widgets/radio_widget_demo/radio_widget_demo.dart';
import 'textfield/auto_complete.dart';
import 'others/shared_preference/shared_preference_demo.dart';
import 'widgets/animated_container/animated_demo.dart';
import 'widgets/custom_paint/custom_paint.dart';
import 'widgets/backdropfliter/backdrop_filter.dart';

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
      home: new BackDropFilterDemo(),
    );
  }
}
