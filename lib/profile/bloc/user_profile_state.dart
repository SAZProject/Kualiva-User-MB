part of 'user_profile_bloc.dart';

@immutable
sealed class UserProfileState {}

final class UserProfileInitial extends UserProfileState {}

final class UserProfileLoading extends UserProfileState {
  final LoadingEnum loadingState;

  UserProfileLoading({required this.loadingState});
}

final class UserProfileFetchSuccess extends UserProfileState {
  final UserModel user;

  UserProfileFetchSuccess({required this.user});
}

final class UserProfileFetchFailure extends UserProfileState {}

final class UserProfileUpdateSuccess extends UserProfileState {}

final class UserProfileUpdateFailure extends UserProfileState {}
