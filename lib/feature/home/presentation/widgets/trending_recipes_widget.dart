import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app_quriv/core/theme/app_text_style.dart';
import 'package:recipe_app_quriv/feature/home/presentation/bloc/home_bloc.dart';
import 'package:recipe_app_quriv/feature/home/presentation/bloc/home_state.dart';
import 'package:recipe_app_quriv/feature/home/presentation/widgets/recipe_card.dart';

class TrendingRecipesWidget extends StatelessWidget {
  const TrendingRecipesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Trending Recipes',
          style: AppTextStyles.semibold(size: 24, color: Colors.black),
        ),
        SizedBox(height: 32.h),
        BlocBuilder<HomeBloc, HomeState>(
          buildWhen: (previous, current) =>
              current is RecipeSuccesfulState ||
              current is HomeErrorState ||
              current is HomeLoadingState,
          builder: (context, state) {
            if (state is HomeLoadingState) {
              //TODO: add shimmer effect
              return const Center(child: CircularProgressIndicator());
            } else if (state is RecipeSuccesfulState) {
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16.h,
                  crossAxisSpacing: 16.w,
                  childAspectRatio: 0.85,
                ),
                itemCount: state.recipes.length,
                itemBuilder: (context, index) {
                  final recipe = state.recipes[index];
                  return RecipeCard(recipe: recipe);
                },
              );
            } else if (state is HomeErrorState) {
              return Text(state.message);
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}
