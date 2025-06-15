import 'package:flutter/material.dart';
import 'package:rate/configs/home_page.dart';
import 'package:rate/pages/feedback_page.dart';

final Map<String, WidgetBuilder> customRoutesConfig = {
  '/': (_) => const HomePage(),
  'feedback': (_) => FeedbackPage(),
};