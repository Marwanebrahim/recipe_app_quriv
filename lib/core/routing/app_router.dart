import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:recipe_app_quriv/core/routing/app_routes.dart';
import 'package:recipe_app_quriv/feature/app/presentation/screens/landing_page.dart';
import 'package:recipe_app_quriv/feature/auth/presentation/screens/log_in_screen.dart';
import 'package:recipe_app_quriv/feature/auth/presentation/screens/register_screen.dart';

Route<dynamic> onGenerateRoute(RouteSettings setting) {
  switch (setting.name) {
    case AppRoutes.landingPage:
      return MaterialPageRoute(builder: (_) => LandingPage());
    case AppRoutes.login:
      return MaterialPageRoute(builder: (_) => LogInScreen());
    case AppRoutes.register:
      return MaterialPageRoute(builder: (_) => RegisterScreen());
    default:
      log("Route not found: ${setting.name}");
      return MaterialPageRoute(builder: (_) => Container());
  }
}
