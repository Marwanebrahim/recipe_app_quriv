import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app_quriv/core/styles/app_colors.dart';
import 'package:recipe_app_quriv/core/styles/app_text_style.dart';

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
    return Container(
      height: 81.h,
      width: 361.w,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Text(
                "${prepTime.toString()} min",
                style: AppTextStyles.semibold(
                  size: 24,
                  color: AppColors.primaryColor,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Prep Time',
                style: AppTextStyles.regular(size: 16, color: AppColors.black),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                "${cookTime.toString()} min",
                style: AppTextStyles.semibold(
                  size: 24,
                  color: AppColors.primaryColor,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Cook Time',
                style: AppTextStyles.regular(size: 16, color: AppColors.black),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                serving.toString(),
                style: AppTextStyles.semibold(
                  size: 24,
                  color: AppColors.primaryColor,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Serving',
                style: AppTextStyles.regular(size: 16, color: AppColors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
