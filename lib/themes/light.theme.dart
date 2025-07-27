
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  splashFactory: NoSplash.splashFactory,
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    primaryContainer: Colors.white,
    primaryFixed: Colors.black87
    // secondaryContainer: Colors.grey
    // onSurface: Colors.black87
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white38,
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
    ),
  ),
);