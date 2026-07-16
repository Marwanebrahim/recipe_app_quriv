import 'package:equatable/equatable.dart';

sealed class HomeEvent extends Equatable {}

class GetAllCategoriesEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class GetAllRecipesEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}
