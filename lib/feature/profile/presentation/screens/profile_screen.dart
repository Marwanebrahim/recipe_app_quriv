import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app_quriv/core/helpers/extensions.dart';
import 'package:recipe_app_quriv/core/routing/app_routes.dart';
import 'package:recipe_app_quriv/core/theme/app_theme.dart';
import 'package:recipe_app_quriv/core/theme/cubit/theme_cubit.dart';
import 'package:recipe_app_quriv/feature/auth/domain/entity/user_entity.dart';
import 'package:recipe_app_quriv/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:recipe_app_quriv/feature/profile/presentation/bloc/profile_event.dart';
import 'package:recipe_app_quriv/feature/profile/presentation/bloc/profile_state.dart';
import 'package:recipe_app_quriv/feature/profile/presentation/widgets/profile_header.dart';
import 'package:recipe_app_quriv/feature/profile/presentation/widgets/profile_menu_tile.dart';
import 'package:recipe_app_quriv/feature/profile/presentation/widgets/user_name_bottom_sheet.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final appTextStyle = context.appTextStyles;
    return AnimatedTheme(
      data: context.isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
      child: BlocBuilder<ProfileBloc, ProfileState>(
        buildWhen: (previous, current) =>
            current is ProfileSuccessState ||
            current is ProfileErrorState ||
            current is ProfileUpdatingState,
        builder: (context, state) {
          if (state is ProfileSuccessState) {
            return BlocProvider.value(
              value: context.read<ProfileBloc>(),
              child: _profileContent(context: context, profile: state.user),
            );
          } else if (state is ProfileUpdatingState) {
            return BlocProvider.value(
              value: context.read<ProfileBloc>(),
              child: _profileContent(context: context, profile: state.user),
            );
          } else if (state is ProfileErrorState) {
            return Center(
              child: Text(state.message, style: appTextStyle.bodyMedium),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _profileContent({
    required BuildContext context,
    required UserEntity profile,
  }) {
    final colors = context.appColors;
    final appTextStyle = context.appTextStyles;
    return Padding(
      padding: EdgeInsets.fromLTRB(
        20.w,
        MediaQuery.paddingOf(context).top + 20.h,
        20.w,
        MediaQuery.paddingOf(context).bottom,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileHeader(profile: profile),
          SizedBox(height: 50.h),
          Text(
            "Settings",
            style: appTextStyle.bodyLarge.copyWith(
              color: colors.black.withValues(alpha: 0.85),
            ),
          ),
          SizedBox(height: 20),
          ProfileMenuTile(
            title: "Change password",
            icon: Icons.person,
            onTap: () {},
          ),
          SizedBox(height: 4.h),
          ProfileMenuTile(
            title: "Change Username",
            icon: Icons.person,
            onTap: () {
              final profileBloc = context.read<ProfileBloc>();
              showModalBottomSheet(
                context: context,
                backgroundColor: colors.background,
                builder: (sheetContext) {
                  return BlocProvider.value(
                    value: profileBloc,
                    child: UserNameBottomSheet(initialName: profile.name),
                  );
                },
              );
            },
          ),
          SizedBox(height: 12.h),
          Text("Preferences", style: appTextStyle.bodyLarge),
          SizedBox(height: 4.h),
          ProfileMenuTile(
            title: "Dark Mode",
            icon: Icons.dark_mode_rounded,
            usedForNavigation: false,
            trailing: Switch(
              value: context.isDarkMode,
              activeTrackColor: colors.primary.withValues(alpha: 0.35),
              activeThumbColor: colors.primary.withValues(alpha: 0.8),
              onChanged: (value) => context.read<ThemeCubit>().toggleTheme(),
            ),
            onTap: () {},
          ),

          SizedBox(height: 12.h),
          Text("General", style: appTextStyle.bodyLarge),
          SizedBox(height: 4.h),
          ProfileMenuTile(
            title: "Logout",
            icon: Icons.logout_rounded,
            isDanger: true,
            onTap: () {
              context.read<ProfileBloc>().add(LogoutEvent());
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.landingPage,
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
