import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/animation.dart';

class AnimatedLogo extends AnimatedWidget {
  AnimatedLogo({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        height: animation.value,
        width: animation.value,
        child: FlutterLogo(),
      ),
    );
  }
}

class Tip7 extends StatefulWidget {
  Tip7() : super();

  final String title = "Flutter Tips";

  @override
  Tip7State createState() => Tip7State();
}

// #docregion print-state
class Tip7State extends State<Tip7> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: 0, end: 300).animate(controller)
      // #enddocregion print-state
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      })
      // #docregion print-state
      ..addStatusListener((state) => print('$state'));
    controller.forward();
  }
  // #enddocregion print-state

  @override
  Widget build(BuildContext context) => AnimatedLogo(animation: animation);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  // #docregion print-state
}

/*
class Tip7State extends State<Tip7> {
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: <Widget>[
                AnimatedPositioned(
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.red,
                  ),
                  duration: Duration(
                    seconds: 5,
                  ),
                  curve: Curves.bounceIn,
                )
              ],
            ),
            // Tooltip(
            //   message: "Hello World",
            //   child: new Text("This is a tooltip"),
            // ),
            // FadeInImage.assetNetwork(
            //   placeholder: 'images/loading.gif',
            //   image:
            //       'https://images.freeimages.com/images/large-previews/322/indian-heads-1391201.jpg',
            // ),
            // SizedBox(
            //   height: 20.0,
            // ),
            // CachedNetworkImage(
            //   placeholder: (context, url) => Center(
            //         child: CircularProgressIndicator(),
            //       ),
            //   imageUrl:
            //       'https://images.freeimages.com/images/large-previews/7e9/ladybird-1367182.jpg',
            // )
          ],
        ),
      ),
    );
  }
}
*/
