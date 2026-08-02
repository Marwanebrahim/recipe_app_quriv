import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app_quriv/core/di/injection_container.dart';
import 'package:recipe_app_quriv/core/routing/app_routes.dart';
import 'package:recipe_app_quriv/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:recipe_app_quriv/feature/auth/presentation/bloc/auth_event.dart';
import 'package:recipe_app_quriv/feature/main_navigation/presentation/screens/main_navigation.dart';
import 'package:recipe_app_quriv/feature/app/presentation/screens/landing_page.dart';
import 'package:recipe_app_quriv/feature/auth/presentation/screens/log_in_screen.dart';
import 'package:recipe_app_quriv/feature/auth/presentation/screens/register_screen.dart';
import 'package:recipe_app_quriv/feature/home/domain/entity/recipe_entity.dart';
import 'package:recipe_app_quriv/feature/home/presentation/screens/details_screen.dart';
import 'package:recipe_app_quriv/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:recipe_app_quriv/feature/profile/presentation/bloc/profile_event.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings setting) {
    switch (setting.name) {
      case AppRoutes.landingPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<AuthBloc>()..add(CheckAuthEvent()),
            child: LandingPage(),
          ),
        );
      case AppRoutes.login:
        return _buildRoute(
          BlocProvider(
            create: (context) => sl<AuthBloc>(),
            child: LogInScreen(),
          ),
          setting,
        );
      case AppRoutes.register:
        return _buildRoute(
          BlocProvider(
            create: (context) => sl<AuthBloc>(),
            child: RegisterScreen(),
          ),
          setting,
        );
      case AppRoutes.mainNavigation:
        return _buildRoute(
          BlocProvider(
            create: (context) => sl<ProfileBloc>()..add(LoadProfileEvent()),
            child: MainNavigation(),
          ),
          setting,
        );
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
