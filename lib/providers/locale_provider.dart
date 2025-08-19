import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rate/configs/app_config.dart';
import 'package:rate/l10n/generated/app_localizations.dart';

final localeProvider = StateProvider<Locale>(
  (ref) {
    /// fallback to system language code when there is no saved locale code
    /// system language code
    final systemLocale = PlatformDispatcher.instance.locale;
    final supportedLocales = AppLocalizations.supportedLocales;
    return supportedLocales.firstWhere(
      (loc) => loc.languageCode == systemLocale.languageCode,
      orElse: () => const Locale(AppConfig.defaultLocaleCode)
    );
  },
  name: 'locale_provider'
);