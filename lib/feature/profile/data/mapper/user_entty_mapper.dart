import 'package:recipe_app_quriv/feature/auth/data/model/user_model.dart';
import 'package:recipe_app_quriv/feature/auth/domain/entity/user_entity.dart';

extension UserEntityMapper on UserEntity {
  UserModel toModel() =>
      UserModel(uid: uid, email: email, name: name, imagePath: imagePath);
}
