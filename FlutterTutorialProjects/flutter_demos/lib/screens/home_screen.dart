import 'package:flutter/material.dart';
import 'package:flutter_demos/components/appbar.dart';
import 'package:flutter_demos/screens/settings_screen.dart';
import 'package:flutter_demos/utils/appsettings.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IAppBar(
        height: 100,
        color: Colors.green,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'HOME',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.white,
      ),
    );
  }
}
