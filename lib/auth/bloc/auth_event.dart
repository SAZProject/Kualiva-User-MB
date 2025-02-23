part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthStarted extends AuthEvent {}

final class AuthLoggedIn extends AuthEvent {
  final String? username;
  final String? phoneNumber;
  final String password;

  AuthLoggedIn({
    this.username,
    this.phoneNumber,
    required this.password,
  });
}

final class AuthRegistered extends AuthEvent {
  final String username;
  final String phoneNumber;
  final String email;
  final String password;
  final String confirmPassword;

  AuthRegistered({
    required this.username,
    required this.phoneNumber,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
}
