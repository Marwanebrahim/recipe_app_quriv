import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app_quriv/feature/auth/domain/use-case/log_out_use_case.dart';
import 'package:recipe_app_quriv/feature/profile/domain/use-case/get_user_profile_use_case.dart';
import 'package:recipe_app_quriv/feature/profile/domain/use-case/update_user_profile_use_case.dart';
import 'package:recipe_app_quriv/feature/profile/presentation/bloc/profile_event.dart';
import 'package:recipe_app_quriv/feature/profile/presentation/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({
    required this.getUserProfileUseCase,
    required this.updateUserProfileUseCase,
    required this.logOutUseCase,
  }) : super(ProfileInitialState()) {
    on<LoadProfileEvent>(_onLoadProfile);
    on<UpdateProfileEvent>(_onUpdateProfile);
    on<LogoutEvent>(_onLogout);
  }

  final GetUserProfileUseCase getUserProfileUseCase;
  final UpdateUserProfileUseCase updateUserProfileUseCase;
  final LogOutUseCase logOutUseCase;

  Future<void> _onLoadProfile(
    LoadProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoadingState());
    final result = await getUserProfileUseCase();
    result.fold(
      (failure) => emit(ProfileErrorState(message: failure.message)),
      (user) => emit(ProfileSuccessState(user: user)),
    );
  }

  Future<void> _onUpdateProfile(
    UpdateProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    final currentState = state;
    final knownUser = currentState is ProfileSuccessState
        ? currentState.user
        : currentState is ProfileUpdatingState
        ? currentState.user
        : null;
    if (knownUser == null) return;
    final result = await updateUserProfileUseCase(
      uid: knownUser.uid,
      email: knownUser.email,
      name: event.name,
      imagePath: event.imagePath,
    );
    result.fold(
      (failure) => emit(ProfileErrorState(message: failure.message)),
      (user) => emit(ProfileSuccessState(user: user)),
    );
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<ProfileState> emit) async {
    final result = await logOutUseCase();
    result.fold(
      (failure) => emit(ProfileErrorState(message: failure.message)),
      (_) => emit(ProfileLogoutState()),
    );
  }
}
