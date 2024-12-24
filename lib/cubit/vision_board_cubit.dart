import 'package:bloc/bloc.dart';
import 'dart:io';

class VisionBoardCubit extends Cubit<List<File?>> {
  VisionBoardCubit()
      : super(List.generate(24, (index) => null)); // Başlangıçta 24 kare

  // Fotoğraf eklemek için fonksiyon
  void addImage(int index, File image) {
    final updatedImages = List<File?>.from(state);
    updatedImages[index] = image;
    emit(updatedImages);
  }
}
