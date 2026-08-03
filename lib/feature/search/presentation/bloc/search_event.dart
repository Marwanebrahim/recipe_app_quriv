import 'package:equatable/equatable.dart';

sealed class SearchEvent extends Equatable {}

class SearchRecipeEvent extends SearchEvent {
  final String query;
  SearchRecipeEvent({required this.query});
  @override
  List<Object?> get props => [query];
}
