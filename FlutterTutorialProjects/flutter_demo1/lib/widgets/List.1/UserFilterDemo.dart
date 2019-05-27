import 'dart:async';

import 'package:flutter/material.dart';
import 'user.dart';
import 'services.dart';

class UserFilterDemo extends StatefulWidget {
  UserFilterDemo() : super();

  final String title = "User List Demo";

  @override
  UserFilterDemoState createState() => UserFilterDemoState();
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

class UserFilterDemoState extends State<UserFilterDemo> {
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
          TextField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10.0),
              hintText: 'Enter name or email',
            ),
            onChanged: (string) {
              print(string);
              _debouncer.run(() => {
                    setState(() {
                      filtereredUsers = users
                          .where((u) => (u.name
                                  .toLowerCase()
                                  .contains(string.toLowerCase()) ||
                              u.email
                                  .toLowerCase()
                                  .contains(string.toLowerCase())))
                          .toList();
                    })
                  });
            },
          ),
          new Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: filtereredUsers.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          filtereredUsers[index].name,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          filtereredUsers[index].email.toLowerCase(),
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 14,
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
