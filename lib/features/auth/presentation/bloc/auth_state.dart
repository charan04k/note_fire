import '../../domain/entities/user_entity.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final UserEntity user;

  AuthSuccess(this.user);
}

class AuthLoggedOut extends AuthState {}

class AuthFailure extends AuthState {
  final String message;

  AuthFailure(this.message);
}