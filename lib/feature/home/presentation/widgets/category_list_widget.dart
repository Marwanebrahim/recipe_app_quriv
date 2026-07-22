import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app_quriv/core/constants/app_assets.dart';
import 'package:recipe_app_quriv/core/helpers/extensions.dart';
import 'package:recipe_app_quriv/feature/home/presentation/bloc/home_bloc.dart';
import 'package:recipe_app_quriv/feature/home/presentation/bloc/home_state.dart';

class CategoryListWidget extends StatelessWidget {
  const CategoryListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final textStyles = context.appTextStyles;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Categories',
          style: textStyles.sectionTitle,
        ),

        SizedBox(height: 32.h),

        BlocBuilder<HomeBloc, HomeState>(
          buildWhen: (previous, current) =>
              current is CategorySuccesfulState ||
              current is HomeErrorState ||
              current is HomeLoadingState,
          builder: (context, state) {
            if (state is HomeLoadingState) {
              // TODO: add shimmer effect
              return Center(
                child: CircularProgressIndicator(color: colors.primary),
              );
            }

            if (state is CategorySuccesfulState) {
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
                          borderRadius: BorderRadius.circular(8.r),
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
                          style: textStyles.bodySmall.copyWith(
                            color: colors.black,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            }
            if (state is HomeErrorState) {
              return Center(child: Text(state.message));
            }

            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
