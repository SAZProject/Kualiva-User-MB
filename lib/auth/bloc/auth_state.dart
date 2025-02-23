part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthTokenExist extends AuthState {}

final class AuthTokenNotExist extends AuthState {}

final class AuthLoginSuccess extends AuthState {
  final UserModel userModel;

  AuthLoginSuccess({required this.userModel});
}

final class AuthLoginFailure extends AuthState {}

final class AuthToken extends AuthState {
  final String accessToken;
  final String refreshToken;

  AuthToken({
    required this.accessToken,
    required this.refreshToken,
  });
}

final class AuthRegisterSuccess extends AuthState {
  final UserModel userModel;

  AuthRegisterSuccess({required this.userModel});
}

final class AuthRegisterFailure extends AuthState {}
