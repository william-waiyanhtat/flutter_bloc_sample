import 'dart:math';

import 'package:flutter/material.dart';

class SwipeDeleteDemo extends StatefulWidget {
  SwipeDeleteDemo() : super();

  final String title = "Refresh/Swipe Delete Demo";

  @override
  SwipeDeleteDemoState createState() => SwipeDeleteDemoState();
}

class SwipeDeleteDemoState extends State<SwipeDeleteDemo> {
  //
  GlobalKey<RefreshIndicatorState> refreshKey;
  List<String> companies;
  Random r;

  @override
  void initState() {
    super.initState();
    refreshKey = GlobalKey<RefreshIndicatorState>();
    companies = List();
    r = new Random();
    addItems();
  }

  addItems() {
    companies.add("Google");
    companies.add("Apple");
    companies.add("Samsung");
    companies.add("Sony");
    companies.add("LG");
  }

  showProgress(bool show) {
    refreshKey.currentState?.show(atTop: show);
  }

  addRandomCompany() {
    int nextCount = r.nextInt(100);
    setState(() {
      companies.add("Company $nextCount");
    });
  }

  removeCompany(index) {
    setState(() {
      companies.removeAt(index);
    });
  }

  undoDelete(index, company) {
    setState(() {
      companies.insert(index, company);
    });
  }

  showSnackBar(context, item, index) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('$item deleted'),
      action: SnackBarAction(
        label: "UNDO",
        onPressed: () {
          undoDelete(index, item);
        },
      ),
    ));
  }

  Future<void> refreshList() async {
    showProgress(true);
    await Future.delayed(Duration(seconds: 1));
    addRandomCompany();
    showProgress(false);
    return null;
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

  Widget row(context, index) {
    return Dismissible(
      key: Key(companies[index]), // UniqueKey().toString()
      onDismissed: (direction) {
        var item = companies[index];
        showSnackBar(context, item, index);
        removeCompany(index);
      },
      background: refreshBg(),
      child: Card(
        child: ListTile(
          title: Text(companies[index]),
        ),
      ),
    );
  }

  Widget list() {
    return ListView.builder(
      padding: EdgeInsets.all(20.0),
      itemCount: companies.length,
      itemBuilder: (BuildContext context, int index) {
        return row(context, index);
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
