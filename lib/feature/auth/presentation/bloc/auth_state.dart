import 'package:equatable/equatable.dart';
import 'package:recipe_app_quriv/feature/auth/domain/entity/user_entity.dart';

sealed class AuthState extends Equatable {}

class AuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthSuccess extends AuthState {
  final UserEntity user;

  AuthSuccess({required this.user});

  @override
  List<Object?> get props => [user];
}

class AuthErrorState extends AuthState {
  final String message;

  AuthErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
