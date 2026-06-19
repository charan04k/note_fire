import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/register_usecase.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterUseCase registerUseCase;
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;

  AuthBloc({
    required this.registerUseCase,
    required this.loginUseCase,
    required this.logoutUseCase,
  }) : super(AuthInitial()) {

    // Register
    on<RegisterEvent>((event, emit) async {
      print("Register Event Triggered");

      emit(AuthLoading());

      try {
        final user = await registerUseCase(
          name: event.name,
          email: event.email,
          password: event.password,
        );

        print("Register Success");

        emit(AuthSuccess(user));
      } catch (e) {
        print("Error: $e");

        emit(AuthFailure(e.toString()));
      }
    });

    // Login
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());

      try {
        final user = await loginUseCase(
          email: event.email,
          password: event.password,
        );

        emit(AuthSuccess(user));
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    // Logout
    on<LogoutEvent>((event, emit) async {
      emit(AuthLoading());

      try {
        await logoutUseCase();

        emit(AuthLoggedOut());
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

  }
}