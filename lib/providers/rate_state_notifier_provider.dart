
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rate/notifiers/rate_notifier.dart';

final rateStateNotifierProvider = StateNotifierProvider<RateNotifier, AsyncValue<double>>(
  (ref) => RateNotifier(ref),
  name: 'rate_notifier_provider'
);


