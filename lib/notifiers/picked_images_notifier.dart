
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PickedImagesNotifier extends StateNotifier<List<File>> {
  PickedImagesNotifier():super([]);

  List<File> pickedImages = [];

  void addPickedImage(File imageFile) {
    state = [...state, imageFile];
  } // addPickedImage() end

  void updatePickedImage(File oldImageFile, File imageFile) {
     int index = state.indexWhere((img) => img.path == oldImageFile.path);

    final newState = [...state];
    newState[index] = imageFile;
    state = newState;
  } // updatePickedImage() end


  void deletePickedImage(File imageFile) {
    state = state.where((img) => img.path != imageFile.path).toList();
  } // deletePickedImage() end


  void clearPickedImages() {
    state = [];
  } // clearPickedImage() end
}