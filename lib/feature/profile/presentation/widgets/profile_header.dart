import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app_quriv/core/helpers/extensions.dart';
import 'package:recipe_app_quriv/feature/auth/domain/entity/user_entity.dart';
import 'package:recipe_app_quriv/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:recipe_app_quriv/feature/profile/presentation/bloc/profile_event.dart';
import 'package:recipe_app_quriv/feature/profile/presentation/bloc/profile_state.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key, required this.profile});
  final UserEntity profile;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final appTextStyle = context.appTextStyles;
    return Center(
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: colors.lightBackground,
                child: profile.imagePath != null
                    ? ClipOval(
                        child: Image.file(
                          File(profile.imagePath!),
                          width: 80.w,
                          height: 80.h,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Icon(
                            Icons.person,
                            size: 40.w,
                            color: colors.primary.withValues(alpha: 0.6),
                          ),
                        ),
                      )
                    : Icon(
                        Icons.person,
                        size: 40.w,
                        color: colors.primary.withValues(alpha: 0.6),
                      ),
              ),
              BlocBuilder<ProfileBloc, ProfileState>(
                buildWhen: (previous, current) =>
                    current is ProfileUpdatingState ||
                    current is ProfileSuccessState,
                builder: (context, state) {
                  if (state is! ProfileUpdatingState) {
                    return const SizedBox.shrink();
                  }
                  return Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withValues(alpha: 0.35),
                      ),
                      child: const Center(
                        child: SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: GestureDetector(
                  onTap: () =>
                      context.read<ProfileBloc>().add(PickImageEvent()),
                  child: Container(
                    width: 24.w,
                    height: 24.h,
                    decoration: BoxDecoration(
                      color: colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: colors.background, width: 2),
                    ),
                    child: Icon(
                      Icons.edit,
                      size: 16.w,
                      color: colors.primary.withValues(alpha: 0.6),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(profile.name, style: appTextStyle.bodyLarge),
          SizedBox(height: 2.h),
          Text(
            profile.email,
            style: appTextStyle.bodySmall.copyWith(
              color: colors.black.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }
}
