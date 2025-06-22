
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rate/notifiers/picked_images_notifier.dart';

final pickedImageNotifierProvider = StateNotifierProvider<PickedImagesNotifier, List<File>>(
  (_) => PickedImagesNotifier(),
  name: 'picked_image_notifier_provider'
);