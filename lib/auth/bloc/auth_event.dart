part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthLoggedIn extends AuthEvent {
  final String email;
  final String password;

  AuthLoggedIn({
    required this.email,
    required this.password,
  });
}

final class AuthRegistered extends AuthEvent {
  final String username;
  final String phoneNumber;
  final String password;

  AuthRegistered({
    required this.username,
    required this.phoneNumber,
    required this.password,
  });
}
