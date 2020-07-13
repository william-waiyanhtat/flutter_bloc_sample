import 'package:flutter/material.dart';
import 'package:flutter_demos/screens/settings.dart';
import 'package:flutter_demos/utils/app_settings.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.watch<AppSettings>().appColor,
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsScreen(),
                ),
              );
            },
          )
        ],
      ),
      body: Container(
        color: context.watch<AppSettings>().appColor,
      ),
    );
  }
}
