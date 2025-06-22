
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rate/providers/providers.dart';
import 'package:rate/utils/functions.dart';

class FirebaseStorageService {
  static final FirebaseStorageService _instance = FirebaseStorageService._internal();

  factory FirebaseStorageService() => _instance;

  FirebaseStorageService._internal();

  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadFile({
    required File file,
    required WidgetRef ref,
    int index = 0
  }) async {
    try {
      final fileName = generateRandomImageName();
      final storageRef = _storage.ref().child(fileName);

      final uploadTask = storageRef.putFile(file);

      uploadTask.snapshotEvents.listen(
        (TaskSnapshot taskSnapshot) {
          switch (taskSnapshot.state) {
            case TaskState.running:
              double progress = 0;
              if(taskSnapshot.totalBytes > 0) {
                final raw = taskSnapshot.bytesTransferred / taskSnapshot.totalBytes;
                progress = truncateToTwoDecimalPlaces(raw);
              }
              debugPrint("第${index + 1} Upload is $progress % complete");
              ref.read(uploadProgressProvider.notifier).update(index, progress);
              break;

            case TaskState.paused:
              debugPrint('Upload is paused');
              break;

            case TaskState.canceled:
              debugPrint('Upload is canceled');
              break;

            case TaskState.error:
              // handle unsuccessful uploads
              debugPrint('Upload failed.');
              break;

            case TaskState.success:
              ref.read(uploadProgressProvider.notifier).update(index, 100);
              break;
          }
        },
        onError: (e) {
          // throw Exception('Upload error!');
        },
        onDone: () {

        }
      );

      final snapshot = await uploadTask.catchError((e) {
        debugPrint('catchError: ${e.toString()}');
        throw e;
      }); // waiting until upload task complete
      
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } on FirebaseException {
      rethrow;
    } catch (e) {
      debugPrint('e = ${e.toString()}');
      rethrow;
    }
  } // uploadFile() end

  Future<List<String>> uploadMultiImages({
    required List<File> files,
    required WidgetRef ref
  }) async {
    List<String> downloadUrls = [];
    for(var entry in files.asMap().entries) {
      final int index = entry.key;
      final File file = entry.value;

      final downloadURL = await uploadFile(file: file, ref: ref, index: index);
      downloadUrls.add(downloadURL);
    } // for{} end
    return downloadUrls;
  } // uploadMultiImages() end

  /// - 截断保留两位小数
  /// - @param [double] data source
  /// - @return [double]
  double truncateToTwoDecimalPlaces(double value) {
    return (value * 10000).truncateToDouble() / 100;
  } // truncateToTwoDecimalPlaces() end

}