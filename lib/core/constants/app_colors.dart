import 'package:flutter/material.dart';

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
    background: Color(0xFFEAEAEA),
    lightBackground: Color(0xFFF3F3F3),
    white: Colors.white,
    black: Colors.black,
    primary: Color(0xFFF26419),
    text: Color(0xFF434343),
    grey: Color(0xFF9F9F9F),
    error: Colors.red,
  );

  static const dark = AppColors(
    background: Color(0xFF121212),
    lightBackground: Color(0xFF2A2A2A),
    white: Color(0xFF1E1E1E),
    black: Colors.white,
    primary: Color(0xFFF26419),
    text: Color(0xFFB0B0B0),
    grey: Color(0xFFB0B0B0),
    error: Colors.red,
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
