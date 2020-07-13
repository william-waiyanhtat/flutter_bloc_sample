import 'package:flutter/material.dart';
import 'package:flutter_demos/utils/app_settings.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen.dart';

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
        )
      ],
      child: MaterialApp(
        title: 'Win Interviews',
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
