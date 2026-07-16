import 'package:recipe_app_quriv/feature/home/data/models/recipe_model.dart';
import 'package:recipe_app_quriv/feature/home/domain/entity/recipe_entity.dart';

extension RecipeModelMapper on RecipeModel {
  RecipeEntity toEntity() => RecipeEntity();
}
