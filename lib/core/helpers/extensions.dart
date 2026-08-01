import 'package:flutter/material.dart';
import 'package:recipe_app_quriv/core/theme/app_colors.dart';
import 'package:recipe_app_quriv/core/theme/app_text_style.dart';

extension ThemeExtensions on BuildContext {
  AppColors get appColors => Theme.of(this).extension<AppColors>()!;
  AppTextStyles get appTextStyles => Theme.of(this).extension<AppTextStyles>()!;
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
}
