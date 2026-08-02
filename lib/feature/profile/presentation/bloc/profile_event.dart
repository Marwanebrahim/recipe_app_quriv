import 'package:equatable/equatable.dart';

sealed class ProfileEvent extends Equatable {}

class LoadProfileEvent extends ProfileEvent {
  @override
  List<Object?> get props => [];
}

class UpdateProfileEvent extends ProfileEvent {
  final String name;
  final String? imagePath;

  UpdateProfileEvent({required this.name, this.imagePath});

  @override
  List<Object?> get props => [name, imagePath];
}

class PickImageEvent extends ProfileEvent {
  @override
  List<Object?> get props => [];
}

class LogoutEvent extends ProfileEvent {
  @override
  List<Object?> get props => [];
}
