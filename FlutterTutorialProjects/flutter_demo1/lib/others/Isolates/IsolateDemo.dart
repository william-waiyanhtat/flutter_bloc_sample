import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PerformancePage extends StatefulWidget {
  @override
  _PerformancePageState createState() => _PerformancePageState();
}

class _PerformancePageState extends State<PerformancePage> {
  //
  Future<void> computeFuture = Future.value();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Performance using Isolate'),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SmoothAnimationWidget(),
              Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.only(top: 150),
                child: Column(
                  children: [
                    addButton1(),
                    addButton2(),
                    OutlineButton(
                        child: const Text('Secondary Isolate'),
                        onPressed: () {}),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  addButton1() {
    return FutureBuilder<void>(
      future: computeFuture,
      builder: (context, snapshot) {
        return OutlineButton(
          child: const Text('Main Isolate'),
          onPressed: createMainIsolateCallBack(context, snapshot),
        );
      },
    );
  }

  addButton2() {
    return FutureBuilder<void>(
      future: computeFuture,
      builder: (context, snapshot) {
        return OutlineButton(
          child: const Text('Secondary Isolate'),
          onPressed: createSecondaryIsolateCallBack(context, snapshot),
        );
      },
    );
  }

  VoidCallback createMainIsolateCallBack(
      BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.connectionState == ConnectionState.done) {
      return () {
        setState(() {
          computeFuture = computeOnMainIsolate()
            ..then((val) {
              showSnackBar(context, 'Main Isolate Done. $val');
            });
        });
      };
    } else {
      return null;
    }
  }

  VoidCallback createSecondaryIsolateCallBack(
      BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.connectionState == ConnectionState.done) {
      return () {
        setState(() {
          computeFuture = computeOnSecondaryIsolate()
            ..then((val) {
              showSnackBar(context, 'Secondary Isolate Done. $val');
            });
        });
      };
    } else {
      return null;
    }
  }
}

showSnackBar(context, message) {
  Scaffold.of(context).showSnackBar(SnackBar(
    content: Text(message),
  ));
}

Future<int> computeOnMainIsolate() async {
  // The isolate will need a little time to disable the buttons before the performance hit.
  return await Future.delayed(Duration(milliseconds: 100), () => fib(50));
  // await Future(() => fib(45));
}

Future<int> computeOnSecondaryIsolate() async {
  return await compute(fib, 50);
}

int fib(int n) {
  int number1 = n - 1;
  int number2 = n - 2;

  if (1 == n) {
    return 0;
  } else if (0 == n) {
    return 1;
  } else {
    return (fib(number1) + fib(number2));
  }
}

class SmoothAnimationWidget extends StatefulWidget {
  @override
  SmoothAnimationWidgetState createState() => SmoothAnimationWidgetState();
}

class SmoothAnimationWidgetState extends State<SmoothAnimationWidget>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<BorderRadius> borderRadius;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this)
          ..addStatusListener(
            (status) {
              if (status == AnimationStatus.completed) {
                _controller.reverse();
              } else if (status == AnimationStatus.dismissed) {
                _controller.forward();
              }
            },
          );

    borderRadius = BorderRadiusTween(
      begin: BorderRadius.circular(100.0),
      end: BorderRadius.circular(0.0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: borderRadius,
      builder: (context, child) {
        return Center(
          child: Container(
            child: FlutterLogo(
              size: 200,
            ),
            alignment: Alignment.bottomCenter,
            width: 350,
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                colors: [Colors.blueAccent, Colors.redAccent],
              ),
              borderRadius: borderRadius.value,
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
