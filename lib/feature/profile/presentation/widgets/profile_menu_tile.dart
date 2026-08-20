import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app_quriv/core/helpers/extensions.dart';

class ProfileMenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isDanger;
  final bool usedForNavigation;
  final Widget? trailing;
  const ProfileMenuTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.isDanger = false,
    this.trailing,
    this.usedForNavigation = true,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final textStyles = context.appTextStyles;
    final color = isDanger ? colors.error : colors.black.withValues(alpha: 0.7);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: colors.white,
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20.w, color: color),
            SizedBox(width: 14.w),
            Expanded(
              child: Text(
                title,
                style: textStyles.bodyMedium.copyWith(color: color),
              ),
            ),
            SizedBox(width: 4.w),
            ?trailing,
            SizedBox(width: 4.w),
            if (usedForNavigation)
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14.w,
                color: color.withValues(alpha: 0.4),
              ),
          ],
        ),
      ),
    );
  }
}
