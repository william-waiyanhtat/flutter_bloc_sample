import 'dart:async';

import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ConnectivityDemo extends StatefulWidget {
  ConnectivityDemo() : super();

  final String title = "Connectivity Demo";

  @override
  ConnectivityDemoState createState() => ConnectivityDemoState();
}

class ConnectivityDemoState extends State<ConnectivityDemo> {
  //
  String _networkStatus1 = '';
  String _networkStatus2 = '';
  String _networkStatus3 = '';
  Connectivity connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> subscription;

  @override
  void initState() {
    super.initState();
    _checkConnectivity2();
  }

  void _checkConnectivity1() async {
    var connectivityResult = await (connectivity.checkConnectivity());
    var conn = getConnectionValue(connectivityResult);
    setState(() {
      _networkStatus1 = "Check Connection :: " + conn;
    });
  }

  void _checkConnectivity2() async {
    subscription =
        connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      print("Subscription Connection Changed");
      var conn = getConnectionValue(result);
      setState(() {
        _networkStatus2 = "<Subscription> :: " + conn;
      });
    });
  }

  void _checkConnectivity3() async {
    var connectivityResult = Provider.of<ConnectivityResult>(context);
    var conn = getConnectionValue(connectivityResult);
    setState(() {
      _networkStatus3 = "<Provider> :: " + conn;
    });
  }

  String getConnectionValue(var connectivityResult) {
    String status = '';
    switch (connectivityResult) {
      case ConnectivityResult.mobile:
        status = 'Mobile';
        break;
      case ConnectivityResult.wifi:
        status = 'Wifi';
        break;
      case ConnectivityResult.none:
        status = 'None';
        break;
    }
    return 'Connected to $status';
  }

  @override
  Widget build(BuildContext context) {
    _checkConnectivity3();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(_networkStatus1),
            SizedBox(
              height: 20,
            ),
            Text(_networkStatus2),
            SizedBox(
              height: 20,
            ),
            Text(_networkStatus3),
            SizedBox(
              height: 20,
            ),
            OutlineButton(
              child: Text("Check Connection"),
              onPressed: () {
                _checkConnectivity1();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }
}
