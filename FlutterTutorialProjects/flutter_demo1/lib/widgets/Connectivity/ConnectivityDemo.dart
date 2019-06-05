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
    subscription = connectivity.onConnectivityChanged
        .listen((ConnectivityResult connectivityResult) {
      print("Connection Changed");
      showStatus(connectivityResult);
    });
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }

  void check() async {
    var connectivityResult = await (connectivity.checkConnectivity());
    showStatus(connectivityResult);
  }

  void showStatus(ConnectivityResult connectivityResult) {
    String status = getNetworkStatus(connectivityResult);
    setState(() {
      _networkStatus = 'Connected to $status';
    });
  }

  String getNetworkStatus(ConnectivityResult connectivityResult) {
    switch (connectivityResult) {
      case ConnectivityResult.mobile:
        return 'Mobile';
        break;
      case ConnectivityResult.wifi:
        return 'Wifi';
        break;
      case ConnectivityResult.none:
        return 'None';
        break;
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    var connectionStatus = Provider.of<ConnectivityResult>(context);
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
            Text('$connectionStatus'),
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

class ConnectivityService {
  StreamController<ConnectivityResult> connectionStatusController =
      StreamController<ConnectivityResult>();

  ConnectivityService() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      connectionStatusController.add(result);
    });
  }
}
