import 'package:flutter/material.dart';
import 'package:memstuff/core/app_const.dart';

final kAppTheme = ThemeData(
  primarySwatch: Colors.indigo,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  fontFamily: 'Montserrat',
  scaffoldBackgroundColor: Color.fromRGBO(217, 217, 217, 1),
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
