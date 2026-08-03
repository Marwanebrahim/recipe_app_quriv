import 'package:dio/dio.dart';
import 'package:recipe_app_quriv/core/constants/api_constants.dart';
import 'package:recipe_app_quriv/core/error/exceptions.dart';
import 'package:recipe_app_quriv/feature/home/data/models/recipe_model.dart';

abstract class SearchDataSource {
  Future<List<RecipeModel>> searchRecipes(String query);
}

class SearchDataSourceImpl implements SearchDataSource {
  final Dio dio;

  SearchDataSourceImpl({required this.dio});
  @override
  Future<List<RecipeModel>> searchRecipes(String query) async {
    try {
      final response = await dio.get(
        ApiConstants.searchUrl,
        queryParameters: {'q': query},
      );
      return (response.data['recipes'] as List<dynamic>)
          .map((e) => RecipeModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw ServerException();
    }
  }
}
