import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liquid_glass_nav/liquid_glass_nav.dart';
import 'package:recipe_app_quriv/core/constants/app_colors.dart';
import 'package:recipe_app_quriv/feature/home/presentation/bloc/home_bloc.dart';
import 'package:recipe_app_quriv/feature/home/presentation/bloc/home_event.dart';
import 'package:recipe_app_quriv/feature/home/presentation/screens/home_screen.dart';
import 'package:recipe_app_quriv/core/di/injection_container.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;
  final _items = [
    const LiquidGlassNavItem(icon: Icons.home_filled, label: 'Home'),
    const LiquidGlassNavItem(icon: Icons.list_alt_outlined, label: 'List'),
    const LiquidGlassNavItem(
      icon: Icons.receipt_long_outlined,
      label: 'Receipt',
    ),
    const LiquidGlassNavItem(icon: Icons.person, label: 'profile'),
  ];
  List<Widget> get _screens => [
    BlocProvider(
      create: (_) => sl<HomeBloc>()
        ..add(GetAllCategoriesEvent())
        ..add(GetAllRecipesEvent()),
      child: const HomeScreen(),
    ),
    const Center(child: Text("second Screen")),
    const Center(child: Text("third Screen")),
    const Center(child: Text("fourth Screen")),
  ];

  void onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            IndexedStack(
              index: _currentIndex,
              sizing: StackFit.expand,
              children: _screens,
            ),
            LiquidGlassBottomNav(
              items: _items,
              currentIndex: _currentIndex,
              onTap: onTap,
              backgroundColor: AppColors.white,
              activeColor: AppColors.primaryColor,
              inactiveColor: AppColors.black,
              shadowBlurRadius: 32.r,
              borderRadius: 24.r,
              borderWidth: 1.5,
            ),
          ],
        ),
      ),
    );
  }
}
