
import 'package:flutter/material.dart';


final Color commonBackgroundColor = Colors.grey.shade50;

ThemeData lightTheme = ThemeData(
  splashFactory: NoSplash.splashFactory,
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  scaffoldBackgroundColor: commonBackgroundColor,
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    primaryContainer: Colors.white,
    primaryFixed: Colors.black87
    // secondaryContainer: Colors.grey
    // onSurface: Colors.black87
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: commonBackgroundColor,
  ),
  iconTheme: const IconThemeData(
    color: Colors.black26
  ),
  textTheme: TextTheme(
    bodyMedium: const TextStyle().copyWith(
      fontSize: 14,
      color: Colors.black87
    ),
    bodySmall: const TextStyle().copyWith(
      fontSize: 10,
      color: Colors.grey
    )
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: commonBackgroundColor,
  ),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      overlayColor: WidgetStateColor.transparent,
      elevation: WidgetStatePropertyAll(0)
    )
  )
);