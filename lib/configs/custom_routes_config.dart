import 'package:flutter/material.dart';
import 'package:rate/pages/pages.dart';

final Map<String, WidgetBuilder> customRoutesConfig = {
  '/': (_) => const WelcomePage(),
  'home': (_) => const HomePage(),
  'feedback': (_) => FeedbackPage(),
  'storage': (_) => const StoragePage(),
  'customNotificationSetting': (_) => const CustomNotificationSetting(),
  'notificationList': (_) => const NotificationList(),
};