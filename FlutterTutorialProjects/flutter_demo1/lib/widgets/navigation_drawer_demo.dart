import 'package:flutter/material.dart';

class NavigationDrawerDemo extends StatefulWidget {
  NavigationDrawerDemo() : super();

  final String title = "Navigation Drawer Demo";

  @override
  _NavigationDrawerDemoState createState() => _NavigationDrawerDemoState();
}

class _NavigationDrawerDemoState extends State<NavigationDrawerDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('images/flutter.jpg',
                  width: 80,
                  height: 80,),
                  SizedBox(height: 15,),
                  Text("name",
                  style: TextStyle(color: Colors.grey),)
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
            ),
            ListTile(
              leading: Icon(Icons.add_to_photos),
              title: Text('Add to Photos'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.add_alarm),
              title: Text('Alarm'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
    );
  }
}
