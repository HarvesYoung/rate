
import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  splashFactory: NoSplash.splashFactory,
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  brightness: Brightness.dark,
  primarySwatch: Colors.teal,
  scaffoldBackgroundColor: Colors.black,
  colorScheme: const ColorScheme.dark(
    primaryContainer: Colors.black,
    primaryFixed: Colors.white,
    onSurface: Colors.grey,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black
  ),
  iconTheme: const IconThemeData(
    color: Colors.white
  ),
  textTheme: TextTheme(
    bodyMedium: const TextStyle().copyWith(
      fontSize: 14,
      color: Colors.white
    ),
    bodySmall: const TextStyle().copyWith(
      fontSize: 10,
      color: Colors.white
    )
  )
);