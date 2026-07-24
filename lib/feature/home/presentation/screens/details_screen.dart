import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app_quriv/core/helpers/extensions.dart';
import 'package:recipe_app_quriv/feature/home/domain/entity/recipe_entity.dart';
import 'package:recipe_app_quriv/feature/home/presentation/widgets/details_widgets/ingredient_container.dart';
import 'package:recipe_app_quriv/feature/home/presentation/widgets/details_widgets/instructions_container.dart';
import 'package:recipe_app_quriv/feature/home/presentation/widgets/details_widgets/time_container.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.recipe});
  final RecipeEntity recipe;

  @override
  Widget build(BuildContext context) {
    final textStyles = context.appTextStyles;
    final colors = context.appColors;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              expandedHeight: 260.h,
              pinned: true,
              backgroundColor: colors.background,
              flexibleSpace: FlexibleSpaceBar(
                background: CachedNetworkImage(
                  imageUrl: recipe.image,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      Container(color: colors.lightBackground),
                  errorWidget: (context, url, error) => Container(
                    color: colors.lightBackground,
                    child: Icon(Icons.restaurant_rounded, color: colors.text),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Transform.translate(
                offset: Offset(14.w, 8),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 16.h, 24.w, 24.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              recipe.name,
                              style: textStyles.buttonLarge.copyWith(
                                color: colors.black,
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 6.h,
                            ),
                            decoration: BoxDecoration(
                              color: colors.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star_rounded,
                                  color: colors.primary,
                                  size: 16,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  recipe.rating.toStringAsFixed(1),
                                  style: textStyles.recipeName.copyWith(
                                    color: colors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 28.h),
                      TimeContainer(
                        prepTime: recipe.prepTimeMinutes,
                        cookTime: recipe.cookTimeMinutes,
                        serving: recipe.servings,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _TabBarDelegate(
                TabBar(
                  labelColor: colors.primary,
                  unselectedLabelColor: colors.black.withValues(alpha: 0.5),
                  indicatorColor: colors.primary,
                  labelStyle: textStyles.bodyMedium,
                  unselectedLabelStyle: textStyles.bodySmall,
                  tabs: const [
                    Tab(text: "Ingredients"),
                    Tab(text: "Instructions"),
                  ],
                ),
              ),
            ),
          ],
          body: TabBarView(
            children: [
              IngredientContainer(ingredients: recipe.ingredients),
              InstructionsContainer(instructions: recipe.instructions),
            ],
          ),
        ),
      ),
    );
  }
}

class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  _TabBarDelegate(this.tabBar);
  final TabBar tabBar;

  @override
  double get minExtent => tabBar.preferredSize.height;
  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return ColoredBox(color: context.appColors.background, child: tabBar);
  }

  @override
  bool shouldRebuild(covariant _TabBarDelegate oldDelegate) =>
      oldDelegate.tabBar != tabBar;
}
