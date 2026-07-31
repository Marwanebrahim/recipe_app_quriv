import 'package:dartz/dartz.dart';
import 'package:recipe_app_quriv/core/error/exceptions.dart';
import 'package:recipe_app_quriv/core/error/failures.dart';
import 'package:recipe_app_quriv/feature/auth/data/datasource/auth_remote_data_source.dart';
import 'package:recipe_app_quriv/feature/auth/data/mapper/user_model_mapper.dart';
import 'package:recipe_app_quriv/feature/auth/domain/entity/user_entity.dart';
import 'package:recipe_app_quriv/feature/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, UserEntity>> signUpWithEmail({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final user = await remoteDataSource.signUpWithEmail(
        email: email,
        password: password,
        name: name,
      );
      return Right(user.toEntity());
    } on EmailAlreadyInUseException {
      return const Left(EmailAlreadyInUseFailure());
    } on ServerException {
      return const Left(ServerFailure());
    } catch (_) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> logInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final user = await remoteDataSource.logInWithEmail(
        email: email,
        password: password,
      );
      return Right(user.toEntity());
    } on InvalidCredentialsException {
      return const Left(InvalidCredentialsFailure());
    } on ServerException {
      return const Left(ServerFailure());
    } catch (_) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> checkUser() async {
    try {
      if (await remoteDataSource.isLoggedIn()) return Right(unit);
      return const Left(ServerFailure());
    } catch (e) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> logOut() async {
    try {
      await remoteDataSource.logOut();
      return Right(unit);
    } catch (e) {
      return const Left(ServerFailure());
    }
  }
}
