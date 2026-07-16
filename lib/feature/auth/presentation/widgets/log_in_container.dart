import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app_quriv/core/routing/app_routes.dart';
import 'package:recipe_app_quriv/core/styles/app_colors.dart';
import 'package:recipe_app_quriv/core/styles/app_text_style.dart';
import 'package:recipe_app_quriv/core/widgets/custom_button_widget.dart';
import 'package:recipe_app_quriv/feature/auth/presentation/widgets/custom_text_form_field.dart';

class LogInContainer extends StatelessWidget {
  const LogInContainer({
    super.key,
    required this.emailController,
    required this.passwordController,
    required GlobalKey<FormState> formKey,
  }) : _formKey = formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> _formKey;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "EMAIL",
              style: AppTextStyles.bold(
                size: 18,
                color: AppColors.black,
                font: AppFont.inter,
              ),
            ),
            SizedBox(height: 8.h),
            CustomTextFormField(
              hintWidget: Row(
                spacing: 6.w,
                children: [
                  Icon(
                    Icons.email_outlined,
                    size: 24.w,
                    color: AppColors.primaryColor,
                  ),
                  Text(
                    "email@gmail.com",
                    style: AppTextStyles.regular(
                      size: 18,
                      color: AppColors.secondaryTextColor.withValues(
                        alpha: 0.6,
                      ),
                    ),
                  ),
                ],
              ),
              isPassword: false,
              controller: emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!RegExp(
                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                ).hasMatch(value)) {
                  return 'Please enter a valid email address';
                }

                return null;
              },
            ),
            SizedBox(height: 18.h),
            Text(
              "PASSWORD",
              style: AppTextStyles.bold(
                size: 18,
                color: AppColors.black,
                font: AppFont.inter,
              ),
            ),
            SizedBox(height: 8.h),
            CustomTextFormField(
              hintWidget: Row(
                spacing: 6.w,
                children: [
                  Icon(
                    Icons.lock_outline,
                    size: 24.w,
                    color: AppColors.primaryColor,
                  ),
                  Text(
                    "••••••••",
                    style: AppTextStyles.regular(
                      size: 18,
                      color: AppColors.secondaryTextColor.withValues(
                        alpha: 0.6,
                      ),
                    ),
                  ),
                ],
              ),
              isPassword: true,
              controller: passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                if (value.length < 8) {
                  return 'Password must be at least 8 characters long';
                }
                return null;
              },
            ),
            SizedBox(height: 46.h),
            CustomButtonWidget(
              hieght: 55,
              width: 361,
              borderRadius: 6,
              backgroundColor: AppColors.primaryColor,
              child: Center(
                child: Text(
                  "LOG IN",
                  style: AppTextStyles.semibold(
                    size: 22,
                    color: AppColors.white,
                  ),
                ),
              ),
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.pushReplacementNamed(context, AppRoutes.home);
                }
              },
            ),
            SizedBox(height: 10.h),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Forgot Password ?",
                style: AppTextStyles.semibold(size: 16, color: AppColors.black),
              ),
            ),
            SizedBox(height: 34.h),
            Center(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Don't have an account ? ",
                      style: AppTextStyles.semibold(
                        size: 18,
                        color: AppColors.black,
                      ),
                    ),
                    TextSpan(
                      text: "Sign Up",
                      style: AppTextStyles.semibold(
                        size: 18,
                        color: AppColors.primaryColor,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushReplacementNamed(
                            context,
                            AppRoutes.register,
                          );
                        },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
