import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:recipe_app_quriv/core/constants/api_constants.dart';
import 'package:recipe_app_quriv/core/error/exceptions.dart';
import 'package:recipe_app_quriv/feature/home/data/models/recipe_model.dart';

abstract class RemoteDataSource {
  Future<List<String>> getCategories();
  Future<List<RecipeModel>> getAllRecipes();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final Dio _dio;

  RemoteDataSourceImpl({required Dio dio}) : _dio = dio;
  @override
  Future<List<RecipeModel>> getAllRecipes() async {
    try {
      final response = await _dio.get(ApiConstants.recipesUrl);
      return (response.data['recipes'] as List<dynamic>)
          .map((e) => RecipeModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      log(e.toString());
      throw ServerException();
    }
  }

  @override
  Future<List<String>> getCategories() async {
    try {
      final response = await _dio.get(ApiConstants.recipeCategoriesUrl);
      return (response.data as List<dynamic>).map((e) => e.toString()).toList();
    } catch (e) {
      log(e.toString());
      throw ServerException();
    }
  }
}
