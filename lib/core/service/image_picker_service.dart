import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recipe_app_quriv/core/error/exceptions.dart';

class ImagePickerService {
  final ImagePicker _imagePicker;

  ImagePickerService({required ImagePicker imagePicker})
    : _imagePicker = imagePicker;

  Future<XFile> pickImage() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
      );
      if (image == null) {
        throw ImageStorageException();
      }
      return image;
    } catch (e) {
      throw ImageStorageException();
    }
  }

  Future<String> saveImageToAppFiles(XFile image) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final savedPath = '${directory.path}/$fileName';
      final savedFile = await File(image.path).copy(savedPath);
      return savedFile.path;
    } catch (e) {
      throw ImageStorageException();
    }
  }
}
