import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app_quriv/core/constants/app_assets.dart';
import 'package:recipe_app_quriv/core/theme/app_text_style.dart';
import 'package:recipe_app_quriv/feature/home/presentation/bloc/home_bloc.dart';
import 'package:recipe_app_quriv/feature/home/presentation/bloc/home_state.dart';

class CategoryListWidget extends StatelessWidget {
  const CategoryListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Categories',
          style: AppTextStyles.semibold(size: 24, color: Colors.black),
        ),
        SizedBox(height: 32.h),
        BlocBuilder<HomeBloc, HomeState>(
          buildWhen: (previous, current) =>
              current is CategorySuccesfulState ||
              current is HomeErrorState ||
              current is HomeLoadingState,
          builder: (context, state) {
            if (state is HomeLoadingState) {
              //TODO: add shimmer effect
              return const Center(child: CircularProgressIndicator());
            } else if (state is CategorySuccesfulState) {
              return SizedBox(
                height: 140.h,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),

                  itemCount: state.categories.length,
                  separatorBuilder: (context, index) => SizedBox(width: 16.w),
                  itemBuilder: (context, index) {
                    final category = state.categories[index];
                    return Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),

                          child: Image.asset(
                            AppAssets.categoryImage,
                            fit: BoxFit.cover,
                            height: 100.h,
                            width: 100.w,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          category,
                          style: AppTextStyles.regular(
                            size: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            } else if (state is HomeErrorState) {
              return Center(child: Text(state.message));
            } else {
              return SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}
