
import 'package:dio/dio.dart';

class CustomDioConfig {
  static Duration connectTimeout = const Duration(seconds: 5);

  static Duration receiveTimeout = const Duration(seconds: 5);

  static ResponseType? responseType = ResponseType.json;

  static Duration sendTimeout = const Duration(seconds: 5);
}