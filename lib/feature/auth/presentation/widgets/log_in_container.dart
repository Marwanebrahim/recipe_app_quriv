import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app_quriv/core/helpers/extensions.dart';
import 'package:recipe_app_quriv/core/helpers/validators.dart';
import 'package:recipe_app_quriv/core/routing/app_routes.dart';
import 'package:recipe_app_quriv/shared/widgets/custom_button_widget.dart';
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
    final colors = context.appColors;
    final textStyles = context.appTextStyles;

    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('EMAIL', style: textStyles.formLabel),
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
              controller: emailController,
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
              controller: passwordController,
              validator: (value) => Validators.passwordValidator(value),
            ),
            SizedBox(height: 46.h),
            CustomButtonWidget(
              height: 55,
              width: 361,
              borderRadius: 6,
              backgroundColor: colors.primary,
              onTap: () {
                if (_formKey.currentState!.validate()) {
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

            SizedBox(height: 10.h),

            Align(
              alignment: Alignment.centerRight,
              child: Text('Forgot Password ?', style: textStyles.bodyMedium),
            ),
            SizedBox(height: 34.h),
            Center(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Don't have an account ? ",
                      style: textStyles.bodyLarge,
                    ),
                    TextSpan(
                      text: 'Sign Up',
                      style: textStyles.bodyLarge,
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
