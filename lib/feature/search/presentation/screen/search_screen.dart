import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app_quriv/core/helpers/extensions.dart';
import 'package:recipe_app_quriv/feature/home/domain/entity/recipe_entity.dart';
import 'package:recipe_app_quriv/feature/home/presentation/widgets/home_widgets/recipe_card.dart';
import 'package:recipe_app_quriv/feature/home/presentation/widgets/home_widgets/search_bar_widget.dart';
import 'package:recipe_app_quriv/feature/search/presentation/bloc/search_bloc.dart';
import 'package:recipe_app_quriv/feature/search/presentation/bloc/search_event.dart';
import 'package:recipe_app_quriv/feature/search/presentation/bloc/search_state.dart';
import 'package:recipe_app_quriv/shared/widgets/custom_button_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  Timer? debounce;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _focusNode.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    debounce?.cancel();
    debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<SearchBloc>().add(SearchRecipeEvent(query: value.trim()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          20.w,
          MediaQuery.viewPaddingOf(context).top,
          20.h,
          0,
        ),
        child: Column(
          children: [
            SizedBox(height: 12.h),
            SearchBarWidget(
              controller: _controller,
              focusNode: _focusNode,
              onChanged: _onSearchChanged,
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                buildWhen: (previous, current) =>
                    current is SearchLoadingState ||
                    current is SearchSuccessState ||
                    current is SearchEmptyState ||
                    current is SearchErrorState,
                builder: (context, state) {
                  if (state is SearchLoadingState) {
                    return _buildLoadingState();
                  }
                  if (state is SearchSuccessState) {
                    return _buildSuccessState(state);
                  }
                  if (state is SearchEmptyState) {
                    return _buildEmptyState();
                  }
                  if (state is SearchErrorState) {
                    return _buildErrorState(state, _controller.text);
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Skeletonizer(
      enabled: true,
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(bottom: 20.h),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16.h,
          crossAxisSpacing: 16.w,
          childAspectRatio: 0.72,
        ),
        itemCount: 6,
        itemBuilder: (context, index) {
          return RecipeCard(
            recipe: RecipeEntity(
              id: 1,
              name: 'Recipe name',
              ingredients: [],
              instructions: [],
              prepTimeMinutes: 0,
              cookTimeMinutes: 0,
              servings: 0,
              image: '',
              rating: 0,
            ),
          );
        },
      ),
    );
  }

  Widget _buildSuccessState(SearchSuccessState state) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(bottom: 20.h),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16.h,
        crossAxisSpacing: 16.w,
        childAspectRatio: 0.72,
      ),
      itemCount: state.recipes.length,
      itemBuilder: (context, index) {
        return RecipeCard(recipe: state.recipes[index]);
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off_rounded, size: 64),
            SizedBox(height: 16.h),
            Text(
              'No recipes found',
              textAlign: TextAlign.center,
              style: context.appTextStyles.bodyLarge,
            ),
            SizedBox(height: 8.h),
            Text(
              'Try searching with a different recipe name.',
              textAlign: TextAlign.center,
              style: context.appTextStyles.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(SearchErrorState state, String query) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline_rounded, size: 64),
            SizedBox(height: 16.h),
            Text(
              'Something went wrong',
              textAlign: TextAlign.center,
              style: context.appTextStyles.bodyLarge,
            ),
            SizedBox(height: 8.h),
            Text(
              state.message,
              textAlign: TextAlign.center,
              style: context.appTextStyles.bodyMedium,
            ),
            SizedBox(height: 20.h),
            CustomButtonWidget(
              height: 56.h,
              width: 300.w,
              borderRadius: 14,
              backgroundColor: context.appColors.primary,
              onTap: () {
                context.read<SearchBloc>().add(SearchRecipeEvent(query: query));
              },
              child: Text('Try again', style: context.appTextStyles.bodyLarge),
            ),
          ],
        ),
      ),
    );
  }
}
