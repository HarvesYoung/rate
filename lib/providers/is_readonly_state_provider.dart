import 'package:flutter_riverpod/flutter_riverpod.dart';

final isReadonlyStateProvider = StateProvider<bool>(
  (ref) => false,
  name: 'is_readonly_provider'
);

