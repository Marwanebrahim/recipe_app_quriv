import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app_quriv/feature/home/presentation/bloc/home_bloc.dart';
import 'package:recipe_app_quriv/feature/home/presentation/bloc/home_event.dart';
import 'package:recipe_app_quriv/feature/home/presentation/screens/home_screen.dart';
import 'package:recipe_app_quriv/core/di/injection_container.dart';
import 'package:recipe_app_quriv/feature/main_navigation/presentation/cubit/navigation_cubit.dart';
import 'package:recipe_app_quriv/feature/main_navigation/presentation/widgets/custom_bottom_nav_bar.dart';
import 'package:recipe_app_quriv/feature/profile/presentation/screens/profile_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  List<Widget> get _screens => [
    BlocProvider(
      create: (_) => sl<HomeBloc>()
        ..add(GetAllCategoriesEvent())
        ..add(GetAllRecipesEvent()),
      child: const HomeScreen(),
    ),
    const Center(child: Text('Second Screen')),
    const Center(child: Text('Third Screen')),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<NavigationCubit>(),
      child: BlocBuilder<NavigationCubit, int>(
        builder: (context, currentIndex) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Stack(
              children: [
                IndexedStack(
                  index: currentIndex,
                  sizing: StackFit.expand,
                  children: _screens,
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: CustomBottomNavBar(
                    currentIndex: currentIndex,
                    onItemSelected: (int value) =>
                        context.read<NavigationCubit>().changeTab(value),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
