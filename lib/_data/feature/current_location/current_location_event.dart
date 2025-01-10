part of 'current_location_bloc.dart';

@immutable
sealed class CurrentLocationEvent {}

final class CurrentLocationFetched extends CurrentLocationEvent {}

final class CurrentLocationNoPermission extends CurrentLocationEvent {
  CurrentLocationNoPermission();
}
