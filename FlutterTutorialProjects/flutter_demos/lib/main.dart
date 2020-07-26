import 'package:flutter/material.dart';
import 'package:flutter_demos/utils/Utils.dart';
import 'package:flutter_demos/utils/appsettings.dart';
import 'package:flutter_demos/utils/routes.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String route = Routes.initialRoute();
  bool isLoggedIn = await Utils.isLoggedIn();
  if (isLoggedIn) {
    route = Routes.homeRoute();
  }
  runApp(
    HomeApp(route: route),
  );
}

class HomeApp extends StatelessWidget {
  //
  HomeApp({this.route});
  final String route;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AppSettings(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: Routes.routes(),
        initialRoute: route,
      ),
    );
  }
}
