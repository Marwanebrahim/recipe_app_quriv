import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app_quriv/core/helpers/extensions.dart';
import 'package:recipe_app_quriv/feature/auth/presentation/widgets/log_in_container.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final textStyles = context.appTextStyles;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('LOG IN RECI', style: textStyles.screenTitle),

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
