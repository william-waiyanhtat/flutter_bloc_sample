import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'widgets/Connectivity/ConnectivityDemo.dart';
import 'widgets/Connectivity/ConnectivityService.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    new HomeApp(),
  );
}

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
