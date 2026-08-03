import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app_quriv/feature/search/domain/use-case/search_recipe_use_case.dart';
import 'package:recipe_app_quriv/feature/search/presentation/bloc/search_event.dart';
import 'package:recipe_app_quriv/feature/search/presentation/bloc/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({required this.searchRecipeUseCase})
    : super(SearchInitialState()) {
    on<SearchRecipeEvent>(_onSearchRecipeEvent);
  }
  final SearchRecipeUseCase searchRecipeUseCase;
  Future<void> _onSearchRecipeEvent(
    SearchRecipeEvent event,
    Emitter<SearchState> emit,
  ) async {
    emit(SearchLoadingState());
    final result = await searchRecipeUseCase(event.query);
    result.fold(
      (failure) => emit(SearchErrorState(message: failure.message)),
      (recipes) => emit(
        recipes.isEmpty
            ? SearchEmptyState()
            : SearchSuccessState(recipes: recipes),
      ),
    );
  }
}
