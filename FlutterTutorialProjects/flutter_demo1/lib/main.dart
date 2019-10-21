import 'package:flutter/material.dart';
import 'widgets/Charts/ChartsDemo.dart';
import 'widgets/Test/HomeScreen.dart';

void main() {
  runApp(
    new HomeApp(),
  );
}

/*
// Wrap main widget inside the StreamProvider
class HomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<ConnectivityResult>(
      builder: (context) => ConnectivityService().connectionStatusController,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Tutorials',
        home: new ConnectivityDemo(),
      ),
    );
  }
}
*/

class HomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Tutorials',
      home: new ChartsDemo(),
    );
  }
}
