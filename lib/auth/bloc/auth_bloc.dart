import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:like_it/auth/model/user_model.dart';
import 'package:like_it/auth/repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  AuthBloc(this._authRepository) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) => emit(AuthLoading()));

    on<AuthRegistered>(_onRegistered);

    on<AuthLoggedIn>(_onLoggedIn);
  }

  void _onLoggedIn(
    AuthLoggedIn event,
    Emitter<AuthState> emit,
  ) {
    try {
      final _ = _authRepository.login(
        username: event.username,
        phoneNumber: event.phoneNumber,
        password: event.password,
      );
      emit(AuthLoginSuccess());
    } catch (e) {
      emit(AuthLoginFailure());
    }
  }

  void _onRegistered(
    AuthRegistered event,
    Emitter<AuthState> emit,
  ) async {
    final userModel = await _authRepository.register(
      username: event.username,
      phoneNumber: event.phoneNumber,
      password: event.password,
    );

    debugPrint(userModel.toString());

    emit(AuthRegisterSuccess(userModel: userModel));
  }
}
