import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app_quriv/core/helpers/extensions.dart';
import 'package:recipe_app_quriv/core/theme/app_colors.dart';
import 'package:recipe_app_quriv/feature/main_navigation/presentation/widgets/nav_bar_item.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onItemSelected,
  });

  final int currentIndex;
  final void Function(int) onItemSelected;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Padding(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h),
      child: Opacity(
        opacity: 0.94,
        child: Container(
          height: 75.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: colors.white,
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(color: colors.black.withValues(alpha: 0.08)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.25),
                blurRadius: 32,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NavBarItem(
                icon: Icons.home_rounded,
                label: 'Home',
                onTap: () => onItemSelected(0),
                color: toggleColor(colors: colors, itemIndex: 0),
              ),
              NavBarItem(
                icon: Icons.list_alt_rounded,
                label: 'List',
                onTap: () => onItemSelected(1),
                color: toggleColor(colors: colors, itemIndex: 1),
              ),
              NavBarItem(
                icon: Icons.receipt_long_rounded,
                label: 'Receipt',
                onTap: () => onItemSelected(2),
                color: toggleColor(colors: colors, itemIndex: 2),
              ),
              NavBarItem(
                icon: Icons.person_rounded,
                label: 'Profile',
                onTap: () => onItemSelected(3),
                color: toggleColor(colors: colors, itemIndex: 3),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color toggleColor({required AppColors colors, required int itemIndex}) =>
      currentIndex == itemIndex
      ? colors.primary
      : colors.black.withValues(alpha: 0.8);
}
