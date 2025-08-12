import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:rate/configs/custom_routes_config.dart';

class App extends HookWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {

    final Color commonBackgroundColor = Colors.grey.shade50;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        splashFactory: NoSplash.splashFactory,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        scaffoldBackgroundColor: commonBackgroundColor,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: commonBackgroundColor,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: commonBackgroundColor,
        )
      ),
      routes: customRoutesConfig,
      initialRoute: '/',
      navigatorObservers: [],
    );
  }
}