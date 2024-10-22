part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthLoginSuccess extends AuthState {}

final class AuthLoginFailure extends AuthState {}

final class AuthToken extends AuthState {
  final String accessToken;
  final String refreshToken;

  AuthToken({
    required this.accessToken,
    required this.refreshToken,
  });
}

final class AuthRefreshToken extends AuthState {}
