import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app_quriv/core/helpers/extensions.dart';

class InstructionsContainer extends StatelessWidget {
  const InstructionsContainer({super.key, required this.instructions});
  final List<String> instructions;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final textStyles = context.appTextStyles;
    return ListView.builder(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
      itemCount: instructions.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 20.h),
          child: Row(
            spacing: 12.w,
            children: [
              Container(
                height: 28,
                width: 28,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: colors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  "${index + 1}",
                  style: textStyles.recipeName.copyWith(
                    color: colors.primary.withValues(alpha: 0.8),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  instructions[index],
                  style: textStyles.bodySmall.copyWith(height: 1.4),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
