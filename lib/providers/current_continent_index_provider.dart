import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rate/configs/app_config.dart';


final currentSourceContinentIndexProvider = StateProvider(
    (ref) => AppConfig.currentSourceContinentIndex,
    name: 'current_source_continent_index'
);

final currentSourceCountryIndexProvider = StateProvider(
    (ref) => AppConfig.currentSourceCountryInex,
    name: 'current_source_country_index'
);


final currentTargetContinentIndexProvider = StateProvider(
  (ref) => AppConfig.currentTargetContinentIndex,
  name: 'current_target_continent_index'
);

final currentTargetCountryIndexProvider = StateProvider(
  (ref) => AppConfig.currentTargetCountryIndex,
  name: 'current_target_country_index'
);