import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget({
    super.key,
    required this.height,
    required this.width,
    this.backgroundColor,
    required this.borderRadius,
    required this.onTap,
    required this.child,
    this.borderColor,
  });
  final double height;
  final double width;
  final Color? backgroundColor;
  final double borderRadius;
  final Color? borderColor;
  final Widget child;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height.h,
        width: width.w,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius.r),
          border: borderColor != null ? Border.all(color: borderColor!) : null,
        ),
        child: child,
      ),
    );
  }
}
