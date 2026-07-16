import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:recipe_app_quriv/core/error/exceptions.dart';
import 'package:recipe_app_quriv/core/error/failures.dart';
import 'package:recipe_app_quriv/feature/home/data/data-source/remote_data_source.dart';
import 'package:recipe_app_quriv/feature/home/data/mapper/recipe_model_mapper.dart';
import 'package:recipe_app_quriv/feature/home/domain/entity/recipe_entity.dart';
import 'package:recipe_app_quriv/feature/home/domain/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final RemoteDataSource remoteDataSource;

  HomeRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, List<RecipeEntity>>> getAllRecipes() async {
    try {
      final recipes = await remoteDataSource.getAllRecipes();
      final recipeEntities = recipes.map((e) => e.toEntity()).toList();
      return Right(recipeEntities);
    } on ServerException {
      return Left(ServerFailure());
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionTimeout) {
        return Left(OfflineFailure());
      }
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<String>>> getCategories() async {
    try {
      final categories = await remoteDataSource.getCategories();
      return Right(categories);
    } on ServerException {
      return Left(ServerFailure());
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionTimeout) {
        return Left(OfflineFailure());
      }
      return Left(ServerFailure());
    }
  }
}
