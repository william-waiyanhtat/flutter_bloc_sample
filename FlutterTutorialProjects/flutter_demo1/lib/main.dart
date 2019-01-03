import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_demo1/debug/debug_app.dart';
import 'package:flutter/scheduler.dart';
import 'widgets/switch_demo.dart';
import 'package:flutter_demo1/custom_widget/custom_widget_demo.dart';

void main() {
  // You can also debug a layout problem visually, by setting debugPaintSizeEnabled to true.
  // debugPaintSizeEnabled = true;
  // Debugging animations
  //timeDilation = 50.0;
  // debugPaintPointersEnabled = true;
  //debugPrintBeginFrameBanner = true;
  //debugPaintLayerBordersEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //showPerformanceOverlay:true,
      //debugShowMaterialGrid: true,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CustomWidgetDemo(),
    );
  }
}
