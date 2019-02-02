import 'package:flutter/material.dart';
import 'package:flutter_demo1/widgets/old/progress_painter.dart';
import 'dart:ui';
import 'dart:async';

class CustomDemo extends StatefulWidget {
  CustomDemo() : super();

  final String title = "Custom Paint Demo";

  @override
  CustomDemoState createState() => CustomDemoState();
}

class CustomDemoState extends State<CustomDemo>
    with SingleTickerProviderStateMixin {
  //
  double _percentage;
  double _nextPercentage;
  bool _progressDone;
  Timer _timer;
  AnimationController _progressAnimationController;

  @override
  void initState() {
    super.initState();
    _percentage = 0.0;
    _nextPercentage = 0.0;
    _progressDone = false;
    _timer = null;
    initAnimationController();
  }

  initAnimationController() {
    _progressAnimationController = new AnimationController(
      vsync: this,
      duration: new Duration(milliseconds: 1000),
    )..addListener(() {
        setState(() {
          _percentage = lerpDouble(
              _percentage, _nextPercentage, _progressAnimationController.value);
        });
      });
  }

  start() {
    Timer.periodic(Duration(milliseconds: 30), handleTicker);
  }

  handleTicker(Timer timer) {
    _timer = timer;
    if (_nextPercentage < 100) {
      publishProgress();
    } else {
      timer.cancel();
      setState(() {
        _progressDone = true;
      });
    }
  }

  publishProgress() async {
    setState(() {
      _percentage = _nextPercentage;
      _nextPercentage += 0.5;
      if (_nextPercentage > 100.0) {
        _percentage = 0.0;
        _nextPercentage = 0.0;
      }
      _progressAnimationController.forward(from: 0.0);
    });
  }

  startProgress() {
    if (null != _timer && _timer.isActive) {
      _timer.cancel();
    }
    setState(() {
      _percentage = 0;
      _nextPercentage = 0;
      _progressDone = false;
      start();
    });
  }

  getDoneImage() {
    return Image.asset(
      "images/checkmark.png",
      width: 50,
      height: 50,
    );
  }

  getProgressText() {
    return Text(
      _nextPercentage == 0 ? '' : '${_nextPercentage.toInt()}',
      style: TextStyle(
          fontSize: 40, fontWeight: FontWeight.w800, color: Colors.green),
    );
  }

  progressView() {
    return CustomPaint(
      child: Center(
        child: _progressDone ? getDoneImage() : getProgressText(),
      ),
      foregroundPainter: new ProgressPainter(
          defaultCircleColor: Colors.amber,
          percentageCompletedCircleColor: Colors.green,
          completedPercent: _percentage,
          circleWidth: 50.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 200,
              width: 200,
              alignment: Alignment.center,
              padding: EdgeInsets.all(20.0),
              margin: EdgeInsets.all(30.0),
              child: progressView(),
            ),
            OutlineButton(
              child: Text("START"),
              onPressed: startProgress,
            ),
          ],
        ),
      ),
    );
  }
}
