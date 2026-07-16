import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app_quriv/core/styles/app_colors.dart';
import 'package:recipe_app_quriv/core/styles/app_text_style.dart';
import 'package:recipe_app_quriv/feature/auth/presentation/widgets/register_container.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Create AN ACCOUNT",
              style: AppTextStyles.bold(size: 28, color: AppColors.black),
            ),
            SizedBox(height: 40.h),
            RegisterContainer(
              nameController: nameController,
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
