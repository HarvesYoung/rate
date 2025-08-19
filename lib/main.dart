import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rate/app.dart';
import 'package:rate/configs/app_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rate/firebase_options.dart';
import 'package:rate/utils/provider_logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rate/providers/providers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'configs/configs.dart';

void main() async {

  // load the env variables
  await dotenv.load(fileName: ".env");

  // initial the SharedPreference instance
  final prefs = await SharedPreferences.getInstance();

  WidgetsFlutterBinding.ensureInitialized();
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
          localeProvider.overrideWith((ref) => initLocale),

        isNotificationAvailableProvider.overrideWith((ref) {
          // read the result from SharedPreference
          return prefs.getBool(AppConfig.kNotificationSwitchKey) ?? false;
        }),
      ],
      child: App()
    )
  );
}