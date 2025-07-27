import 'package:flutter/material.dart';
import 'package:rate/pages/pages.dart';

final Map<String, WidgetBuilder> customRoutesConfig = {
  '/': (_) => const HomePage(),
  'feedback': (_) => FeedbackPage(),
  'storage': (_) => const StoragePage(),
  'notification': (_) => const NotificationPage(),
  'notificationList': (_) => const NotificationListPage(),
  'notificationDetail': (_) => const NotificationDetailPage(),
};