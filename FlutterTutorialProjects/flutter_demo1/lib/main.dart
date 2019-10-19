import 'package:flutter/material.dart';
import 'package:flutter_demo1/widgets/webview/webview2.dart';
import 'widgets/DataTableMySqlDemo/DataTableDemo.dart';
import 'widgets/webview/WebViewLocal.dart';
import 'widgets/webview/webview_demo.dart';
import 'asset_demo/asset_demo.dart';
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
      home: new GridViewDemo(),
    );
  }
}
