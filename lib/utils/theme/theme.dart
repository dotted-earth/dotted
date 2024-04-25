import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
  static const _useMaterial3 = true;

  static ThemeData lightTheme = ThemeData(
    useMaterial3: _useMaterial3,
    brightness: Brightness.light,
    colorSchemeSeed: Colors.purple,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: _useMaterial3,
    brightness: Brightness.dark,
    colorSchemeSeed: Colors.blue,
  );
}
