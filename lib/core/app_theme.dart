import 'package:flutter/material.dart';
import 'package:memstuff/core/app_const.dart';

final kAppTheme = ThemeData(
  primarySwatch: Colors.red,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  scaffoldBackgroundColor: Color.fromRGBO(150, 150, 120, 1),
  buttonTheme: ButtonThemeData(
    textTheme: ButtonTextTheme.primary,
  ),
  textTheme: TextTheme(
    button: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: kButtonFontSize,
      letterSpacing: kButtonLetterSpacing,
    ),
  ),
);
