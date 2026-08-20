import 'package:recipe_app_quriv/feature/auth/data/model/user_model.dart';
import 'package:recipe_app_quriv/feature/auth/domain/entity/user_entity.dart';

extension UserModelMapper on UserModel {
  UserEntity toEntity() {
    return UserEntity(uid: uid, email: email, name: name, imagePath: imagePath);
  }
}
