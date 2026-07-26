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
      body: Stack(
        children: [
          Positioned.fill(child: Image.asset(AppAssets.langingPageImage)),
          Positioned.fill(child: Image.asset(AppAssets.noise)),
          Center(
            child: Column(
              children: [
                const Spacer(flex: 3),
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
                const Spacer(flex: 2),
                CustomButtonWidget(
                  height: 55,
                  width: 361,
                  borderRadius: 6,
                  backgroundColor: colors.primary,
                  onTap: () {
                    Navigator.pushReplacementNamed(context, AppRoutes.register);
                  },
                  child: Center(
                    child: Text('REGISTER', style: textStyles.buttonLarge),
                  ),
                ),
                SizedBox(height: 43.h),
                CustomButtonWidget(
                  height: 55,
                  width: 361,
                  borderRadius: 6,
                  borderColor: colors.primary,
                  onTap: () {
                    Navigator.pushReplacementNamed(context, AppRoutes.login);
                  },
                  child: Center(
                    child: Text('LOG IN', style: textStyles.buttonLarge),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
