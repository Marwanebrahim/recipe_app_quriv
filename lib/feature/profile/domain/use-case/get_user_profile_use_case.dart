import 'package:dartz/dartz.dart';
import 'package:recipe_app_quriv/core/error/failures.dart';
import 'package:recipe_app_quriv/feature/auth/domain/entity/user_entity.dart';
import 'package:recipe_app_quriv/feature/profile/domain/repository/profile_repository.dart';

class GetUserProfileUseCase {
  final ProfileRepository profileRepository;

  GetUserProfileUseCase({required this.profileRepository});

  Future<Either<Failure, UserEntity>> call() async =>
      await profileRepository.getUserProfile();
}
