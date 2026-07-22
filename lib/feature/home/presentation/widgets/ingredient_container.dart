import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app_quriv/core/helpers/extensions.dart';

class IngredientContainer extends StatelessWidget {
  const IngredientContainer({super.key, required this.ingredients});

  final List<String> ingredients;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final textStyles = context.appTextStyles;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Ingredients',
                style: textStyles.recipeTitle.copyWith(
                  color: colors.text,
                ),
              ),
              Text(
                '${ingredients.length} items',
                style: textStyles.bodySmall.copyWith(
                  color: colors.text,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: colors.white,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              children: List.generate(
                ingredients.length,
                (index) => Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(ingredients[index], style: textStyles.bodyMedium),
                        Text('1 Cup', style: textStyles.bodySmall),
                      ],
                    ),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
