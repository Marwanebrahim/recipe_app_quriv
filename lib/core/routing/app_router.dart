import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:recipe_app_quriv/core/routing/app_routes.dart';
import 'package:recipe_app_quriv/feature/app/presentation/screens/splash_screen.dart';

  Route<dynamic> onGenerateRoute(RouteSettings setting) {
    switch (setting.name) {
      case AppRoutes.landingPage:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      default:
        log("Route not found: ${setting.name}");
        return MaterialPageRoute(builder: (_) => Container());
    }
  }

