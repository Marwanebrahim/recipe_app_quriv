import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:recipe_app_quriv/core/helpers/dio_helper.dart';
import 'package:recipe_app_quriv/core/theme/cubit/theme_cubit.dart';
import 'package:recipe_app_quriv/feature/auth/data/datasource/auth_remote_data_source.dart';
import 'package:recipe_app_quriv/feature/auth/data/repository/auth_repository_impl.dart';
import 'package:recipe_app_quriv/feature/auth/domain/repository/auth_repository.dart';
import 'package:recipe_app_quriv/feature/auth/domain/use-case/auth_checked_use_case.dart';
import 'package:recipe_app_quriv/feature/auth/domain/use-case/log_in_use_case.dart';
import 'package:recipe_app_quriv/feature/auth/domain/use-case/sign_up_use_case.dart';
import 'package:recipe_app_quriv/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:recipe_app_quriv/feature/home/data/data-source/remote_data_source.dart';
import 'package:recipe_app_quriv/feature/home/data/repository/home_repository_impl.dart';
import 'package:recipe_app_quriv/feature/home/domain/repository/home_repository.dart';
import 'package:recipe_app_quriv/feature/home/domain/use-case/get_all_categories_use_case.dart';
import 'package:recipe_app_quriv/feature/home/domain/use-case/get_all_recipes_use_case.dart';
import 'package:recipe_app_quriv/feature/home/presentation/bloc/home_bloc.dart';
import 'package:recipe_app_quriv/feature/main_navigation/presentation/cubit/navigation_cubit.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // core packages
  sl.registerLazySingleton<Dio>(() => DioHelper.getDio());
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  // cubits
  sl.registerFactory<ThemeCubit>(() => ThemeCubit());
  sl.registerFactory<NavigationCubit>(() => NavigationCubit());

  // Auth features
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImplWithFireBase(auth: sl(), db: sl()),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<LogInUseCase>(
    () => LogInUseCase(authRepository: sl()),
  );
  sl.registerLazySingleton<SignUpUseCase>(
    () => SignUpUseCase(authRepository: sl()),
  );
sl.registerLazySingleton<AuthCheckedUseCase>(
    () => AuthCheckedUseCase(repository: sl()),
  );
  sl.registerLazySingleton<LogOutUseCase>(
    () => LogOutUseCase(authRepository: sl()),
  );
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(logInUseCase: sl(), signUpUseCase: sl()),
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
