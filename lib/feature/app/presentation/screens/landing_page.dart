import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app_quriv/core/constants/app_assets.dart';
import 'package:recipe_app_quriv/core/helpers/extensions.dart';
import 'package:recipe_app_quriv/core/routing/app_routes.dart';
import 'package:recipe_app_quriv/shared/widgets/custom_button_widget.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final textStyles = context.appTextStyles;

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Image.asset(AppAssets.langingPageImage),
            Container(color: Colors.black87.withValues(alpha: 0.3)),
            Center(
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 100.h),
                        Text(
                          "RECI",
                          style: textStyles.logo.copyWith(
                            color: colors.lightBackground,
                            height: 1,
                          ),
                        ),
                        Text(
                          'cook it yourself',
                          style: textStyles.bodySmall.copyWith(
                            color: colors.lightBackground,
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomButtonWidget(
                          height: 55,
                          width: 361,
                          borderRadius: 6,
                          backgroundColor: colors.primary,
                          onTap: () {
                            Navigator.pushReplacementNamed(
                              context,
                              AppRoutes.register,
                            );
                          },
                          child: Center(
                            child: Text(
                              'REGISTER',
                              style: textStyles.buttonLarge,
                            ),
                          ),
                        ),
                        SizedBox(height: 24.h),
                        CustomButtonWidget(
                          height: 55,
                          width: 361,
                          borderRadius: 6,
                          borderColor: colors.primary,
                          onTap: () {
                            Navigator.pushReplacementNamed(
                              context,
                              AppRoutes.login,
                            );
                          },
                          child: Center(
                            child: Text(
                              'LOG IN',
                              style: textStyles.buttonLarge,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
