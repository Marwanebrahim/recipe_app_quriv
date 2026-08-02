import 'package:dartz/dartz.dart';
import 'package:recipe_app_quriv/core/error/failures.dart';
import 'package:recipe_app_quriv/feature/auth/domain/entity/user_entity.dart';
import 'package:recipe_app_quriv/feature/profile/domain/repository/profile_repository.dart';

class PickImageUseCase {
  final ProfileRepository profileRepository;

  PickImageUseCase({required this.profileRepository});
  Future<Either<Failure, String>> call({required UserEntity user}) async {
    final imageResult = await profileRepository.pickImage();
    final updatedUser = user.copyWith(
      imagePath: imageResult.fold((l) => user.imagePath, (r) => r),
    );
    final result = await profileRepository.updateUserProfile(
      userEntity: updatedUser,
    );
    return result.fold((l) => Left(l), (r) => Right(r.imagePath!));
  }
}
