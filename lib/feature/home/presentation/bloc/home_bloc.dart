import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app_quriv/feature/home/domain/use-case/get_all_categories_use_case.dart';
import 'package:recipe_app_quriv/feature/home/domain/use-case/get_all_recipes_use_case.dart';
import 'package:recipe_app_quriv/feature/home/presentation/bloc/home_event.dart';
import 'package:recipe_app_quriv/feature/home/presentation/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required this.getAllCategoriesUseCase,
    required this.getAllRecipesUseCase,
  }) : super(HomeInitialState()) {
    on<GetAllCategoriesEvent>(_getAllCategoriesEvent);
    on<GetAllRecipesEvent>(_getAllRecipesEvent);
  }

  final GetAllCategoriesUseCase getAllCategoriesUseCase;
  final GetAllRecipesUseCase getAllRecipesUseCase;
  void _getAllCategoriesEvent(
    GetAllCategoriesEvent event,
    Emitter<HomeState> emit,
  ) async {
    final result = await getAllCategoriesUseCase();
    result.fold(
      (l) => emit(HomeErrorState(message: l.message)),
      (r) => emit(CategorySuccesfulState(categories: r)),
    );
  }

  void _getAllRecipesEvent(
    GetAllRecipesEvent event,
    Emitter<HomeState> emit,
  ) async {
    final result = await getAllRecipesUseCase();
    result.fold(
      (l) => emit(HomeErrorState(message: l.message)),
      (r) => emit(RecipeSuccesfulState(recipes: r)),
    );
  }
}
