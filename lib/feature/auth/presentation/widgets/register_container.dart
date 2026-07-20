import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app_quriv/core/helpers/validators.dart';
import 'package:recipe_app_quriv/core/routing/app_routes.dart';
import 'package:recipe_app_quriv/core/constants/app_colors.dart';
import 'package:recipe_app_quriv/core/theme/app_text_style.dart';
import 'package:recipe_app_quriv/core/widgets/custom_button_widget.dart';
import 'package:recipe_app_quriv/feature/auth/presentation/widgets/custom_text_form_field.dart';

class RegisterContainer extends StatefulWidget {
  const RegisterContainer({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
  });
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  @override
  State<RegisterContainer> createState() => _RegisterContainerState();
}

class _RegisterContainerState extends State<RegisterContainer> {
  bool _termsAccepted = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Name",
              style: AppTextStyles.bold(
                size: 18,
                color: AppColors.black,
                font: AppFont.inter,
              ),
            ),
            SizedBox(height: 8.h),
            CustomTextFormField(
              prefixIcon: Icon(
                Icons.person_outline_outlined,
                size: 24.w,
                color: AppColors.primaryColor,
              ),
              hintWidget: Text(
                "Name",
                style: AppTextStyles.regular(
                  size: 18,
                  color: AppColors.secondaryTextColor.withValues(alpha: 0.6),
                ),
              ),
              isObsecure: false,
              controller: widget.nameController,
              validator: (value) => Validators.nameValidator(value),
            ),
            SizedBox(height: 18.h),
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
              prefixIcon: Icon(
                Icons.email_outlined,
                size: 24.w,
                color: AppColors.primaryColor,
              ),
              hintWidget: Text(
                "email@gmail.com",
                style: AppTextStyles.regular(
                  size: 18,
                  color: AppColors.secondaryTextColor.withValues(alpha: 0.6),
                ),
              ),
              isObsecure: false,
              controller: widget.emailController,
              validator: (value) => Validators.emailValidator(value),
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
              prefixIcon: Icon(
                Icons.lock_outline,
                size: 24.w,
                color: AppColors.primaryColor,
              ),
              hintWidget: Text(
                "••••••••",
                style: AppTextStyles.regular(
                  size: 18,
                  color: AppColors.secondaryTextColor.withValues(alpha: 0.6),
                ),
              ),
              isObsecure: true,
              controller: widget.passwordController,
              validator: (value) => Validators.passwordValidator(value),
            ),
            SizedBox(height: 18.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  shape: CircleBorder(
                    side: BorderSide(
                      color: AppColors.primaryColor,
                      width: 1.5.w,
                    ),
                  ),
                  activeColor: AppColors.primaryColor,
                  value: _termsAccepted,
                  onChanged: (value) {
                    setState(() {
                      _termsAccepted = value ?? false;
                    });
                  },
                ),
                Text(
                  "I agree to the Terms & Conditions",
                  style: AppTextStyles.semibold(
                    size: 16,
                    color: AppColors.black.withValues(alpha: 0.6),
                    font: AppFont.inter,
                  ),
                ),
              ],
            ),
            SizedBox(height: 46.h),
            CustomButtonWidget(
              height: 55,
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
                if (widget.formKey.currentState!.validate() && _termsAccepted) {
                  Navigator.pushReplacementNamed(context, AppRoutes.mainNavigation);
                }
              },
            ),
            SizedBox(height: 20.h),
            Center(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Already have an account? ",
                      style: AppTextStyles.regular(
                        size: 16,
                        color: AppColors.black.withValues(alpha: 0.6),
                        font: AppFont.inter,
                      ),
                    ),
                    TextSpan(
                      text: "Log In",
                      style: AppTextStyles.bold(
                        size: 16,
                        color: AppColors.primaryColor,
                        font: AppFont.inter,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushReplacementNamed(
                            context,
                            AppRoutes.login,
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
