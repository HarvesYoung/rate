import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rate/models/currency_data_model.dart';

class CurrencyDataNotifier extends StateNotifier<CurrencyDataModel>{

  // 以下注释代码有参考意义
  // CurrencyDataNotifier() : super(
  //     targetCurrencyDataModel
  // );

  // CurrencyDataNotifier(CurrencyDataModel initialModel) : super(initialModel);
  CurrencyDataNotifier(super.initialModel);

  void setInitialText(double? value) {
    state = state.copyWith(initialText: value);
  } // setInitialText() end

  void updateModelInfo(CurrencyDataModel newModel) {
    state = newModel;
  } // updateModelInfo() end
}