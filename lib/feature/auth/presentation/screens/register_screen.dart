import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app_quriv/core/helpers/extensions.dart';
import 'package:recipe_app_quriv/feature/auth/presentation/widgets/register_container.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final textStyles = context.appTextStyles;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Create AN ACCOUNT', style: textStyles.screenTitle),

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
