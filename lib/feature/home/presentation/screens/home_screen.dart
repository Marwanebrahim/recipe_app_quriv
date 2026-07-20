import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app_quriv/feature/home/presentation/widgets/category_list_widget.dart';
import 'package:recipe_app_quriv/feature/home/presentation/widgets/greeting_widget.dart';
import 'package:recipe_app_quriv/feature/home/presentation/widgets/search_bar_widget.dart';
import 'package:recipe_app_quriv/feature/home/presentation/widgets/trending_recipes_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      child: SingleChildScrollView( //! use CustomScrollView instead so you won't use shrinWrap in the GridView
        child: Column(
          children: [
            GreetingWidget(),
            SizedBox(height: 32.h),
            SearchBarWidget(),
            SizedBox(height: 64.h),
            CategoryListWidget(),
            SizedBox(height: 64.h),
            TrendingRecipesWidget(),
          ],
        ),
      ),
    );
  }
}
