
import 'dart:io';
import 'dart:math';
import 'package:flutter_image_compress/flutter_image_compress.dart';

/// - compress the image to be uploaded
/// - @param [File]
/// - @return [File]
Future<File> compressImage(File file) async {
  final result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      minWidth: 1080,
      minHeight: 1080,
      quality: 70
  );
  final compressed = File('${file.path}_compressed.jpg');
  return compressed.writeAsBytes(result!);
} // compressImage


String generateRandomImageName() {
  final timestamp = DateTime.now().microsecondsSinceEpoch;
  final randomId = Random().nextInt(100000);
  return 'feedback_$timestamp\_$randomId.jpg';
} // generateImageName() end