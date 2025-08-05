import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rate/configs/app_config.dart';

final isReadonlyStateProvider = StateProvider<bool>(
  (ref) => AppConfig.isDefaultNotificationAvailable,
  name: 'is_readonly_provider'
);

