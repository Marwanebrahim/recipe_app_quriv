import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app_quriv/core/helpers/extensions.dart';
import 'package:recipe_app_quriv/core/theme/app_colors.dart';
import 'package:recipe_app_quriv/core/theme/app_text_style.dart';
import 'package:recipe_app_quriv/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:recipe_app_quriv/feature/profile/presentation/bloc/profile_state.dart';

class GreetingWidget extends StatelessWidget {
  const GreetingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final textStyles = context.appTextStyles;

    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (previous, current) =>
          current is ProfileLoadingState ||
          current is ProfileSuccessState ||
          current is ProfileUpdatingState ||
          current is ProfileErrorState,
      builder: (context, state) {
        if (state is ProfileLoadingState) {
          return _buildGreetingContent(
            context,
            colors,
            textStyles,
            'User',
            null,
          );
        } else if (state is ProfileErrorState) {
          return Center(child: Text(state.message));
        } else if (state is ProfileSuccessState) {
          final profile = state.user;
          return _buildGreetingContent(
            context,
            colors,
            textStyles,
            profile.name,
            profile.imagePath,
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildGreetingContent(
    BuildContext context,
    AppColors colors,
    AppTextStyles textStyles,
    String name,
    String? imagePath,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                text: 'Hello, ',
                style: textStyles.recipeTitle,
                children: [
                  TextSpan(
                    text: name,
                    style: textStyles.recipeTitle.copyWith(
                      color: colors.primary,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'What would you like to cook today?',
              style: textStyles.bodySmall.copyWith(color: colors.grey),
            ),
          ],
        ),
        CircleAvatar(
          radius: 30,
          backgroundColor: colors.lightBackground,
          child: imagePath != null
              ? ClipOval(
                  child: Image.file(
                    File(imagePath),
                    width: 80.w,
                    height: 80.h,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.person,
                      size: 30,
                      color: colors.primary.withValues(alpha: 0.6),
                    ),
                  ),
                )
              : Icon(
                  Icons.person,
                  size: 30,
                  color: colors.primary.withValues(alpha: 0.6),
                ),
        ),
      ],
    );
  }
}
