import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_app_quriv/core/constants/app_assets.dart';
import 'package:recipe_app_quriv/core/helpers/extensions.dart';
import 'package:recipe_app_quriv/core/helpers/validators.dart';
import 'package:recipe_app_quriv/core/theme/app_theme.dart';
import 'package:recipe_app_quriv/core/theme/cubit/theme_cubit.dart';
import 'package:recipe_app_quriv/feature/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:recipe_app_quriv/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:recipe_app_quriv/feature/profile/presentation/bloc/profile_event.dart';
import 'package:recipe_app_quriv/feature/profile/presentation/bloc/profile_state.dart';
import 'package:recipe_app_quriv/shared/widgets/custom_button_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Local preview only, until Save is pressed - the bloc doesn't know
  // about this until UpdateProfileEvent fires.
  String? _pickedImagePath;
  bool _nameFieldSeeded = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final file = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (file != null) {
      setState(() => _pickedImagePath = file.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final textStyles = context.appTextStyles;

    return AnimatedTheme(
      data: context.isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
      duration: const Duration(milliseconds: 500),
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state is ProfileSuccessState && !_nameFieldSeeded) {
                _nameController.text = state.user.name;
                _nameFieldSeeded = true;
              }
              if (state is ProfileErrorState) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, state) {
              if (state is ProfileInitialState ||
                  state is ProfileLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }

              final user = state is ProfileSuccessState
                  ? state.user
                  : state is ProfileUpdatingState
                  ? state.user
                  : null;

              if (user == null) {
                return Center(
                  child: Text(
                    "Couldn't load your profile",
                    style: textStyles.bodyMedium,
                  ),
                );
              }

              final isSaving = state is ProfileUpdatingState;
              final displayImagePath = _pickedImagePath ?? user.imagePath;

              return Form(
                key: _formKey,
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 24.h,
                  ),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 56.r,
                            backgroundColor: colors.lightBackground,
                            backgroundImage: displayImagePath != null
                                ? FileImage(File(displayImagePath))
                                      as ImageProvider
                                : const AssetImage(AppAssets.userAvatar),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: _pickImage,
                              child: CircleAvatar(
                                radius: 18.r,
                                backgroundColor: colors.primary,
                                child: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        user.email,
                        style: textStyles.bodySmall.copyWith(
                          color: colors.grey,
                        ),
                      ),
                      SizedBox(height: 32.h),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Name", style: textStyles.formLabel),
                      ),
                      SizedBox(height: 8.h),
                      CustomTextFormField(
                        controller: _nameController,
                        isObsecure: false,
                        validator: (value) => Validators.nameValidator(value),
                        hintWidget: Text(
                          "Name",
                          style: textStyles.bodyLarge.copyWith(
                            color: colors.text.withValues(alpha: 0.6),
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.person_outline,
                          color: colors.primary,
                        ),
                      ),
                      SizedBox(height: 32.h),
                      CustomButtonWidget(
                        height: 55,
                        width: 361,
                        borderRadius: 6,
                        backgroundColor: colors.primary,
                        onTap: isSaving
                            ? () {}
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<ProfileBloc>().add(
                                    UpdateProfileEvent(
                                      name: _nameController.text.trim(),
                                      imagePath: displayImagePath,
                                    ),
                                  );
                                }
                              },
                        child: Center(
                          child: isSaving
                              ? SizedBox(
                                  height: 22,
                                  width: 22,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: colors.white,
                                  ),
                                )
                              : Text('SAVE', style: textStyles.buttonLarge),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      CustomButtonWidget(
                        height: 56,
                        width: 300,
                        borderRadius: 10,
                        backgroundColor: colors.primary,
                        onTap: () {
                          context.read<ThemeCubit>().updateTheme(
                            context.isDarkMode
                                ? ThemeMode.light
                                : ThemeMode.dark,
                          );
                        },
                        child: const Center(child: Text('Toggle theme')),
                      ),
                      SizedBox(height: 16.h),
                      CustomButtonWidget(
                        height: 56,
                        width: 300,
                        borderRadius: 10,
                        backgroundColor: colors.primary,
                        onTap: () {
                          context.read<ProfileBloc>().add(LogoutEvent());
                        },
                        child: const Center(child: Text('Logout')),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
