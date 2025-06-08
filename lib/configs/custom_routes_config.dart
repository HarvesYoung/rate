import 'package:flutter/material.dart';
import 'package:rate/pages/my_page.dart';
import 'package:rate/pages/query_rate_page.dart';

final Map<String, WidgetBuilder> customRoutesConfig = {
  '/': (_) => const QueryRatePage(),
  'myPage': (_) => const MyPage(),
};