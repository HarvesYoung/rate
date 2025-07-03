import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rate/configs/custom_routes_config.dart';
import 'package:rate/l10n/generated/app_localizations.dart';
import 'package:rate/providers/providers.dart';
import 'package:rate/themes/dark_theme.dart';
import 'package:rate/themes/light.theme.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// read the current locale
    final currentLocale = ref.watch(localeProvider);

    /// read the current color mode
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: currentLocale,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      routes: customRoutesConfig,
      initialRoute: '/',
    );
  }
}