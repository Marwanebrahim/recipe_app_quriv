import 'package:flutter/material.dart';
import 'package:recipe_app_quriv/core/routing/app_routes.dart';
import 'package:recipe_app_quriv/feature/main_navigation/presentation/screens/main_navigation.dart';
import 'package:recipe_app_quriv/feature/app/presentation/screens/landing_page.dart';
import 'package:recipe_app_quriv/feature/auth/presentation/screens/log_in_screen.dart';
import 'package:recipe_app_quriv/feature/auth/presentation/screens/register_screen.dart';
import 'package:recipe_app_quriv/feature/home/domain/entity/recipe_entity.dart';
import 'package:recipe_app_quriv/feature/home/presentation/screens/details_screen.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings setting) {
    switch (setting.name) {
      case AppRoutes.landingPage:
        return MaterialPageRoute(builder: (_) => LandingPage());
      case AppRoutes.login:
        return _buildRoute(LogInScreen(), setting);
      case AppRoutes.register:
        return _buildRoute(RegisterScreen(), setting);
      case AppRoutes.mainNavigation:
        return _buildRoute(MainNavigation(), setting);
      case AppRoutes.detailsScreen:
        final recipe = setting.arguments as RecipeEntity;
        return MaterialPageRoute(
          builder: (context) => DetailsScreen(recipe: recipe),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text("Route not found: ${setting.name}")),
          ),
        );
    }
  }

  static PageRouteBuilder _buildRoute(Widget page, RouteSettings setting) {
    return PageRouteBuilder(
      settings: setting,

      pageBuilder: (context, animation, secondaryAnimation) {
        return page;
      },

      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        final tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));

        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }
}
