import 'package:flutter/material.dart';
import 'ErrorHandling/HomeScreen.dart';

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
      home: new HomeScreen(),
    );
  }
}

/*
class HomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: FirstScreen(),
      routes: {
        FirstScreen.routeId: (context) => FirstScreen(),
        SecondScreen.routeId: (context) => SecondScreen(),
      },
      initialRoute: FirstScreen.routeId,
    );
  }
}
*/
