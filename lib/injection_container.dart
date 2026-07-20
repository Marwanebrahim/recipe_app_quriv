//! move to core/di/

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:recipe_app_quriv/core/app-strings/app_strings.dart';
import 'package:recipe_app_quriv/feature/home/data/data-source/remote_data_source.dart';
import 'package:recipe_app_quriv/feature/home/data/repository/home_repository_impl.dart';
import 'package:recipe_app_quriv/feature/home/domain/repository/home_repository.dart';
import 'package:recipe_app_quriv/feature/home/domain/use-case/get_all_categories_use_case.dart';
import 'package:recipe_app_quriv/feature/home/domain/use-case/get_all_recipes_use_case.dart';
import 'package:recipe_app_quriv/feature/home/presentation/bloc/home_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  sl.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: AppStrings.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    ),
  );
  // home features
  sl.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(dio: sl()),
  );
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<GetAllCategoriesUseCase>(
    () => GetAllCategoriesUseCase(homeRepository: sl()),
  );
  sl.registerLazySingleton<GetAllRecipesUseCase>(
    () => GetAllRecipesUseCase(homeRepository: sl()),
  );
  sl.registerFactory<HomeBloc>(
    () => HomeBloc(getAllCategoriesUseCase: sl(), getAllRecipesUseCase: sl()),
  );
}
