import 'package:dartz/dartz.dart';
import 'package:recipe_app_quriv/core/error/failures.dart';
import 'package:recipe_app_quriv/feature/home/domain/repository/home_repository.dart';

class GetAllCategoriesUseCase {
  final HomeRepository homeRepository;

  GetAllCategoriesUseCase({required this.homeRepository});

  Future<Either<Failure, List<String>>> call() async =>
      await homeRepository.getCategories();
}
