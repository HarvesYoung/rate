
import 'package:dio/dio.dart';
import 'package:rate/configs/app_config.dart';

class CustomDioException extends DioException {

  final String? _customMessage;

  CustomDioException({
    required super.requestOptions,
    String? message
  }): _customMessage = message;

  @override
  String? get message => _customMessage;

  @override
  String toString() {
    return message ?? AppConfig.errorMessage;
  }
}