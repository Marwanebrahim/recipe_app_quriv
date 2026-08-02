import 'package:dartz/dartz.dart';
import 'package:recipe_app_quriv/core/error/failures.dart';
import 'package:recipe_app_quriv/feature/auth/domain/entity/user_entity.dart';
import 'package:recipe_app_quriv/feature/auth/domain/repository/auth_repository.dart';

class LogInWithGoogleUseCase {
  final AuthRepository authRepository;

  LogInWithGoogleUseCase({required this.authRepository});

  Future<Either<Failure, UserEntity>> call() async =>
      await authRepository.logInWithGoogle();
}
