import 'package:dartz/dartz.dart';
import 'package:recipe_app_quriv/core/error/failures.dart';
import 'package:recipe_app_quriv/feature/auth/domain/repository/auth_repository.dart';

class LogOutUseCase {
  final AuthRepository authRepository;
  LogOutUseCase({required this.authRepository});

  Future<Either<Failure, Unit>> call() async => await authRepository.logOut();
}
