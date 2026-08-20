import 'package:dartz/dartz.dart';
import 'package:recipe_app_quriv/core/error/failures.dart';
import 'package:recipe_app_quriv/feature/home/data/mapper/recipe_model_mapper.dart';
import 'package:recipe_app_quriv/feature/home/domain/entity/recipe_entity.dart';
import 'package:recipe_app_quriv/feature/search/data/datasource/search_data_source.dart';
import 'package:recipe_app_quriv/feature/search/domain/repository/search_repository.dart';

class SearchRepositoryImp implements SearchRepository {
  final SearchDataSource dataSource;

  SearchRepositoryImp({required this.dataSource});
  @override
  Future<Either<Failure, List<RecipeEntity>>> searchRecipes(
    String query,
  ) async {
    try {
      final recipes = await dataSource.searchRecipes(query);
      final recipeEntity = recipes.map((e) => e.toEntity()).toList();
      return Right(recipeEntity);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
