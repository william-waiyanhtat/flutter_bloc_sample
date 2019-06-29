import 'dart:math';

import 'package:flutter/material.dart';

class SwipeDeleteDemo extends StatefulWidget {
  SwipeDeleteDemo() : super();

  final String title = "Refresh/Swipe Delete Demo";

  @override
  SwipeDeleteDemoState createState() => SwipeDeleteDemoState();
}

class SwipeDeleteDemoState extends State<SwipeDeleteDemo> {
  GlobalKey<RefreshIndicatorState> refreshKey =
      GlobalKey<RefreshIndicatorState>();

  List<String> items;

  @override
  void initState() {
    super.initState();
    addItems();
  }

  addItems() {
    items = List();
    items.add("Google");
    items.add("Apple");
    items.add("Samsung");
    items.add("Sony");
    items.add("LG");
  }

  showProgress(bool show) {
    refreshKey.currentState?.show(atTop: show);
  }

  addRandomCompany() {
    Random r = new Random();
    int nextCount = r.nextInt(100);
    setState(() {
      items.add("Company $nextCount");
    });
  }

  undoDelete(index, item) {
    setState(() {
      items.insert(index, item);
    });
  }

  Widget refreshBg() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20.0),
      color: Colors.red,
      child: const Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }

  Future<void> refreshList() async {
    showProgress(true);
    await Future.delayed(Duration(seconds: 1));
    addRandomCompany();
    showProgress(false);
    return null;
  }

  Widget list() {
    return ListView.builder(
      padding: EdgeInsets.all(20.0),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          key: Key(items[index]), //UniqueKey().toString()
          onDismissed: (direction) {
            var item = items[index];
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('$item deleted'),
              action: SnackBarAction(
                label: "UNDO",
                onPressed: () {
                  undoDelete(index, item);
                },
              ),
            ));
            setState(() {
              items.removeAt(index);
            });
          },
          background: refreshBg(),
          child: Card(
            child: ListTile(
              title: Text(items[index]),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: RefreshIndicator(
        key: refreshKey,
        onRefresh: () async {
          await refreshList();
        },
        child: list(),
      ),
    );
  }
}
