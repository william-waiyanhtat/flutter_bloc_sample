import 'package:flutter/material.dart';
import 'User.dart';
import 'Services.dart';
import 'Failures.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen() : super();

  final String title = "Error Demo";

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  //
  Future<List<User>> users;

  @override
  void initState() {
    super.initState();
    users = Services.getUsers();
  }

  list() {
    return FutureBuilder(
      future: users,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<User> users = snapshot.data;
          return Column(
            children: users.map((user) => Text(user.name)).toList(),
          );
        }
        if (snapshot.hasError) {
          if (snapshot.error is InternetFailureException) {
            InternetFailureException internetFailureException =
                snapshot.error as InternetFailureException;
            return showError(internetFailureException.message);
          }
          if (snapshot.error is ServiceNotFoundException) {
            ServiceNotFoundException serviceNotFoundException =
                snapshot.error as ServiceNotFoundException;
            return showError(serviceNotFoundException.message);
          }
          if (snapshot.error is InvalidDataFormatException) {
            InvalidDataFormatException invalidDataFormatException =
                snapshot.error as InvalidDataFormatException;
            return showError(invalidDataFormatException.message);
          }
          UncaughtError uncaughtError = snapshot.error as UncaughtError;
          return showError(uncaughtError.message);
        }
        return CircularProgressIndicator();
      },
    );
  }

  Widget showError(String message) {
    return Center(
      child: Text(
        message,
        style: TextStyle(color: Colors.grey, fontSize: 20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          list(),
        ],
      ),
    );
  }
}
