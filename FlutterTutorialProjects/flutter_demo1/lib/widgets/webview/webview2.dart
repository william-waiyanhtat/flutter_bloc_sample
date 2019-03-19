import 'package:flutter/material.dart';

class WebviewDemo extends StatefulWidget {
  final String title;

  WebviewDemo({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WebviewDemoState();
  }
}

class _WebviewDemoState extends State<WebviewDemo> {
  //
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Webview Demo'),
      ),
      body: Container(),
    );
  }
}
