import 'package:flutter/material.dart';
import 'package:flutter_demos/screens/home_screen.dart';

void main() async {
  runApp(
    HomeApp(),
  );
}

class HomeApp extends StatelessWidget {
  //
  HomeApp({this.route});
  final String route;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}
