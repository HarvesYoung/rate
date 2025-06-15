
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rate/notifiers/picked_images_notifier.dart';

final PickedImageNotifierProvider = StateNotifierProvider<PickedImagesNotifier, List<XFile>>(
  (_) => PickedImagesNotifier(),
  name: 'picked_image_notifier_provider'
);