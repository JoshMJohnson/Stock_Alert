import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'EBGaramond',
    colorScheme: ColorScheme.light(
      background: Colors.grey.shade400,
      primary: Colors.grey.shade400,
      secondary: Colors.grey.shade400,
      tertiary: Colors.grey.shade400,
    ));

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'EBGaramond',
);
