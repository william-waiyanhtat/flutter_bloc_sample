import 'package:flutter/material.dart';
import 'others/GradientDemo/GradientDemo.dart';
import 'widgets/CustomFonts/CustomFontDemo.dart';
import 'widgets/DropDown/DropDownButton.dart';
import 'widgets/BottomNavigation/BottomNavigation.dart';
import 'widgets/Stepper/stepper.dart';
import 'widgets/Carousel/CarouselDemo.dart';
import 'textfield/auto_complete.dart';
import 'widgets/List/AnimatedList.dart';
import 'widgets/TabAppBar/TabbedAppBarDemo.dart';

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
      home: new TabbedAppBarDemo(),
    );
  }
}
