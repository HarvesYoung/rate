
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rate/models/exchange_response_model.dart';
import 'package:rate/services/dio_service.dart';

class RateNotifier extends StateNotifier<AsyncValue<double>> {
  final Ref ref;
  RateNotifier(this.ref) : super(const AsyncValue.loading());

  Future<ExchangeResponseModel> fetchRate(String symbol) async {

    try {
      final response = await DioService().get(
          '/latest',
          queryParams: {
            // 'base': 'CNY',
            'symbols': symbol
          }
      );

      debugPrint('------response start--------');
      debugPrint(response?.data.toString());
      debugPrint('------response end--------');
      return ExchangeResponseModel.fromJson(response?.data);
    } catch (e) {
      rethrow;
    }
  } // fetchRate() end
}