
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rate/notifiers/notification_list_notifier.dart';

final notificationListProvider = StateNotifierProvider<NotificationListNotifier, List<String>>(
  (_) => NotificationListNotifier(),
  name: 'notification_list_provider'
);