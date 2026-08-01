import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app_quriv/core/helpers/extensions.dart';
import 'package:recipe_app_quriv/feature/home/domain/entity/recipe_entity.dart';
import 'package:recipe_app_quriv/feature/home/presentation/bloc/home_bloc.dart';
import 'package:recipe_app_quriv/feature/home/presentation/bloc/home_state.dart';
import 'package:recipe_app_quriv/feature/home/presentation/widgets/home_widgets/recipe_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
              return _buildLoadingState();
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

  SliverSkeletonizer _buildLoadingState() {
    return  SliverSkeletonizer(
      child: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16.h,
          crossAxisSpacing: 16.w,
          childAspectRatio: 0.72,
        ),
        delegate: SliverChildBuilderDelegate(
          childCount: 4,
          (context, index) => RecipeCard(
            recipe: RecipeEntity(
              id: 1,
              name: '',
              ingredients: [],
              instructions: [],
              prepTimeMinutes: 1,
              cookTimeMinutes: 1,
              servings: 1,
              image: '',
              rating: 1,
            ),
          ),
        ),
      ),
    );
  }
}
