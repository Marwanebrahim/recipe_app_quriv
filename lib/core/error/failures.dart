import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure({required this.message});
  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure() : super(message: 'Something went wrong, try again');
}

class OfflineFailure extends Failure {
  const OfflineFailure() : super(message: 'No internet connection');
}

class EmailAlreadyInUseFailure extends Failure {
  const EmailAlreadyInUseFailure() : super(message: 'Email already in use');
}

class InvalidCredentialsFailure extends Failure {
  const InvalidCredentialsFailure() : super(message: 'Invalid credentials');
}

class ImageStorageFailure extends Failure {
  const ImageStorageFailure() : super(message: 'Image storage failure');
}
