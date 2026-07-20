import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app_quriv/core/routing/app_routes.dart';
import 'package:recipe_app_quriv/core/constants/app_colors.dart';
import 'package:recipe_app_quriv/core/theme/app_text_style.dart';
import 'package:recipe_app_quriv/core/widgets/custom_button_widget.dart';
import 'package:recipe_app_quriv/feature/home/domain/entity/recipe_entity.dart';

class RecipeCard extends StatelessWidget {
  const RecipeCard({super.key, required this.recipe});
  final RecipeEntity recipe;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.detailsScreen,
          arguments: recipe,
        );
      },
      child: Container(
        height: 260,
        width: 169,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          spacing: 12,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: CachedNetworkImage(
                  imageUrl: recipe.image,
                  fit: BoxFit.cover,
                  height: 186,
                  width: 169,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.error, color: Colors.red),
                ),
              ),
            ),
            Text(
              recipe.name,
              maxLines: 1,
              overflow: TextOverflow.fade,
              style: AppTextStyles.regular(size: 16, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            CustomButtonWidget(
              height: 24,
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
                  style: AppTextStyles.regular(size: 12, color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
