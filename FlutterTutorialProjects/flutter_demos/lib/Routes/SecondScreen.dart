import 'package:flutter/material.dart';
import 'ScreenArguments.dart';

class SecondScreen extends StatelessWidget {
  //
  static const routeName = 'SecondScreen';

  final String title;
  final String message;
  SecondScreen({this.title, this.message});

  //
  final TextEditingController _controllerTitle = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        //title: Text(null == args ? '' : args.title),
        title: Text(null == title ? '' : title),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: _controllerTitle,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(15.0),
              hintText: 'Enter something',
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          //Text(null == args ? '' : args.message),
          Text(null == message ? '' : message),
          SizedBox(
            height: 20.0,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.pop(context, _controllerTitle.text);
            },
            child: Text('Go back!'),
          ),
        ],
      ),
    );
  }
}
