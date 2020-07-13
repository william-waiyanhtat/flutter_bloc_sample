import 'package:flutter/material.dart';

class AppSettings extends ChangeNotifier {
  //
  Color _appColor = Colors.teal;

  Color get appColor => _appColor;

  static List<Color> colors = [
    Colors.black87,
    Colors.blue,
    Colors.purple,
    Colors.indigo,
    Colors.green,
    Colors.teal,
    Colors.red,
    Colors.amber,
    Colors.orange,
    Colors.brown,
    Colors.deepOrange,
  ];

  void updateColorTheme(int index) {
    _appColor = colors[index];
    notifyListeners();
  }
}
