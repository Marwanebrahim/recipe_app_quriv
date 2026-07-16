import 'package:dartz/dartz.dart';
import 'package:recipe_app_quriv/core/error/failures.dart';
import 'package:recipe_app_quriv/feature/home/domain/entity/recipe_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<String>>> getCategories();
  Future<Either<Failure, List<RecipeEntity>>> getAllRecipes();
}
