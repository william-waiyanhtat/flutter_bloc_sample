import 'package:flutter/material.dart';
import 'user.dart';
import 'state_container.dart';
import 'myform.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => new HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  User user;

  void openForm(BuildContext context) {
    Navigator.push(
      context,
      new MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) {
          return new FormScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final container = StateContainer.of(context);
    user = container.user;
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Inherited Widget Test'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: <Widget>[
             user != null ? Text("Name is ${user.name}") : Text("No Name"),
             SizedBox(height: 50,),
             RaisedButton(child: Text("Enter name"),
             onPressed:(){
                openForm(context);
             } )
           ],
        ),
      )
    );
  }
}