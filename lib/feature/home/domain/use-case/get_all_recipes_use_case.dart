import 'package:dartz/dartz.dart';
import 'package:recipe_app_quriv/core/error/failures.dart';
import 'package:recipe_app_quriv/feature/home/domain/entity/recipe_entity.dart';
import 'package:recipe_app_quriv/feature/home/domain/repository/home_repository.dart';

class GetAllRecipesUseCase {
  final HomeRepository homeRepository;

  GetAllRecipesUseCase({required this.homeRepository});

  Future<Either<Failure, List<RecipeEntity>>> call() async =>
      await homeRepository.getAllRecipes();
}
