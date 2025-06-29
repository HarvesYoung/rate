import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rate/app.dart';
import 'package:rate/firebase_options.dart';
import 'package:rate/providers/locale_provider.dart';
import 'package:rate/utils/provider_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'configs/configs.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final savedLocaleCode = prefs.getString(AppConfig.savedLocaleCodeKey);
  final Locale? initLocale = savedLocaleCode != null ? Locale(savedLocaleCode) : null;

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ProviderScope(
      observers: [
        ProviderLogger()
      ],
      overrides: [
        // 覆盖默认的`localeProvider`的初始值
        if(initLocale != null)
          localeProvider.overrideWith((ref) => initLocale)
      ],
      child: App()
    )
  );
}