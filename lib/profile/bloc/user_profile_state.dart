part of 'user_profile_bloc.dart';

@immutable
sealed class UserProfileState {}

final class UserProfileInitial extends UserProfileState {}

final class UserProfileLoading extends UserProfileState {}

final class UserProfileSuccess extends UserProfileState {
  final UserModel user;

  UserProfileSuccess({required this.user});
}

final class UserProfileFailure extends UserProfileState {}
