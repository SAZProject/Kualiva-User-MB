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
