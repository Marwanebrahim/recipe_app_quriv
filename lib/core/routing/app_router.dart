import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:recipe_app_quriv/core/routing/app_routes.dart';
import 'package:recipe_app_quriv/feature/app/presentation/screens/landing_page.dart';

Route<dynamic> onGenerateRoute(RouteSettings setting) {
  switch (setting.name) {
    case AppRoutes.landingPage:
      return MaterialPageRoute(builder: (_) => LandingPage());
    default:
      log("Route not found: ${setting.name}");
      return MaterialPageRoute(builder: (_) => Container());
  }
}
