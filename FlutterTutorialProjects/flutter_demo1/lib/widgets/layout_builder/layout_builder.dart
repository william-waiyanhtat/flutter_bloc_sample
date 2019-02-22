import 'package:flutter/material.dart';

class LayoutBuilderDemo extends StatefulWidget {
  LayoutBuilderDemo() : super();

  final String title = "Phone-Tablet Layout Demo";

  @override
  LayoutBuilderDemoState createState() => LayoutBuilderDemoState();
}

class LayoutBuilderDemoState extends State<LayoutBuilderDemo> {
  //

  gridviewForPhone() {
    //Orientation orientation) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: GridView.count(
        crossAxisCount: 2, //orientation == Orientation.portrait ? 2 : 4,
        childAspectRatio: 1.0,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        children: List.generate(100, (index) {
          return Card(
            child: Container(
              alignment: Alignment.center,
              color: Colors.red[100 * (index % 9)],
              child: Text('$index'),
            ),
          );
        }),
      ),
    );
  }

  gridviewForTablet() {
    //Orientation orientation) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: GridView.count(
        crossAxisCount: 4, //orientation == Orientation.portrait ? 2 : 6,
        childAspectRatio: 1.0,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        children: List.generate(100, (index) {
          return Card(
            child: Container(
              alignment: Alignment.center,
              color: Colors.green[100 * (index % 9)],
              child: Text('$index'),
            ),
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double shorterSide = MediaQuery.of(context).size.shortestSide;
    final bool useMobileLayout = shorterSide < 600.0;
    final Orientation orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      // body: useMobileLayout
      //     ? gridviewForPhone(orientation)
      //     : gridviewForTablet(orientation),
      body: SafeArea(child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth < 600.0)
            return gridviewForPhone();
          else {
            return gridviewForTablet();
          }
        },
      )),
    );
  }
}
