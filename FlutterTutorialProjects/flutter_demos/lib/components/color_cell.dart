import 'package:flutter/material.dart';
import 'package:flutter_demos/utils/app_settings.dart';
import 'package:provider/provider.dart';

class ColorCell extends StatelessWidget {
  //
  ColorCell({this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 72,
      height: 72,
      decoration: BoxDecoration(color: color),
      child: context.watch<AppSettings>().appColor == color
          ? Icon(
              Icons.check_circle,
              color: Colors.white,
            )
          : SizedBox(),
    );
  }
}
