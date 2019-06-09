import 'package:connectivity/connectivity.dart';
import 'dart:async';

class ConnectivityService {
  //
  StreamController<ConnectivityResult> connectionStatusController =
      StreamController<ConnectivityResult>();

  ConnectivityService() {
    // Subscribe to the connectivity Changed Steam
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      connectionStatusController.add(result);
    });
  }
}
