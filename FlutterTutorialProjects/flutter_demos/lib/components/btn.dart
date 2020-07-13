import 'package:flutter/material.dart';

class Btn extends StatelessWidget {
  //
  Btn({this.btnTitle, this.onPress, this.color});

  final String btnTitle;
  final Function onPress;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: FlatButton(
        padding: EdgeInsets.all(12),
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(3.0)),
        child: Text(
          btnTitle.toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        onPressed: onPress,
        color: color,
      ),
    );
  }
}
