
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rate/configs/app_config.dart';
import 'package:rate/configs/custom_dio_config.dart';
import 'package:rate/configs/exchangerates_config.dart';
import 'package:rate/models/exchange_error_model.dart';
import 'package:rate/utils/custom_dio_exception.dart';

class DioService {
  static final DioService _instance = DioService._internal();
  factory DioService() => _instance;

  late final Dio _dio;

  DioService._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ExchangeratesConfig.baseUrl,
        connectTimeout: CustomDioConfig.connectTimeout,
        sendTimeout: CustomDioConfig.sendTimeout,
        receiveTimeout: CustomDioConfig.receiveTimeout,
        responseType: CustomDioConfig.responseType
      )
    );

    _dio.interceptors.addAll([
      LogInterceptor(
          requestBody: true,
          responseBody: true,
          error: true,
          logPrint: (obj) => debugPrint(obj.toString())
      ), // LogInterceptor() end
      InterceptorsWrapper(
        onRequest: (request, handler) {
          Map<String, dynamic> originalParams = Map.from(request.queryParameters);
          originalParams['access_key'] = ExchangeratesConfig.apiAccessKey;
          request.queryParameters = originalParams;
          handler.next(request);
        },
        onResponse: (response, handler) {
          final resp = response.data;
          if(!resp['success']) {
            debugPrint('---------------success false---------------');
            final exchangeErrorModel = ExchangeErrorModel.fromJson(resp);
            debugPrint("code: ${exchangeErrorModel.error.code}; info: ${exchangeErrorModel.error.info}");
            debugPrint('---------------success false end---------------');
            throw CustomDioException(
              requestOptions: response.requestOptions
            );
          }
          handler.next(response);
        },
        onError: (DioException e, handler) {
          String errorMsg;
          final statusCode = e.response?.statusCode;
          debugPrint('---------------DioException---------------');
          debugPrint('HTTP Status = ${statusCode}. Message: ${e.response?.data}}');
          debugPrint('---------------DioException end---------------');
          // switch(statusCode) {
          //   case null:
          //     errorMsg = AppConfig.networkErrorMessage;
          //     break;
          //
          //   case 400:
          //     errorMsg =
          // }
          if(statusCode == null) {
            errorMsg = AppConfig.networkErrorMessage;
          } else {
            errorMsg = AppConfig.errorMessage;
          }

          handler.reject(CustomDioException(requestOptions: e.requestOptions, message: errorMsg));
        }
      ) // InterceptorsWrapper() end
    ]);
  }

  Future<Response?> get(String path, {Map<String, dynamic>? queryParams}) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParams);
      return response;
    } catch(e) {
      rethrow;
    }
  } // get() end
}
