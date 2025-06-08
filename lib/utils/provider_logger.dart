import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProviderLogger extends ProviderObserver {
  @override
  void didUpdateProvider(ProviderBase provider, Object? previousValue, Object? newValue, ProviderContainer container) {
    debugPrint('🔄 [${provider.name ?? provider.runtimeType}] changed: ${previousValue .toString()} => ${newValue.toString()}');
  }
}