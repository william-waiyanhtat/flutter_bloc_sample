import 'package:flutter/material.dart';

class AnimatedDemo extends StatefulWidget {
  AnimatedDemo() : super();

  final String title = "Animatedt Demo";

  @override
  AnimatedDemoState createState() => AnimatedDemoState();
}

class AnimatedDemoState extends State<AnimatedDemo> {
  //
  bool _isFirstState = false;
  var _color = Colors.red;
  var _height = 100.0;
  var _width = 100.0;
  var _opacity = 0.0;

  animateContainer() {
    setState(() {
      _color = _color == Colors.green ? Colors.red : Colors.green;
      _height = _height == 100 ? 200 : 100;
      _width = _width == 100 ? 200 : 100;
    });
  }

  animateCrossFade() {
    setState(() {
      _isFirstState = !_isFirstState;
    });
  }

  animateOpacity() {
    setState(() {
      _opacity = _opacity == 0 ? 1.0 : 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AnimatedContainer(
              duration: Duration(seconds: 1),
              color: _color,
              height: _height,
              width: _width,
            ),
            OutlineButton(
              child: Text("Animate Container"),
              onPressed: () {
                animateContainer();
              },
            ),
            AnimatedCrossFade(
              firstChild: Container(
                padding: EdgeInsets.all(15.0),
                child: Image.asset(
                  "images/apple.png",
                ),
                height: 200.0,
                width: 200.0,
              ),
              secondChild: Container(
                padding: EdgeInsets.all(15.0),
                child: Image.asset(
                  "images/android.png",
                ),
                height: 200.0,
                width: 200.0,
              ),
              crossFadeState: _isFirstState
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: Duration(milliseconds: 2000),
            ),
            OutlineButton(
              child: Text("Animate CrossFade"),
              onPressed: () {
                animateCrossFade();
              },
            ),
            AnimatedOpacity(
              opacity: _opacity,
              duration: Duration(seconds: 1),
              child: FlutterLogo(
                size: 200.0,
              ),
            ),
            OutlineButton(
              child: Text("Animate Opacity"),
              onPressed: () {
                animateOpacity();
              },
            ),
          ],
        ),
      ),
    );
  }
}
