import 'package:dartz/dartz.dart';
import 'package:recipe_app_quriv/core/error/failures.dart';
import 'package:recipe_app_quriv/feature/auth/domain/entity/user_entity.dart';
import 'package:recipe_app_quriv/feature/auth/domain/repository/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository authRepository;

  SignUpUseCase({required this.authRepository});

  Future<Either<Failure, UserEntity>> call({
    required String email,
    required String password,
    required String name,
  }) async => await authRepository.signUpWithEmail(
    email: email,
    password: password,
    name: name,
  );
}
