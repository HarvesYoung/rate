
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class PickedImagesNotifier extends StateNotifier<List<XFile>> {
  PickedImagesNotifier():super([]);

  List<XFile> pickedImages = [];

  void addPickedImage(XFile imageXFile) {
    state = [...state, imageXFile];
  } // addPickedImage() end

  void updatePickedImage(XFile oldImageXFile, XFile imageXFile) {
     int index = state.indexWhere((img) => img.path == oldImageXFile.path);

    final newState = [...state];
    newState[index] = imageXFile;
    state = newState;
  } // updatePickedImage() end


  void deletePickedImage(XFile imageXFile) {
    state = state.where((img) => img.path != imageXFile.path).toList();
  } // deletePickedImage() end


  void clearPickedImages() {
    state = [];
  } // clearPickedImage() end
}