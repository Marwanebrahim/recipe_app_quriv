import 'package:dartz/dartz.dart';
import 'package:recipe_app_quriv/core/error/failures.dart';
import 'package:recipe_app_quriv/feature/auth/domain/entity/user_entity.dart';
import 'package:recipe_app_quriv/feature/profile/domain/repository/profile_repository.dart';

class UpdateUserProfileUseCase {
  final ProfileRepository profileRepository;

  UpdateUserProfileUseCase({required this.profileRepository});

  Future<Either<Failure, UserEntity>> call({
    required String uid,
    required String email,
    required String name,
    String? imagePath,
  }) async => await profileRepository.updateUserProfile(
    userEntity: UserEntity(
      uid: uid,
      email: email,
      name: name,
      imagePath: imagePath,
    ),
  );
}
