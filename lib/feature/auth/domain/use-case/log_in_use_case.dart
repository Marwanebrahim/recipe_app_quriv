import 'package:dartz/dartz.dart';
import 'package:recipe_app_quriv/core/error/failures.dart';
import 'package:recipe_app_quriv/feature/auth/domain/entity/user_entity.dart';
import 'package:recipe_app_quriv/feature/auth/domain/repository/auth_repository.dart';

class LogInUseCase {
  final AuthRepository authRepository;

  LogInUseCase({required this.authRepository});

  Future<Either<Failure, UserEntity>> call({
    required String email,
    required String password,
  }) async =>
      await authRepository.logInWithEmail(email: email, password: password);
}
