import 'package:flutter/material.dart';
import 'package:flutter_demos/screens/login_screen.dart';
import 'package:flutter_demos/utils/appsettings.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    HomeApp(),
  );
}

class HomeApp extends StatelessWidget {
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
        home: LoginScreen(),
      ),
    );
  }
}
