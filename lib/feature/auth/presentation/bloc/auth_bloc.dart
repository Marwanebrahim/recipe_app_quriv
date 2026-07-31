import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app_quriv/feature/auth/domain/use-case/auth_checked_use_case.dart';
import 'package:recipe_app_quriv/feature/auth/domain/use-case/log_in_use_case.dart';
import 'package:recipe_app_quriv/feature/auth/domain/use-case/sign_up_use_case.dart';
import 'package:recipe_app_quriv/feature/auth/presentation/bloc/auth_event.dart';
import 'package:recipe_app_quriv/feature/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required this.signUpUseCase,
    required this.logInUseCase,
    required this.checkAuthUseCase,
  }) : super(AuthInitial()) {
    on<SignUpEvent>(_onSignUp);
    on<LogInEvent>(_onLogIn);
    on<CheckAuthEvent>(_onCheckAuth);
  }

  final SignUpUseCase signUpUseCase;
  final LogInUseCase logInUseCase;
  final AuthCheckedUseCase checkAuthUseCase;

  Future<void> _onSignUp(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await signUpUseCase(
      email: event.email,
      password: event.password,
      name: event.name,
    );
    result.fold(
      (failure) => emit(AuthErrorState(message: failure.message)),
      (user) => emit(AuthSuccess(user: user)),
    );
  }

  Future<void> _onLogIn(LogInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await logInUseCase(
      email: event.email,
      password: event.password,
    );
    result.fold(
      (failure) => emit(AuthErrorState(message: failure.message)),
      (user) => emit(AuthSuccess(user: user)),
    );
  }

  Future<void> _onCheckAuth(
    CheckAuthEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await checkAuthUseCase();
    result.fold(
      (failure) => emit(AuthErrorState(message: failure.message)),
      (user) => emit(AuthCheckeckedState()),
    );
  }
}
