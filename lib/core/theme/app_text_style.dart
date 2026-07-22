import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:recipe_app_quriv/core/constants/app_colors.dart';

enum AppFont { dmSerifDisplay, inter }

class AppTextStyles extends ThemeExtension<AppTextStyles> {
  const AppTextStyles({
    required this.logo,
    required this.screenTitle,
    required this.sectionTitle,
    required this.recipeTitle,
    required this.buttonLarge,
    required this.appBarTitle,
    required this.formLabel,
    required this.bodyLarge,
    required this.bodyMedium,
    required this.recipeName,
    required this.readMore,
    required this.rating,
    required this.bodySmall,
  });
  final TextStyle logo;

  final TextStyle screenTitle;
  final TextStyle sectionTitle;
  final TextStyle recipeTitle;

  final TextStyle buttonLarge;
  final TextStyle appBarTitle;

  final TextStyle formLabel;

  final TextStyle bodyLarge;
  final TextStyle bodyMedium;
  final TextStyle bodySmall;

  final TextStyle recipeName;
  final TextStyle readMore;
  final TextStyle rating;

  static TextStyle _getFont(AppFont font) {
    switch (font) {
      case AppFont.dmSerifDisplay:
        return GoogleFonts.dmSerifDisplay();

      case AppFont.inter:
        return GoogleFonts.inter();
    }
  }

  static TextStyle _textStyle({
    required double fontSize,
    required FontWeight fontWeight,
    required AppFont font,
    required Color color,
  }) {
    return _getFont(
      font,
    ).copyWith(fontSize: fontSize.sp, fontWeight: fontWeight, color: color);
  }

  static AppTextStyles light(AppColors colors) {
    return _build(colors);
  }

  static AppTextStyles dark(AppColors colors) {
    return _build(colors);
  }

  static AppTextStyles _build(AppColors colors) {
    final primaryText = colors.black;

    return AppTextStyles(
      logo: _textStyle(
        fontSize: 76.5,
        fontWeight: FontWeight.normal,
        font: AppFont.dmSerifDisplay,
        color: colors.lightBackground,
      ),

      screenTitle: _textStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        font: AppFont.inter,
        color: primaryText,
      ),

      sectionTitle: _textStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        font: AppFont.inter,
        color: primaryText,
      ),

      recipeTitle: _textStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        font: AppFont.inter,
        color: primaryText,
      ),

      buttonLarge: _textStyle(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        font: AppFont.inter,
        color: colors.white,
      ),

      appBarTitle: _textStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        font: AppFont.inter,
        color: primaryText,
      ),

      formLabel: _textStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        font: AppFont.inter,
        color: primaryText,
      ),

      bodyLarge: _textStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        font: AppFont.inter,
        color: primaryText,
      ),

      bodyMedium: _textStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        font: AppFont.inter,
        color: primaryText,
      ),
      bodySmall: _textStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        font: AppFont.inter,
        color: primaryText,
      ),

      recipeName: _textStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        font: AppFont.inter,
        color: primaryText,
      ),

      readMore: _textStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        font: AppFont.inter,
        color: colors.primary,
      ),

      rating: _textStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        font: AppFont.inter,
        color: colors.white,
      ),
    );
  }

  @override
  AppTextStyles copyWith({
    TextStyle? logo,
    TextStyle? screenTitle,
    TextStyle? sectionTitle,
    TextStyle? recipeTitle,
    TextStyle? buttonLarge,
    TextStyle? appBarTitle,
    TextStyle? formLabel,
    TextStyle? bodyLarge,
    TextStyle? bodyMedium,
    TextStyle? bodySmall,
    TextStyle? secondaryText,
    TextStyle? recipeName,
    TextStyle? readMore,
    TextStyle? rating,
  }) {
    return AppTextStyles(
      logo: logo ?? this.logo,
      screenTitle: screenTitle ?? this.screenTitle,
      sectionTitle: sectionTitle ?? this.sectionTitle,
      recipeTitle: recipeTitle ?? this.recipeTitle,
      buttonLarge: buttonLarge ?? this.buttonLarge,
      appBarTitle: appBarTitle ?? this.appBarTitle,
      formLabel: formLabel ?? this.formLabel,
      bodyLarge: bodyLarge ?? this.bodyLarge,
      bodyMedium: bodyMedium ?? this.bodyMedium,
      recipeName: recipeName ?? this.recipeName,
      readMore: readMore ?? this.readMore,
      rating: rating ?? this.rating,
      bodySmall: bodySmall ?? this.bodySmall,
    );
  }

  @override
  AppTextStyles lerp(covariant AppTextStyles? other, double t) {
    if (other == null) return this;

    return AppTextStyles(
      logo: TextStyle.lerp(logo, other.logo, t)!,
      screenTitle: TextStyle.lerp(screenTitle, other.screenTitle, t)!,
      sectionTitle: TextStyle.lerp(sectionTitle, other.sectionTitle, t)!,
      recipeTitle: TextStyle.lerp(recipeTitle, other.recipeTitle, t)!,
      buttonLarge: TextStyle.lerp(buttonLarge, other.buttonLarge, t)!,
      appBarTitle: TextStyle.lerp(appBarTitle, other.appBarTitle, t)!,
      formLabel: TextStyle.lerp(formLabel, other.formLabel, t)!,
      bodyLarge: TextStyle.lerp(bodyLarge, other.bodyLarge, t)!,
      bodyMedium: TextStyle.lerp(bodyMedium, other.bodyMedium, t)!,
      recipeName: TextStyle.lerp(recipeName, other.recipeName, t)!,
      readMore: TextStyle.lerp(readMore, other.readMore, t)!,
      rating: TextStyle.lerp(rating, other.rating, t)!,
      bodySmall: TextStyle.lerp(bodySmall, other.bodySmall, t)!,
    );
  }
}
