
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rate/models/currency_data_model.dart';
import 'package:rate/notifiers/currency_data_notifier.dart';

final targetCurrencyDataModel = CurrencyDataModel(
    name: 'Japan',
    code: 'jp',
    currency: 'JPY',
    continentPos: 0,
    countryPos: 17
);

// final targetInfoProvider = StateProvider<CurrencyDataModel>(
//   (ref) {
//     return targetCurrencyDataModel;
//   },
//   name: 'target_model_provider',
// );

final targetInfoStateNotifierProvider = StateNotifierProvider<CurrencyDataNotifier, CurrencyDataModel>(
  (_){
    return CurrencyDataNotifier(targetCurrencyDataModel);
  },
  name: 'target_info_provider',
);


