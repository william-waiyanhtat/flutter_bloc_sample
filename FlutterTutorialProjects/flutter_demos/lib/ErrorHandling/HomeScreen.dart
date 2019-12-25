import 'package:flutter/material.dart';
import 'package:flutter_demos/ErrorHandling/Exceptions.dart';
import 'Services.dart';
import 'User.dart';

class HomeScreen extends StatefulWidget {
  //
  HomeScreen() : super();

  final String title = "Error Handling Demo";

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
          if (users.isEmpty) {
            return showError('No Users');
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: users
                .map(
                  (user) => Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      user.name,
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                )
                .toList(),
          );
        }
        if (snapshot.hasError) {
          if (snapshot.error is NoInternetException) {
            NoInternetException noInternetException =
                snapshot.error as NoInternetException;
            return showError(noInternetException.message);
          }
          if (snapshot.error is NoServiceFoundException) {
            NoServiceFoundException noServiceFoundException =
                snapshot.error as NoServiceFoundException;
            return showError(noServiceFoundException.message);
          }
          if (snapshot.error is InvalidFormatException) {
            InvalidFormatException invalidFormatException =
                snapshot.error as InvalidFormatException;
            return showError(invalidFormatException.message);
          }
          UnknownException unknownException =
              snapshot.error as UnknownException;
          return showError(unknownException.message);
        }
        return CircularProgressIndicator();
      },
    );
  }

  Widget showError(message) {
    return Center(
      child: Text(message),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: list(),
    );
  }
}
