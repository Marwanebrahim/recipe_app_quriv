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
      padding: const EdgeInsets.symmetric(horizontal: 20.0 ),
      child: SingleChildScrollView(//TODO  
        child: Column(
          children: [
            //TODO: refresh
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
