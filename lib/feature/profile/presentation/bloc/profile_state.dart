import 'package:equatable/equatable.dart';
import 'package:recipe_app_quriv/feature/auth/domain/entity/user_entity.dart';

sealed class ProfileState extends Equatable {}

class ProfileInitialState extends ProfileState {
  @override
  List<Object?> get props => [];
}

class ProfileSuccessState extends ProfileState {
  final UserEntity user;

  ProfileSuccessState({required this.user});

  @override
  List<Object?> get props => [user];
}

class ProfileUpdatingState extends ProfileState {
  final UserEntity user;

  ProfileUpdatingState({required this.user});

  @override
  List<Object?> get props => [user];
}

class ProfileErrorState extends ProfileState {
  final String message;

  ProfileErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class ProfileLogoutState extends ProfileState {
  @override
  List<Object?> get props => [];
}
