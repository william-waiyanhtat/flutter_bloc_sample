import 'dart:async';

import 'package:flutter/material.dart';
import 'user.dart';
import 'services.dart';

class BooksList extends StatefulWidget {
  BooksList() : super();

  final String title = "User List Demo";

  @override
  BooksListState createState() => BooksListState();
}

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (_timer != null) {
      _timer.cancel();
    }

    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class BooksListState extends State<BooksList> {
  //
  final _debouncer = Debouncer(milliseconds: 500);
  List<User> users = List();
  List<User> filtereredUsers = List();

  @override
  void initState() {
    super.initState();
    Services.getPhotos().then((usersFromServer) {
      setState(() {
        users = usersFromServer;
        filtereredUsers = users;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users List'),
      ),
      body: Column(
        children: <Widget>[
          new TextField(
            decoration: new InputDecoration(
              contentPadding: EdgeInsets.all(10.0),
              hintText: 'Enter name or email',
            ),
            onChanged: (string) {
              _debouncer.run(() => {
                    setState(() {
                      filtereredUsers =
                          users.where((u) => u.name.contains(string)).toList();
                    })
                  });
            },
          ),
          new Expanded(
            child: new ListView.builder(
              padding: new EdgeInsets.all(8.0),
              itemCount: filtereredUsers.length,
              itemBuilder: (BuildContext context, int index) {
                return new Card(
                  child: new Padding(
                    padding: new EdgeInsets.all(10.0),
                    child: new Row(
                      children: <Widget>[
                        new Text(filtereredUsers[index].name, maxLines: 2),
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
