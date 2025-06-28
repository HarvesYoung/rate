import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rate/configs/app_config.dart';
import 'package:rate/l10n/generated/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

final localeProvider = FutureProvider<Locale>(
  (ref) async {
    /// step 1: attempt to read the locale saved in the localStorage
    final prefs = await SharedPreferences.getInstance();
    final savedLocaleCode = prefs.getString(AppConfig.savedLocaleCodeKey);

    if(savedLocaleCode != null) {
      return Locale(savedLocaleCode);
    }

    /// step 2: fallback to system language code when there is no saved locale code
    /// system language code
    final systemLocale = PlatformDispatcher.instance.locale;
    final supportedLocales = AppLocalizations.supportedLocales;
    return supportedLocales.firstWhere(
      (loc) => loc.languageCode == systemLocale.languageCode,
      orElse: () => const Locale('en')
    );
  },
  name: 'locale_provider'
);