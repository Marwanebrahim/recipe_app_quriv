import 'package:flutter/material.dart';
import 'package:recipe_app_quriv/core/theme/app_colors.dart';
import 'package:recipe_app_quriv/core/theme/app_text_style.dart';

class AppTheme {
  static ThemeData get lightTheme => _build(
    colors: AppColors.light,
    textStyles: AppTextStyles.light(AppColors.light),
    brightness: Brightness.light,
  );

  static ThemeData get darkTheme => _build(
    colors: AppColors.dark,
    textStyles: AppTextStyles.dark(AppColors.dark),
    brightness: Brightness.dark,
  );

  static ThemeData _build({
    required AppColors colors,
    required AppTextStyles textStyles,
    required Brightness brightness,
  }) {
    return ThemeData(
      brightness: brightness,
      extensions: [colors, textStyles],
      scaffoldBackgroundColor: colors.background,
      appBarTheme: AppBarTheme(
        foregroundColor: colors.text,
        backgroundColor: colors.background,
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide.none,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
