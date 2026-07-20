import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app_quriv/core/constants/app_colors.dart';
import 'package:recipe_app_quriv/core/theme/app_text_style.dart';
import 'package:recipe_app_quriv/feature/home/domain/entity/recipe_entity.dart';
import 'package:recipe_app_quriv/feature/home/presentation/widgets/ingredient_container.dart';
import 'package:recipe_app_quriv/feature/home/presentation/widgets/time_container.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.recipe});
  final RecipeEntity recipe;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recipe", style: AppTextStyles.bold(size: 20)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200.h,
              width: 362.w,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(recipe.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 24.h),
            Center(
              child: Text(
                recipe.name,
                style: AppTextStyles.semibold(size: 24, color: AppColors.black),
              ),
            ),
            SizedBox(height: 24.h),
            TimeContainer(
              prepTime: recipe.prepTimeMinutes,
              cookTime: recipe.cookTimeMinutes,
              serving: recipe.servings,
            ),
            SizedBox(height: 32.h),
            IngredientContainer(ingredients: recipe.ingredients),
          ],
        ),
      ),
    );
  }
}
