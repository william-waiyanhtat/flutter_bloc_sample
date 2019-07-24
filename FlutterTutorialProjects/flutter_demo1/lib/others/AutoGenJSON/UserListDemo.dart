import 'package:flutter/material.dart';
import 'dart:async';
import '../../models/user.dart';
import 'Services.dart';

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
  List<User> users = List();
  bool searching;
  String title;

  @override
  void initState() {
    super.initState();
    searching = false;
    title = widget.title;
    Services.getUsers().then((usersFromServer) {
      setState(() {
        users = usersFromServer;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
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
                    users = usersFromServer
                        .where((u) => (u.name
                                .toLowerCase()
                                .contains(string.toLowerCase()) ||
                            u.email
                                .toLowerCase()
                                .contains(string.toLowerCase())))
                        .toList();
                    title = widget.title;
                  });
                });
              });
            },
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemCount: users.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          users[index].name,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          users[index].email.toLowerCase(),
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
