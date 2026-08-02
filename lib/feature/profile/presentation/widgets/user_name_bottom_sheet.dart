import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app_quriv/core/helpers/extensions.dart';
import 'package:recipe_app_quriv/core/helpers/validators.dart';
import 'package:recipe_app_quriv/feature/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:recipe_app_quriv/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:recipe_app_quriv/feature/profile/presentation/bloc/profile_event.dart';
import 'package:recipe_app_quriv/shared/widgets/custom_button_widget.dart';

class UserNameBottomSheet extends StatefulWidget {
  const UserNameBottomSheet({super.key});

  @override
  State<UserNameBottomSheet> createState() => _UserNameBottomSheetState();
}

class _UserNameBottomSheetState extends State<UserNameBottomSheet> {
  final TextEditingController controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appTextStyle = context.appTextStyles;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Text("Change Username", style: appTextStyle.bodyLarge),
            SizedBox(height: 30.h),
            CustomTextFormField(
              hintWidget: Text("Username", style: appTextStyle.recipeName),
              isObsecure: false,
              validator: (value) => Validators.nameValidator(value),
              controller: controller,
              prefixIcon: Icon(
                Icons.person_2_sharp,
                color: context.appColors.primary.withValues(alpha: 0.6),
                size: 24,
              ),
            ),
            SizedBox(height: 30.h),
            CustomButtonWidget(
              height: 56.h,
              width: 300.w,
              borderRadius: 14,
              backgroundColor: context.appColors.primary,
              onTap: () {
                if (formKey.currentState!.validate()) {
                  context.read<ProfileBloc>().add(
                    UpdateProfileEvent(name: controller.text),
                  );
                  Navigator.pop(context);
                }
              },
              child: Center(
                child: Text(
                  "Save",
                  style: appTextStyle.bodyLarge.copyWith(
                    color: context.appColors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
