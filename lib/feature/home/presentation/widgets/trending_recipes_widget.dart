import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app_quriv/core/helpers/extensions.dart';
import 'package:recipe_app_quriv/feature/home/presentation/bloc/home_bloc.dart';
import 'package:recipe_app_quriv/feature/home/presentation/bloc/home_state.dart';
import 'package:recipe_app_quriv/feature/home/presentation/widgets/recipe_card.dart';

class TrendingRecipesWidget extends StatelessWidget {
  const TrendingRecipesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final textStyles = context.appTextStyles;

    return SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(
          child: Text('Trending Recipes', style: textStyles.sectionTitle),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 16.h)),
        BlocBuilder<HomeBloc, HomeState>(
          buildWhen: (previous, current) =>
              current is RecipeSuccesfulState ||
              current is HomeErrorState ||
              current is HomeLoadingState,
          builder: (context, state) {
            if (state is HomeLoadingState) {
              //TODO: add shimmer effect
              return SliverToBoxAdapter(
                child: Center(
                  child: CircularProgressIndicator(color: colors.primary),
                ),
              );
            } else if (state is RecipeSuccesfulState) {
              return SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16.h,
                  crossAxisSpacing: 16.w,
                  childAspectRatio: 0.72,
                ),
                delegate: SliverChildBuilderDelegate(
                  childCount: state.recipes.length,
                  (context, index) => RecipeCard(recipe: state.recipes[index]),
                ),
              );
            } else if (state is HomeErrorState) {
              return SliverToBoxAdapter(
                child: Text(
                  state.message,
                  style: textStyles.recipeName.copyWith(
                    fontWeight: FontWeight.normal,
                    color: colors.text,
                  ),
                ),
              );
            } else {
              return const SliverToBoxAdapter(child: SizedBox.shrink());
            }
          },
        ),
      ],
    );
  }
}
