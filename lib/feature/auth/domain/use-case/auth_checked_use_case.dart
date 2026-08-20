import 'package:dartz/dartz.dart';
import 'package:recipe_app_quriv/core/error/failures.dart';
import 'package:recipe_app_quriv/feature/auth/domain/repository/auth_repository.dart';

class AuthCheckedUseCase {
  final AuthRepository repository;

  AuthCheckedUseCase({required this.repository});

  Future<Either<Failure, Unit>> call() async => await repository.checkUser();
}
