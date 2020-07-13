import 'dart:io';

import 'package:flutter/material.dart';

class LinkBtn extends StatelessWidget {
  LinkBtn({this.onPress, this.btnTitle});

  final String btnTitle;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
        child: Text(btnTitle),
        onPressed: onPress,
      ),
    );
  }
}
