import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app_quriv/core/helpers/extensions.dart';
import 'package:recipe_app_quriv/feature/home/domain/entity/recipe_entity.dart';
import 'package:recipe_app_quriv/feature/home/presentation/widgets/ingredient_container.dart';
import 'package:recipe_app_quriv/feature/home/presentation/widgets/time_container.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.recipe});

  final RecipeEntity recipe;

  @override
  Widget build(BuildContext context) {
    final textStyles = context.appTextStyles;

    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe', style: textStyles.appBarTitle),
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
            Center(child: Text(recipe.name, style: textStyles.recipeTitle)),
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
