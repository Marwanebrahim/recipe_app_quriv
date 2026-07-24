import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app_quriv/core/helpers/extensions.dart';

class TimeContainer extends StatelessWidget {
  const TimeContainer({
    super.key,
    required this.prepTime,
    required this.cookTime,
    required this.serving,
  });

  final int prepTime;
  final int cookTime;
  final int serving;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final textStyles = context.appTextStyles;

    return Container(
      height: 81.h,
      width: 361.w,
      decoration: BoxDecoration(
        color: colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Text(
                '$prepTime min',
                style: textStyles.recipeTitle.copyWith(color: colors.primary),
              ),
              SizedBox(height: 8.h),
              Text(
                'Prep Time',
                style: textStyles.bodySmall.copyWith(color: colors.black),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                '$cookTime min',
                style: textStyles.recipeTitle.copyWith(color: colors.primary),
              ),
              SizedBox(height: 8.h),
              Text(
                'Cook Time',
                style: textStyles.bodySmall.copyWith(color: colors.black),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                '$serving',
                style: textStyles.recipeTitle.copyWith(color: colors.primary),
              ),
              SizedBox(height: 8.h),
              Text(
                'Serving',
                style: textStyles.bodySmall.copyWith(color: colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
