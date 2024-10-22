import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:like_it/auth/repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  AuthBloc(this._authRepository) : super(AuthInitial()) {
    // on<AuthEvent>((event, emit) {});
    on<AuthLoggedIn>(_loggedIn);
  }

  void _loggedIn(
    AuthLoggedIn event,
    Emitter<AuthState> emit,
  ) {
    emit(AuthLoading());
    try {
      final _ = _authRepository.login(
        email: event.email,
        password: event.password,
      );
      emit(AuthLoginSuccess());
    } catch (e) {
      emit(AuthLoginFailure());
    }
  }
}
