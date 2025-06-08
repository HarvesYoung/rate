import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rate/app.dart';
import 'package:rate/utils/provider_logger.dart';
void main() async {
  await dotenv.load(fileName: ".env");
  runApp(
    ProviderScope(
      observers: [
        ProviderLogger()
      ],
      child: App()
    )
  );
}