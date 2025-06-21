import 'package:flutter_riverpod/flutter_riverpod.dart';

class UploadProgressNotifier extends StateNotifier<double> {
  UploadProgressNotifier():super(0);

  void update(double value) => state = value;

  // 下一行代码是否在StateNotifier类中 是正确的？如果是，外部如何访问？
  // double get percent => state + 0.1; // 不推荐

  void reset() => state = 0;
}