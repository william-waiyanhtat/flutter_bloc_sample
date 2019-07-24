import 'package:flutter/material.dart';
import 'dart:async';
import 'Services.dart';
import '../../models/users.dart';

class UserListDemo extends StatefulWidget {
  UserListDemo() : super();

  final String title = "Filter List Demo";

  @override
  UserListDemoState createState() => UserListDemoState();
}

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class UserListDemoState extends State<UserListDemo> {
  // https://jsonplaceholder.typicode.com/users

  final _debouncer = Debouncer(milliseconds: 500);
  Users users;
  bool searching;
  String title;

  @override
  void initState() {
    super.initState();
    searching = false;
    title = "Loading users...";
    users = Users();
    Services.getUsers().then((usersFromServer) {
      setState(() {
        users = usersFromServer;
        title = widget.title;
      });
    });
  }

  Widget list() {
    return Expanded(
      child: ListView.builder(
        itemCount: users.users == null ? 0 : users.users.length,
        itemBuilder: (BuildContext context, int index) {
          return row(index);
        },
      ),
    );
  }

  Widget searchTF() {
    return TextField(
      decoration: InputDecoration(
        border: new OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(5.0),
          ),
        ),
        filled: true,
        fillColor: Colors.white70,
        contentPadding: EdgeInsets.all(15.0),
        hintText: 'Filter by name or email',
      ),
      onChanged: (string) {
        _debouncer.run(() {
          setState(() {
            title = "Searching...";
          });
          Services.getUsers().then((usersFromServer) {
            searching = true;
            setState(() {
              users = Users.filterList(usersFromServer, string);
              title = widget.title;
            });
          });
        });
      },
    );
  }

  Widget row(int index) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              users.users[index].name,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              users.users[index].email.toLowerCase(),
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            searchTF(),
            SizedBox(
              height: 10.0,
            ),
            list(),
          ],
        ),
      ),
    );
  }
}
