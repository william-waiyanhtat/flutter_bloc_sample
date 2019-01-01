import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';

void main() {
  // Visual Debugging
  // debugPaintSizeEnabled = true;
  // debugPaintBaselinesEnabled = true;
  // debugPaintPointersEnabled = true; // selected objects get Hightlighted in Teal
  // debugPaintLayerBordersEnabled = true; // outlines each layer’s bounds in orange
  // Animations
  // timeDilation = 50.0;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowMaterialGrid: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  demoFunction(int testValue) {
    print('Test Value $testValue');
    //debugger();
    print("Test 2"); // wrapper around android logcat
    //debugPrint("Test 3");
    //debugDumpApp();
    
    Timeline.startSync("My Functin Starting...");
    // long running function
    Timeline.finishSync();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Debug Demo"),
            RaisedButton(
              child: Text("Click Me"),
              onPressed: () {
                demoFunction(10);
              },
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
