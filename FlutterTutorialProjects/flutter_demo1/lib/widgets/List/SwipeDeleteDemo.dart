import 'dart:math';

import 'package:flutter/material.dart';

class SwipeDeleteDemo extends StatefulWidget {
  SwipeDeleteDemo() : super();

  final String title = "Filter List Demo";

  @override
  SwipeDeleteDemoState createState() => SwipeDeleteDemoState();
}

class SwipeDeleteDemoState extends State<SwipeDeleteDemo> {
  int lastCount = 0;
  GlobalKey<RefreshIndicatorState> refreshKey =
      GlobalKey<RefreshIndicatorState>();

  List<String> items = List();

  @override
  void initState() {
    super.initState();
    lastCount = items.length;
    items.add("Google");
    items.add("Apple");
    items.add("Samsung");
    items.add("Sony");
    items.add("LG");
  }

  Future<void> refreshList() async {
    refreshKey.currentState?.show(atTop: true);
    await Future.delayed(Duration(seconds: 1));
    Random r = new Random();
    int nextCount = r.nextInt(100);
    setState(() {
      items.add("Compnay $nextCount");
    });
    refreshKey.currentState?.show(atTop: false);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: RefreshIndicator(
              key: refreshKey,
              onRefresh: () async {
                await refreshList();
              },
              child: ListView.builder(
                padding: EdgeInsets.all(20.0),
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  return Dismissible(
                    key: Key(UniqueKey().toString()),
                    onDismissed: (direction) {
                      setState(() {
                        items.removeAt(index);
                      });
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text(
                            'Item at index $index deleted \nDirection: $direction'),
                      ));
                    },
                    background: Container(
                      color: Colors.red,
                    ),
                    child: Card(
                      child: ListTile(
                        title: Text(items[index]),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
