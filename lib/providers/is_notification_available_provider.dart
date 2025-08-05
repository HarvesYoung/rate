import 'package:flutter_riverpod/flutter_riverpod.dart';

final isNotificationAvailableProvider = StateProvider<bool>(
  (ref) => false,
  name: 'is_receive_notification'
);