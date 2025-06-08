import 'package:flutter_riverpod/flutter_riverpod.dart';


final currentSourceContinentIndexProvider = StateProvider(
        (ref) => 0,
    name: 'current_source_continent_index'
);

final currentSourceCountryIndexProvider = StateProvider(
        (ref) => 8,
    name: 'current_source_country_index'
);


final currentTargetContinentIndexProvider = StateProvider(
  (ref) => 0,
  name: 'current_target_continent_index'
);

final currentTargetCountryIndexProvider = StateProvider(
  (ref) => 17,
  name: 'current_target_country_index'
);