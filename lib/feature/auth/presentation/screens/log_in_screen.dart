import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app_quriv/core/styles/app_colors.dart';
import 'package:recipe_app_quriv/core/styles/app_text_style.dart';
import 'package:recipe_app_quriv/feature/auth/presentation/widgets/log_in_container.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor, //! move this to theme
      resizeToAvoidBottomInset: false, //? good catch
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "LOG IN RECI",
              style: AppTextStyles.bold(size: 28, color: AppColors.black),
            ),
            SizedBox(height: 60.h),
            LogInContainer(
              emailController: emailController,
              passwordController: passwordController,
              formKey: _formKey,
            ),
          ],
        ),
      ),
    );
  }
}
