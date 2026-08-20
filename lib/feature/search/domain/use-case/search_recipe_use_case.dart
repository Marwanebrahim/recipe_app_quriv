import 'package:dartz/dartz.dart';
import 'package:recipe_app_quriv/core/error/failures.dart';
import 'package:recipe_app_quriv/feature/home/domain/entity/recipe_entity.dart';
import 'package:recipe_app_quriv/feature/search/domain/repository/search_repository.dart';

class SearchRecipeUseCase {
  final SearchRepository repository;

  SearchRecipeUseCase({required this.repository});

  Future<Either<Failure, List<RecipeEntity>>> call(String query) async =>
      await repository.searchRecipes(query);
}
