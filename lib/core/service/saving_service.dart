import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:recipe_app_quriv/core/error/exceptions.dart';

class SavingService {
  Future<String> saveImageToAppFiles(String imagePath) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final savedPath = '${directory.path}/$fileName';
      final savedFile = await File(imagePath).copy(savedPath);
      return savedFile.path;
    } catch (e) {
      throw ImageStorageException();
    }
  }
}
