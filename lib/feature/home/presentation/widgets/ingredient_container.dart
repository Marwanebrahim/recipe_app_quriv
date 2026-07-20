import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app_quriv/core/constants/app_colors.dart';
import 'package:recipe_app_quriv/core/theme/app_text_style.dart';

class IngredientContainer extends StatelessWidget {
  const IngredientContainer({super.key, required this.ingredients});
  final List<String> ingredients;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Ingredients",
                style: AppTextStyles.semibold(
                  size: 24,
                  color: AppColors.secondaryTextColor,
                ),
              ),
              Text(
                "${ingredients.length} items",
                style: AppTextStyles.regular(
                  size: 16,
                  color: AppColors.secondaryTextColor,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: AppColors.white,
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
                        Text(
                          ingredients[index],
                          style: AppTextStyles.semibold(
                            size: 16,
                            color: AppColors.black,
                          ),
                        ),
                        Text(
                          "1 Cup",
                          style: AppTextStyles.regular(
                            size: 16,
                            color: AppColors.black,
                          ),
                        ),
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
