import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app_quriv/core/constants/app_assets.dart';
import 'package:recipe_app_quriv/core/constants/app_colors.dart';
import 'package:recipe_app_quriv/core/theme/app_text_style.dart';

class GreetingWidget extends StatelessWidget {
  const GreetingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                text: 'Hello, ',
                style: AppTextStyles.semibold(size: 24, color: Colors.black),
                children: [
                  TextSpan(
                    text: 'Alex',
                    style: AppTextStyles.semibold(
                      size: 24,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'What would you like to cook today?',
              style: AppTextStyles.regular(size: 16, color: AppColors.grey),
            ),
          ],
        ),
        const CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage(AppAssets.userAvatar),
        ),
      ],
    );
  }
}
