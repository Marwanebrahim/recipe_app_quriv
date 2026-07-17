import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app_quriv/core/routing/app_routes.dart';
import 'package:recipe_app_quriv/core/styles/app_colors.dart';
import 'package:recipe_app_quriv/core/styles/app_text_style.dart';
import 'package:recipe_app_quriv/core/widgets/custom_button_widget.dart';
import 'package:recipe_app_quriv/feature/home/presentation/bloc/home_bloc.dart';
import 'package:recipe_app_quriv/feature/home/presentation/bloc/home_state.dart';

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
                  childAspectRatio: 0.9,
                ),
                itemCount: state.recipes.length,
                itemBuilder: (context, index) {
                  final recipe = state.recipes[index];
                  return Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            recipe.image,
                            fit: BoxFit.cover,
                            height: 186.h,
                            width: 169.w,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.error, color: Colors.red);
                            },
                          ),
                        ),
                      ),
                      Text(
                        recipe.name,
                        style: AppTextStyles.regular(
                          size: 16,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      CustomButtonWidget(
                        hieght: 24,
                        width: 86,
                        borderRadius: 4,
                        borderColor: AppColors.primaryColor,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.detailsScreen,
                            arguments: recipe,
                          );
                        },
                        child: Center(
                          child: Text(
                            'Read More',
                            style: AppTextStyles.regular(
                              size: 12,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
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
