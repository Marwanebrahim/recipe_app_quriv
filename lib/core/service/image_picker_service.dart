import 'package:image_picker/image_picker.dart';
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
}
