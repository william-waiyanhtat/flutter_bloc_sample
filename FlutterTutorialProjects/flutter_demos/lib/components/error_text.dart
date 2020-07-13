import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  //
  ErrorText({this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: null != text,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10.0),
        child: Text(
          null != text ? text : '',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
