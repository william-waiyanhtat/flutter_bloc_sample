import 'package:flutter/material.dart';

class Retry extends StatelessWidget {
  //
  final String message;
  final Function onTap;

  Retry({this.message, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          SizedBox(height: 10),
          RaisedButton(
            child: Text('Tap to Retry'),
            onPressed: onTap,
          ),
        ],
      ),
    );
  }
}
