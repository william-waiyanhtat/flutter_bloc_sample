import 'package:flutter/material.dart';
import 'package:flutter_demos/screens/home_screen.dart';
import 'package:flutter_demos/screens/login_screen.dart';
import 'package:flutter_demos/screens/settings_screen.dart';

class Routes {
  //
  static routes() {
    return {
      LoginScreen.ROUTE_ID: (context) => LoginScreen(),
      HomeScreen.ROUTE_ID: (context) => HomeScreen(),
      SettingsScreen.ROUTE_ID: (context) => SettingsScreen(),
    };
  }

  static initScreen() {
    return LoginScreen.ROUTE_ID;
  }

  static homeScreen() {
    return HomeScreen.ROUTE_ID;
  }
}
