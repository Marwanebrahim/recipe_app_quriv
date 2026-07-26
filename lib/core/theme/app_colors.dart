import 'package:flutter/material.dart';
import 'package:recipe_app_quriv/core/constants/app_palette.dart';

class AppColors extends ThemeExtension<AppColors> {
  final Color background;
  final Color lightBackground;
  final Color white;
  final Color black;
  final Color primary;
  final Color text;
  final Color grey;
  final Color error;

  const AppColors({
    required this.background,
    required this.lightBackground,
    required this.white,
    required this.black,
    required this.primary,
    required this.text,
    required this.grey,
    required this.error,
  });

  static const light = AppColors(
    background: AppPaletteLightTheme.background,
    lightBackground: AppPaletteLightTheme.lightBackground,
    white: AppPaletteLightTheme.white,
    black: AppPaletteLightTheme.black,
    primary: AppPaletteLightTheme.primary,
    text: AppPaletteLightTheme.text,
    grey: AppPaletteLightTheme.grey,
    error: AppPaletteLightTheme.error,
  );

  static const dark = AppColors(
    background: AppPaletteDarkTheme.background,
    lightBackground: AppPaletteDarkTheme.lightBackground,
    white: AppPaletteDarkTheme.white,
    black: AppPaletteDarkTheme.black,
    primary: AppPaletteDarkTheme.primary,
    text: AppPaletteDarkTheme.text,
    grey: AppPaletteDarkTheme.grey,
    error: AppPaletteDarkTheme.error,
  );

  @override
  AppColors copyWith({
    Color? background,
    Color? lightBackground,
    Color? white,
    Color? black,
    Color? primary,
    Color? text,
    Color? grey,
    Color? surface,
    Color? onSurfaceVariant,
    Color? shadow,
    Color? error,
  }) {
    return AppColors(
      background: background ?? this.background,
      lightBackground: lightBackground ?? this.lightBackground,
      white: white ?? this.white,
      black: black ?? this.black,
      primary: primary ?? this.primary,
      text: text ?? this.text,
      grey: grey ?? this.grey,
      error: error ?? this.error,
    );
  }

  @override
  AppColors lerp(covariant AppColors? other, double t) {
    if (other == null) return this;

    return AppColors(
      background: Color.lerp(background, other.background, t)!,
      lightBackground: Color.lerp(lightBackground, other.lightBackground, t)!,
      white: Color.lerp(white, other.white, t)!,
      black: Color.lerp(black, other.black, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      text: Color.lerp(text, other.text, t)!,
      grey: Color.lerp(grey, other.grey, t)!,
      error: Color.lerp(error, other.error, t)!,
    );
  }
}
