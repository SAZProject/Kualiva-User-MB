part of 'current_location_bloc.dart';

@immutable
sealed class CurrentLocationState {}

final class CurrentLocationInitial extends CurrentLocationState {}

final class CurrentLocationLoading extends CurrentLocationState {}

final class CurrentLocationSuccess extends CurrentLocationState {
  final CurrentLocationModel currentLocationModel;

  CurrentLocationSuccess({
    required this.currentLocationModel,
  });
}

final class CurrentLocationFailure extends CurrentLocationState {
  final String message;
  CurrentLocationFailure({
    required this.message,
  });
}
