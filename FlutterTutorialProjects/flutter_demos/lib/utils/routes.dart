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

  static initialRoute() {
    return LoginScreen.ROUTE_ID;
  }

  static homeRoute() {
    return HomeScreen.ROUTE_ID;
  }
}
