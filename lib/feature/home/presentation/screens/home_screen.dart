import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app_quriv/core/helpers/extensions.dart';
import 'package:recipe_app_quriv/core/routing/app_routes.dart';
import 'package:recipe_app_quriv/feature/home/presentation/bloc/home_bloc.dart';
import 'package:recipe_app_quriv/feature/home/presentation/bloc/home_event.dart';
import 'package:recipe_app_quriv/feature/home/presentation/widgets/home_widgets/category_list_widget.dart';
import 'package:recipe_app_quriv/feature/home/presentation/widgets/home_widgets/greeting_widget.dart';
import 'package:recipe_app_quriv/feature/home/presentation/widgets/home_widgets/search_bar_widget.dart';
import 'package:recipe_app_quriv/feature/home/presentation/widgets/home_widgets/trending_recipes_widget.dart';
import 'package:recipe_app_quriv/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:recipe_app_quriv/feature/profile/presentation/bloc/profile_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            expandedHeight: 150.h,
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                final expandedHeight = 150.h;

                final collapsedHeight =
                    kToolbarHeight + MediaQuery.paddingOf(context).top;

                final currentHeight = constraints.maxHeight;

                final progress =
                    ((currentHeight - collapsedHeight) /
                            (expandedHeight - collapsedHeight))
                        .clamp(0.0, 1.0);

                return Stack(
                  fit: StackFit.expand,
                  children: [
                    // Expanded UI
                    Positioned(
                      left: 20.w,
                      right: 20.w,
                      bottom: 20.h,
                      child: Opacity(
                        opacity: progress,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GreetingWidget(),
                            SizedBox(height: 20),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.searchScreen,
                                );
                              },
                              child: AbsorbPointer(child: SearchBarWidget()),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Collapsed title
                    Positioned(
                      left: 20.w,
                      bottom: 16.h,
                      child: Opacity(
                        opacity: 1 - progress,
                        child: BlocBuilder<ProfileBloc, ProfileState>(
                          buildWhen: (previous, current) =>
                              current is ProfileSuccessState ||
                              current is ProfileUpdatingState,
                          builder: (context, state) {
                            if (state is ProfileSuccessState) {
                              return _buildCollapsedTitle(
                                name: state.user.name,
                                context: context,
                              );
                            } else if (state is ProfileUpdatingState) {
                              return _buildCollapsedTitle(
                                name: state.user.name,
                                context: context,
                              );
                            } else {
                              return SizedBox.shrink();
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                );
              },
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

  Widget _buildCollapsedTitle({
    required String name,
    required BuildContext context,
  }) {
    return Text("HI, $name", style: context.appTextStyles.sectionTitle);
  }
}
