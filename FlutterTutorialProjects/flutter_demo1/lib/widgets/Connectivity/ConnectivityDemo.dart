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
  String _networkStatus = '';
  Connectivity connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> subscription;

  @override
  void initState() {
    super.initState();
    subscription =
        connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      print("Connection Changed");
    });
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }

  void check() async {
    String status = '';
    var connectivityResult = await (connectivity.checkConnectivity());
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
    setState(() {
      _networkStatus = 'Connected to $status';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(_networkStatus),
            SizedBox(
              height: 20,
            ),
            OutlineButton(
              child: Text("Check Connection"),
              onPressed: () {
                check();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class NetworkSensitive extends StatelessWidget {
  final Widget child;
  final double opacity;

  NetworkSensitive({
    this.child,
    this.opacity = 0.5,
  });

  @override
  Widget build(BuildContext context) {
    // Get our connection status from the provider
    var connectionStatus = Provider.of<ConnectivityResult>(context);
    if (connectionStatus == ConnectivityResult.wifi) {
      return child;
    }
    if (connectionStatus == ConnectivityResult.mobile) {
      return Opacity(
        opacity: opacity,
        child: child,
      );
    }
    return Opacity(
      opacity: 0.1,
      child: child,
    );
  }
}
