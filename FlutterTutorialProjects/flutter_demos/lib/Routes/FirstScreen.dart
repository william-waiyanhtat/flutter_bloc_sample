import 'package:flutter/material.dart';
import 'package:flutter_demos/Routes/SecondScreen.dart';
import 'ScreenArguments.dart';

class FirstScreen extends StatelessWidget {
  //
  static const routeName = 'FirstScreen';
  final TextEditingController _controllerTitle = TextEditingController();
  final TextEditingController _controllerMessage = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Screen'),
      ),
      body: Builder(
        builder: (context) => Column(
          children: <Widget>[
            TextField(
              controller: _controllerTitle,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(15.0),
                hintText: 'Enter Title',
              ),
            ),
            TextField(
              controller: _controllerMessage,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(15.0),
                hintText: 'Enter Message',
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(
              child: Text('Launch screen (Normal)'),
              onPressed: () => buttonTap1(context),
            ),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(
              child: Text('Launch named (Named Route))'),
              onPressed: () => buttonTap2(context),
            ),
          ],
        ),
      ),
    );
  }

  buttonTap1(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SecondScreen(),
        settings: RouteSettings(
          arguments: ScreenArguments(
            _controllerTitle.text,
            _controllerMessage.text,
          ),
        ),
      ),
    );
    showSnackBar(context, result);
  }

  buttonTap2(BuildContext context) async {
    final result = await Navigator.pushNamed(
      context,
      SecondScreen.routeName,
      arguments: ScreenArguments(
        _controllerTitle.text,
        _controllerMessage.text,
      ),
    );
    showSnackBar(context, result);
  }

  showSnackBar(context, result) {
    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text("$result")));
  }
}
