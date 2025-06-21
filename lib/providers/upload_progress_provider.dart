
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rate/notifiers/notifiers.dart';

final uploadProgressProvider = StateNotifierProvider<UploadProgressNotifier, double>(
  (ref) => UploadProgressNotifier(),
  name: 'upload_progress_notifier'
);