import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app_quriv/core/helpers/extensions.dart';
import 'package:recipe_app_quriv/feature/home/presentation/bloc/home_bloc.dart';
import 'package:recipe_app_quriv/feature/home/presentation/bloc/home_event.dart';
import 'package:recipe_app_quriv/feature/home/presentation/widgets/category_list_widget.dart';
import 'package:recipe_app_quriv/feature/home/presentation/widgets/greeting_widget.dart';
import 'package:recipe_app_quriv/feature/home/presentation/widgets/search_bar_widget.dart';
import 'package:recipe_app_quriv/feature/home/presentation/widgets/trending_recipes_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;

    return RefreshIndicator(
      color: colors.primary,
      onRefresh: () async => context.read<HomeBloc>()
        ..add(GetAllCategoriesEvent())
        ..add(GetAllRecipesEvent()),
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        slivers: [
          SliverAppBar(
            pinned: true,
            elevation: 0,
            scrolledUnderElevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: theme.scaffoldBackgroundColor,
            expandedHeight: 150.h,
            title: const GreetingWidget(),
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [SizedBox(height: 20), SearchBarWidget()],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            sliver: const SliverToBoxAdapter(child: CategoryListWidget()),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            sliver: const TrendingRecipesWidget(),
          ),
        ],
      ),
    );
  }
}
