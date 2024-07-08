import 'package:flutter/material.dart';

// * light theme
// todo
ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'EBGaramond',
  // bottom background color
  scaffoldBackgroundColor: Color.fromARGB(255, 136, 236, 140),
  colorScheme: const ColorScheme.light(
    // top background color
    background: Color.fromARGB(255, 157, 255, 157),
    // bottom watchlist background color
    primary: Color.fromARGB(255, 103, 12, 12),
    // top watchlist background color
    secondary: Color.fromARGB(255, 57, 0, 0),
    // basic text; watchlist/popup
    tertiary: Color(0xFFFFFFFF),
  ),
  // watchlist divider
  dividerColor: const Color.fromARGB(255, 255, 0, 0),
  textTheme: const TextTheme(
    // header font
    headlineMedium: TextStyle(
      color: Color.fromARGB(255, 3, 46, 4),
    ),
    // display text
    bodyMedium: TextStyle(
      color: Color.fromARGB(255, 3, 46, 4),
    ),
    // bear red
    bodySmall: TextStyle(
      color: Color.fromARGB(255, 255, 147, 147),
    ),
    // bull green
    bodyLarge: TextStyle(
      color: Color.fromARGB(255, 162, 255, 167),
    ),
  ),
  // text input field untouched - home page
  hintColor: const Color.fromARGB(255, 3, 46, 4),
  // ticker symbol input field - home page
  inputDecorationTheme: const InputDecorationTheme(
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromARGB(255, 154, 255, 154),
      ),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromARGB(255, 7, 88, 7),
      ),
    ),
  ),
  // buttons
  buttonTheme: const ButtonThemeData(
    colorScheme: ColorScheme.light(
      background: Color(0xFF0D47A1),
      primary: Color(0xFF81D4FA),
      secondary: Color(0xFFE1F5FE),
    ),
  ),
  // slider - ticker page & settings
  sliderTheme: const SliderThemeData(
    thumbColor: Color(0xFF0D47A1),
    activeTrackColor: Color(0xFF2196F3),
    inactiveTrackColor: Color(0xFF1A237E),
    disabledThumbColor: Color(0xFF0D47A1),
    disabledActiveTrackColor: Color(0xFF2196F3),
    disabledInactiveTrackColor: Color(0xFF2196F3),
  ),
  // dropdown - quantity reminders in settings
  dropdownMenuTheme: const DropdownMenuThemeData(
    inputDecorationTheme: InputDecorationTheme(
      iconColor: Color(0xFF1A237E),
      fillColor: Color(0xFFB3E5FC),
    ),
  ),
  // radio buttons in settings
  radioTheme: RadioThemeData(fillColor:
      MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
    return const Color(0xFF1A237E);
  })),
  // icons
  iconTheme: const IconThemeData(
    color: Color.fromARGB(255, 3, 46, 4),
  ),
  // border; popup/tickerPage
  cardTheme: const CardTheme(
    color: Color(0xFF2962FF),
  ),
  // popup displays
  dialogTheme: const DialogTheme(
    backgroundColor: Color.fromARGB(255, 255, 48, 48),
  ),
);

// * dark theme
ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'EBGaramond',
  // bottom background color
  scaffoldBackgroundColor: const Color.fromARGB(255, 21, 75, 20),
  colorScheme: const ColorScheme.dark(
    // top background color
    background: Color.fromARGB(124, 125, 182, 76),
    // bottom watchlist background color
    primary: Color.fromARGB(255, 103, 12, 12),
    // top watchlist background color
    secondary: Color.fromARGB(255, 57, 0, 0),
    // basic text; watchlist/popup
    tertiary: Color.fromARGB(255, 255, 255, 255),
  ),
  // watchlist divider
  dividerColor: const Color.fromARGB(255, 170, 8, 8),
  textTheme: const TextTheme(
    // header font
    headlineMedium: TextStyle(
      color: Color.fromARGB(255, 208, 255, 208),
    ),
    // display text
    bodyMedium: TextStyle(
      color: Color.fromARGB(255, 208, 255, 208),
    ),
    // bear red
    bodySmall: TextStyle(
      color: Color.fromARGB(255, 255, 129, 129),
    ),
    // bull green
    bodyLarge: TextStyle(
      color: Color.fromARGB(255, 162, 255, 167),
    ),
  ),
  // text input field untouched - home page
  hintColor: const Color.fromARGB(255, 208, 255, 208),
  // ticker symbol input field - home page
  inputDecorationTheme: const InputDecorationTheme(
    // text field selected
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromARGB(255, 208, 255, 208),
      ),
    ),
    // text field not selected
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromARGB(255, 154, 255, 154),
      ),
    ),
  ),
  // buttons
  buttonTheme: const ButtonThemeData(
    colorScheme: ColorScheme.light(
      background: Color.fromARGB(255, 0, 0, 0),
      primary: Color.fromARGB(255, 4, 160, 67),
      secondary: Colors.white,
    ),
  ),
  // slider - ticker page & settings
  sliderTheme: const SliderThemeData(
    thumbColor: Color.fromARGB(255, 83, 219, 83),
    activeTrackColor: Color.fromARGB(255, 208, 255, 208),
    inactiveTrackColor: Color.fromARGB(255, 114, 178, 114),
    disabledThumbColor: Color.fromARGB(255, 83, 219, 83),
    disabledActiveTrackColor: Color.fromARGB(255, 208, 255, 208),
    disabledInactiveTrackColor: Color.fromARGB(255, 114, 178, 114),
  ),
  // dropdown - quantity reminders in settings
  dropdownMenuTheme: const DropdownMenuThemeData(
    inputDecorationTheme: InputDecorationTheme(
      iconColor: Color.fromARGB(255, 208, 255, 208),
      fillColor: Color.fromARGB(255, 0, 0, 0),
    ),
  ),
  // radio buttons in settings
  radioTheme: RadioThemeData(fillColor:
      MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
    return const Color.fromARGB(255, 208, 255, 208);
  })),
  // icons
  iconTheme: const IconThemeData(
    color: Color.fromARGB(255, 208, 255, 208),
  ),
  // border; popup/tickerPage
  cardTheme: const CardTheme(
    color: Color(0xFFE0E0E0),
  ),
  // popup displays
  dialogTheme: const DialogTheme(
    backgroundColor: Color.fromARGB(255, 25, 112, 23),
  ),
);
