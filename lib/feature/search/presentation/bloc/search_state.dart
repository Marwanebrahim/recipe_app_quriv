import 'package:equatable/equatable.dart';
import 'package:recipe_app_quriv/feature/home/domain/entity/recipe_entity.dart';

sealed class SearchState extends Equatable {}

class SearchInitialState extends SearchState {
  @override
  List<Object?> get props => [];
}

class SearchLoadingState extends SearchState {
  @override
  List<Object?> get props => [];
}

class SearchSuccessState extends SearchState {
  final List<RecipeEntity> recipes;
  SearchSuccessState({required this.recipes});
  @override
  List<Object?> get props => [recipes];
}



class SearchErrorState extends SearchState {
  final String message;

  SearchErrorState({required this.message});
  @override
  List<Object?> get props => [message];
}
