import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  primaryColor: Colors.white,
  backgroundColor: Colors.black,
);
ThemeData darkTheme = ThemeData(
  primaryColor: Color.fromRGBO(26, 26, 26, 1),
  backgroundColor: Colors.white,
  canvasColor: Color.fromRGBO(40, 40, 40, 1),
  textTheme: TextTheme(
    titleLarge: TextStyle(
        color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
    titleSmall: TextStyle(color: Colors.white),
    titleMedium: TextStyle(color: Colors.white),
    bodySmall: TextStyle(color: Colors.white),
  ),
);

IconThemeData iconThemeDark = IconThemeData(color: Colors.black);
IconThemeData iconThemeLight = IconThemeData(color: Colors.white);
