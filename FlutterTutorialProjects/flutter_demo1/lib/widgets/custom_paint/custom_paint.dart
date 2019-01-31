import 'package:flutter/material.dart';
import 'package:flutter_demo1/widgets/custom_paint/painter.dart';
import 'dart:math';
import 'dart:ui';
import 'dart:async';

class CustomDemo extends StatefulWidget {
  CustomDemo() : super();

  final String title = "Custom Paint Demo";

  @override
  CustomDemoState createState() => CustomDemoState();
}

class CustomDemoState extends State<CustomDemo> with TickerProviderStateMixin {
  //
  // https://medium.com/@rjstech/flutter-custom-paint-tutorial-build-a-radial-progress-6f80483494df

  double percentage;
  double newPercentage = 0.0;
  AnimationController percentageAnimationController;

  startTimeout() {
    Timer.periodic(Duration(seconds: 1), handleTimeout);
  }

  void handleTimeout(Timer timer) {
    if (newPercentage < 100) {
      publishProgress();
    } else {
      timer.cancel();
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      percentage = 0.0;
    });
    percentageAnimationController = new AnimationController(
      vsync: this,
      duration: new Duration(milliseconds: 1000),
    )..addListener(
        () {
          setState(
            () {
              percentage = lerpDouble(percentage, newPercentage,
                  percentageAnimationController.value);
            },
          );
        },
      );

    startTimeout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(20.0),
        child: new CustomPaint(
          child: Center(
            child: Text(
              '$newPercentage',
              style: TextStyle(fontSize: 20),
            ),
          ),
          foregroundPainter: new MyPainter(
              lineColor: Colors.amber,
              completeColor: Colors.blueAccent,
              completePercent: percentage,
              width: 8.0),
        ),
      ),
    );
  }

  void publishProgress() {
    print('Per $newPercentage');
    setState(() {
      percentage = newPercentage;
      newPercentage += 10;
      if (newPercentage > 100.0) {
        percentage = 0.0;
        newPercentage = 0.0;
      }
      percentageAnimationController.forward(from: 0.0);
    });
  }
}
