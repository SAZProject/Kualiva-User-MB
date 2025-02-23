part of 'onboarding_bloc.dart';

@immutable
sealed class OnboardingEvent {}

final class OnboardingUserVerified extends OnboardingEvent {
  final String fullName;
  final DateTime birthDate;

  OnboardingUserVerified({
    required this.fullName,
    required this.birthDate,
  });
}
