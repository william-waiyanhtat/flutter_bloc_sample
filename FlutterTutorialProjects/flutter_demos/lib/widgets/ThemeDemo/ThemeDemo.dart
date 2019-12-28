import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'AppNotifier.dart';

class ThemeDemo extends StatefulWidget {
  @override
  ThemeDemoState createState() => ThemeDemoState();
}

class ThemeDemoState extends State<ThemeDemo> {
  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Theme Demo'),
        leading: Icon(Icons.menu),
        actions: <Widget>[
          Switch(
            value: Provider.of<AppNotifier>(context).isDarkMode,
            onChanged: (boolVal) {
              Provider.of<AppNotifier>(context).updateTheme(boolVal);
            },
          )
        ],
      ),
      body: Container(
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, pos) {
            int val = Random().nextInt(100);
            return Card(
              child: ListTile(
                title: Text(
                  "Hello $val",
                  style: Theme.of(context).textTheme.title,
                ),
                subtitle: Text(
                  "Subtitle $val",
                  style: Theme.of(context).textTheme.subtitle,
                ),
                leading: Icon(
                  Icons.alarm,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
