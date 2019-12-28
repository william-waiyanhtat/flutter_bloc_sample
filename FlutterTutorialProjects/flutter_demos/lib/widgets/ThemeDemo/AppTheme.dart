import 'package:flutter/material.dart';

class AppTheme {
  //
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.green,
    appBarTheme: AppBarTheme(
      color: Colors.green,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      textTheme: TextTheme(
        title: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
        subtitle: TextStyle(
          color: Colors.black,
          fontSize: 18.0,
        ),
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: Colors.green,
      onPrimary: Colors.green,
      primaryVariant: Colors.green[100],
      secondary: Colors.red,
    ),
    iconTheme: IconThemeData(
      color: Colors.amber,
    ),
    textTheme: TextTheme(
      title: TextStyle(
        color: Colors.black,
        fontSize: 20.0,
      ),
      subtitle: TextStyle(
        color: Colors.black,
        fontSize: 18.0,
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      color: Colors.black,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      textTheme: TextTheme(
        title: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
        subtitle: TextStyle(
          color: Colors.black,
          fontSize: 18.0,
        ),
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: Colors.green,
      onPrimary: Colors.green,
      primaryVariant: Colors.green[100],
      secondary: Colors.red,
    ),
    cardTheme: CardTheme(
      color: Colors.purple,
    ),
    iconTheme: IconThemeData(
      color: Colors.amber,
    ),
    textTheme: TextTheme(
      title: TextStyle(
        color: Colors.green,
        fontSize: 20.0,
      ),
      subtitle: TextStyle(
        color: Colors.black,
        fontSize: 18.0,
      ),
    ),
  );
}
