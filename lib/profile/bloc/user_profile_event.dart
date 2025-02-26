part of 'user_profile_bloc.dart';

@immutable
sealed class UserProfileEvent {}

final class UserProfileFetched extends UserProfileEvent {}

final class UserProfileUpdated extends UserProfileEvent {
  final String fullName;
  final DateTime birthDate;
  final String gender;
  final String photoFile;

  UserProfileUpdated({
    required this.fullName,
    required this.birthDate,
    required this.gender,
    required this.photoFile,
  });
}
