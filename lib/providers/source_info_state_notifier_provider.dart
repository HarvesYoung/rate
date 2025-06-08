
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rate/models/currency_data_model.dart';
import 'package:rate/notifiers/currency_data_notifier.dart';

final sourceCurrencyDataModel = CurrencyDataModel(
  name: 'China',
  code: 'cn',
  currency: 'CNY',
  continentPos: 0,
  countryPos: 8,
);

// 以下注释代码有参考意义
// final sourceInfoProvider = StateProvider<CurrencyDataModel>(
//   (ref) {
//     return sourceCurrencyDataModel;
//   },
//   name: 'source_model_provider'
// );

final sourceInfoStateNotifierProvider = StateNotifierProvider<CurrencyDataNotifier, CurrencyDataModel>(
    (_) => CurrencyDataNotifier(sourceCurrencyDataModel),
    name: 'source_info_provider'
);