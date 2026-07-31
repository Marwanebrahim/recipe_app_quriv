import 'package:dartz/dartz.dart';
import 'package:recipe_app_quriv/core/error/exceptions.dart';
import 'package:recipe_app_quriv/core/error/failures.dart';
import 'package:recipe_app_quriv/feature/auth/data/mapper/user_model_mapper.dart';
import 'package:recipe_app_quriv/feature/auth/domain/entity/user_entity.dart';
import 'package:recipe_app_quriv/feature/profile/data/datasource/profile_remote_data_source.dart';
import 'package:recipe_app_quriv/feature/profile/data/mapper/user_entty_mapper.dart';
import 'package:recipe_app_quriv/feature/profile/domain/repository/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, UserEntity>> getUserProfile() async {
    try {
      final user = await remoteDataSource.getUserProfile();
      return Right(user.toEntity());
    } catch (e) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> updateUserProfile({
    required UserEntity userEntity,
  }) async {
    try {
      final user = await remoteDataSource.updateUserProfile(
        user: userEntity.toModel(),
      );
      return Right(user.toEntity());
    } on ServerException {
      return const Left(ServerFailure());
    } catch (_) {
      return const Left(ServerFailure());
    }
  }
}
