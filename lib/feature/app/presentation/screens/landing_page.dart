import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app_quriv/core/helpers/assets_helper.dart';
import 'package:recipe_app_quriv/core/routing/app_routes.dart';
import 'package:recipe_app_quriv/core/styles/app_colors.dart';
import 'package:recipe_app_quriv/core/styles/app_text_style.dart';
import 'package:recipe_app_quriv/core/widgets/custom_button_widget.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});
  //! landing page is differen thing from the main navigation so it won't be at the same foler (app)
//! the image should has darker color
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //! need Positioned.fill
          Image.asset(AssetsHelper.langingPageImage),
          Image.asset(AssetsHelper.noise),           //? why noise? why not overlay with dark color?
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
                  hieght: 55,
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
                  hieght: 55,
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
