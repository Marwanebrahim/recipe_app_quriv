import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app_quriv/core/helpers/extensions.dart';
import 'package:recipe_app_quriv/core/helpers/validators.dart';
import 'package:recipe_app_quriv/core/routing/app_routes.dart';
import 'package:recipe_app_quriv/shared/widgets/custom_button_widget.dart';
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
    final colors = context.appColors;
    final textStyles = context.appTextStyles;

    return Form(
      key: widget.formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name", style: textStyles.formLabel),

            SizedBox(height: 8.h),
            CustomTextFormField(
              prefixIcon: Icon(
                Icons.person_outline_outlined,
                size: 24.w,
                color: colors.primary,
              ),
              hintWidget: Text(
                "Name",
                style: textStyles.bodyLarge.copyWith(
                  color: colors.text.withValues(alpha: 0.6),
                ),
              ),
              isObsecure: false,
              controller: widget.nameController,
              validator: (value) => Validators.nameValidator(value),
            ),

            SizedBox(height: 18.h),

            Text("EMAIL", style: textStyles.formLabel),
            SizedBox(height: 8.h),
            CustomTextFormField(
              prefixIcon: Icon(
                Icons.email_outlined,
                size: 24.w,
                color: colors.primary,
              ),
              hintWidget: Text(
                "email@gmail.com",
                style: textStyles.bodyLarge.copyWith(
                  color: colors.text.withValues(alpha: 0.6),
                ),
              ),
              isObsecure: false,
              controller: widget.emailController,
              validator: (value) => Validators.emailValidator(value),
            ),
            SizedBox(height: 18.h),
            Text("PASSWORD", style: textStyles.formLabel),

            SizedBox(height: 8.h),
            CustomTextFormField(
              prefixIcon: Icon(
                Icons.lock_outline,
                size: 24.w,
                color: colors.primary,
              ),
              hintWidget: Text(
                "••••••••",
                style: textStyles.bodyLarge.copyWith(
                  color: colors.text.withValues(alpha: 0.6),
                ),
              ),
              isObsecure: true,
              controller: widget.passwordController,
              validator: (value) => Validators.passwordValidator(value),
            ),
            SizedBox(height: 18.h),
            Row(
              children: [
                Checkbox(
                  shape: CircleBorder(
                    side: BorderSide(color: colors.primary, width: 1.5.w),
                  ),
                  activeColor: colors.primary,
                  value: _termsAccepted,
                  onChanged: (value) {
                    setState(() {
                      _termsAccepted = value ?? false;
                    });
                  },
                ),
                Text(
                  "I agree to the Terms & Conditions",
                  style: textStyles.bodyMedium.copyWith(
                    color: colors.black.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
            SizedBox(height: 46.h),
            CustomButtonWidget(
              height: 55,
              width: 361,
              borderRadius: 6,
              backgroundColor: colors.primary,
              onTap: () {
                if (widget.formKey.currentState!.validate() && _termsAccepted) {
                  Navigator.pushReplacementNamed(
                    context,
                    AppRoutes.mainNavigation,
                  );
                }
              },
              child: Center(
                child: Text('LOG IN', style: textStyles.buttonLarge),
              ),
            ),

            SizedBox(height: 20.h),

            Center(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Already have an account? ',
                      style: textStyles.bodySmall.copyWith(
                        color: colors.black.withValues(alpha: 0.6),
                      ),
                    ),
                    TextSpan(
                      text: 'Log In',
                      style: textStyles.bodyMedium.copyWith(
                        color: colors.primary,
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
