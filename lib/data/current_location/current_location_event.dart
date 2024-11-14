part of 'current_location_bloc.dart';

@immutable
sealed class CurrentLocationEvent {}

final class CurrentLocationStarted extends CurrentLocationEvent {}

final class CurrentLocationNoPermission extends CurrentLocationEvent {
  final String message;
  CurrentLocationNoPermission({required this.message});
}
