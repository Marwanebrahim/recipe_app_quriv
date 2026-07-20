import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app_quriv/core/constants/app_assets.dart';
import 'package:recipe_app_quriv/core/routing/app_routes.dart';
import 'package:recipe_app_quriv/core/constants/app_colors.dart';
import 'package:recipe_app_quriv/core/theme/app_text_style.dart';
import 'package:recipe_app_quriv/core/widgets/custom_button_widget.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: Image.asset(AppAssets.langingPageImage)),
          Positioned.fill(child: Image.asset(AppAssets.noise)),
          Center(
            child: Column(
              children: [
                Spacer(flex: 3),
                Text(
                  "RECI",
                  style: AppTextStyles.regular(
                    size: 76.5,
                    color: AppColors.lightBackgroundColor,
                    font: AppFont.dmSerifDisplay,
                  ).copyWith(height: 1),
                ),
                Text(
                  "cook it yourself",
                  style: AppTextStyles.regular(
                    size: 16,
                    color: AppColors.lightBackgroundColor,
                  ).copyWith(height: 1),
                ),
                Spacer(flex: 2),
                CustomButtonWidget(
                  height: 55,
                  width: 361,
                  borderRadius: 6,
                  backgroundColor: AppColors.primaryColor,
                  onTap: () {
                    Navigator.pushReplacementNamed(context, AppRoutes.register);
                  },
                  child: Center(
                    child: Text(
                      "REGISTER",
                      style: AppTextStyles.semibold(
                        size: 24,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 43.h),
                CustomButtonWidget(
                  height: 55,
                  width: 361,
                  borderRadius: 6,
                  borderColor: AppColors.primaryColor,
                  onTap: () {
                    Navigator.pushReplacementNamed(context, AppRoutes.login);
                  },
                  child: Center(
                    child: Text(
                      "LOG IN",
                      style: AppTextStyles.semibold(
                        size: 24,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
                Spacer(flex: 1),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
