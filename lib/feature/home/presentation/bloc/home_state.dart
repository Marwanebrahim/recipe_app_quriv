import 'package:equatable/equatable.dart';
import 'package:recipe_app_quriv/feature/home/domain/entity/recipe_entity.dart';

sealed class HomeState extends Equatable {}

class HomeInitialState extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeErrorState extends HomeState {
  final String message;

  HomeErrorState({required this.message});

  @override
  List<Object?> get props => [];
}

class RecipeSuccesfulState extends HomeState {
  final List<RecipeEntity> recipes;

  RecipeSuccesfulState({required this.recipes});
  @override
  List<Object?> get props => [recipes];
}

class CategorySuccesfulState extends HomeState {
  final List<String> categories;

  CategorySuccesfulState({required this.categories});
  @override
  List<Object?> get props => [categories];
}
