import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_app_quriv/core/helpers/dio_helper.dart';
import 'package:recipe_app_quriv/core/service/image_picker_service.dart';
import 'package:recipe_app_quriv/core/theme/cubit/theme_cubit.dart';
import 'package:recipe_app_quriv/feature/auth/data/datasource/auth_remote_data_source.dart';
import 'package:recipe_app_quriv/feature/auth/data/repository/auth_repository_impl.dart';
import 'package:recipe_app_quriv/feature/auth/domain/repository/auth_repository.dart';
import 'package:recipe_app_quriv/feature/auth/domain/use-case/auth_checked_use_case.dart';
import 'package:recipe_app_quriv/feature/auth/domain/use-case/log_in_use_case.dart';
import 'package:recipe_app_quriv/feature/auth/domain/use-case/log_in_with_google_use_case.dart';
import 'package:recipe_app_quriv/feature/auth/domain/use-case/log_out_use_case.dart';
import 'package:recipe_app_quriv/feature/auth/domain/use-case/sign_up_use_case.dart';
import 'package:recipe_app_quriv/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:recipe_app_quriv/feature/home/data/data-source/remote_data_source.dart';
import 'package:recipe_app_quriv/feature/home/data/repository/home_repository_impl.dart';
import 'package:recipe_app_quriv/feature/home/domain/repository/home_repository.dart';
import 'package:recipe_app_quriv/feature/home/domain/use-case/get_all_categories_use_case.dart';
import 'package:recipe_app_quriv/feature/home/domain/use-case/get_all_recipes_use_case.dart';
import 'package:recipe_app_quriv/feature/home/presentation/bloc/home_bloc.dart';
import 'package:recipe_app_quriv/feature/main_navigation/presentation/cubit/navigation_cubit.dart';
import 'package:recipe_app_quriv/feature/profile/data/datasource/profile_remote_data_source.dart';
import 'package:recipe_app_quriv/feature/profile/data/repository/profile_repository_impl.dart';
import 'package:recipe_app_quriv/feature/profile/domain/repository/profile_repository.dart';
import 'package:recipe_app_quriv/feature/profile/domain/use-case/get_user_profile_use_case.dart';
import 'package:recipe_app_quriv/feature/profile/domain/use-case/pick_image_use_case.dart';
import 'package:recipe_app_quriv/feature/profile/domain/use-case/update_user_profile_use_case.dart';
import 'package:recipe_app_quriv/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:recipe_app_quriv/feature/search/data/datasource/search_data_source.dart';
import 'package:recipe_app_quriv/feature/search/data/repository/search_repository_imp.dart';
import 'package:recipe_app_quriv/feature/search/domain/repository/search_repository.dart';
import 'package:recipe_app_quriv/feature/search/domain/use-case/search_recipe_use_case.dart';
import 'package:recipe_app_quriv/feature/search/presentation/bloc/search_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // core packages
  sl.registerLazySingleton<Dio>(() => DioHelper.getDio());
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  sl.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn.instance);
  sl.registerLazySingleton<ImagePicker>(() => ImagePicker());
  // cubits
  sl.registerFactory<ThemeCubit>(() => ThemeCubit());
  sl.registerFactory<NavigationCubit>(() => NavigationCubit());
  // Services
  sl.registerLazySingleton<ImagePickerService>(
    () => ImagePickerService(imagePicker: sl()),
  );
  // Auth features
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImplWithFireBase(
      auth: sl(),
      db: sl(),
      googleSignIn: sl(),
    ),
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
  sl.registerLazySingleton<LogInWithGoogleUseCase>(
    () => LogInWithGoogleUseCase(authRepository: sl()),
  );
  await sl<GoogleSignIn>().initialize();
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(
      logInUseCase: sl(),
      signUpUseCase: sl(),
      checkAuthUseCase: sl(),
      logInWithGoogleUseCase: sl(),
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
  // search feature
  sl.registerLazySingleton<SearchDataSource>(
    () => SearchDataSourceImpl(dio: sl()),
  );
  sl.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImp(dataSource: sl()),
  );
  sl.registerLazySingleton<SearchRecipeUseCase>(
    () => SearchRecipeUseCase(repository: sl()),
  );
  sl.registerFactory<SearchBloc>(() => SearchBloc(searchRecipeUseCase: sl()));
  // profile feature
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImplWithFirebase(db: sl(), firebaseAuth: sl()),
  );
  sl.registerLazySingleton<ProfileRepository>(
    () =>
        ProfileRepositoryImpl(remoteDataSource: sl(), imagePickerService: sl()),
  );
  sl.registerLazySingleton<GetUserProfileUseCase>(
    () => GetUserProfileUseCase(profileRepository: sl()),
  );
  sl.registerLazySingleton<UpdateUserProfileUseCase>(
    () => UpdateUserProfileUseCase(profileRepository: sl()),
  );
  sl.registerLazySingleton<PickImageUseCase>(
    () => PickImageUseCase(profileRepository: sl()),
  );
  sl.registerFactory<ProfileBloc>(
    () => ProfileBloc(
      getUserProfileUseCase: sl(),
      updateUserProfileUseCase: sl(),
      logOutUseCase: sl(),
      pickImageUseCase: sl(),
    ),
  );
}
