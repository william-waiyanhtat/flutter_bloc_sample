import 'package:flutter/material.dart';

class Tip3 extends StatefulWidget {
  Tip3() : super();

  final String title = "Transform Demo";

  @override
  Tip3State createState() => Tip3State();
}

class Tip3State extends State<Tip3> {
  double sliderVal = 0.0;

  @override
  initState() {
    super.initState();
    sliderVal = 0.0;
  }

  Container rotate() {
    return Container(
      child: Transform.rotate(
        angle: sliderVal,
        origin: Offset(0.0, 0.0),
        child: Container(
          height: 50.0,
          width: 50.0,
          color: Colors.red,
        ),
      ),
    );
  }

  Container scale() {
    return Container(
      child: Transform.scale(
        scale: sliderVal == 0 ? 1 : sliderVal / 50,
        origin: Offset(0.0, 0.0),
        child: Container(
          height: 100.0,
          width: 100.0,
          color: Colors.green,
        ),
      ),
    );
  }

  Container translate() {
    return Container(
      child: Transform.translate(
        offset: Offset(200.0, 110.0),
        child: Container(
          height: 100.0,
          width: 100.0,
          color: Colors.yellow,
        ),
      ),
    );
  }

  skew() {
    return Container(
      child: Transform(
        transform: Matrix4.skewX(sliderVal / 100),
        child: Container(
          height: 100.0,
          width: 100.0,
          color: Colors.blue,
        ),
      ),
    );
  }

  threeD() {
    return Container(
      child: Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, sliderVal / 1000)
          ..rotateX(3.14 / 20.0),
        alignment: FractionalOffset.center,
        child: Container(
          height: 100.0,
          width: 100.0,
          color: Colors.blue,
        ),
      ),
    );
  }

  Slider slider() {
    return Slider(
      value: sliderVal,
      min: 0,
      max: 100.0,
      onChanged: (val) {
        setState(() {
          sliderVal = val;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          slider(),
          skew(),
          rotate(),
          scale(),
          threeD(),
        ],
      ),
    );
  }
}
