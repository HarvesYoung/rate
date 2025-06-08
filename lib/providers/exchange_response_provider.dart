
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rate/models/exchange_response_model.dart';

final exchangeResponseStateProvider = StateProvider<ExchangeResponseModel>(
  (ref) => ExchangeResponseModel(),
  name: 'exchange_response_provider'
);