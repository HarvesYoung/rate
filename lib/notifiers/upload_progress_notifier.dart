import 'package:flutter_riverpod/flutter_riverpod.dart';

class UploadProgressNotifier extends StateNotifier<List<double>> {
  UploadProgressNotifier():super([]);

  void addInitProgress() {
    state = [...state, 0];
  }

  void update(int pos, double value)  {
    if(pos >= state.length) return;
    final newState = [...state];
    newState[pos] = value;
    state = newState;
  }

  void removeLastProgress() {
    if(state.isNotEmpty) {
      state = state.sublist(0, state.length - 1);
    }
    state.removeLast();
  }

  void reset() => state = [];
}