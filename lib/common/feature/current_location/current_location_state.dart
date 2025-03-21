part of 'current_location_bloc.dart';

@immutable
sealed class CurrentLocationState {}

final class CurrentLocationInitial extends CurrentLocationState {}

final class CurrentLocationLoading extends CurrentLocationState {}

final class CurrentLocationSuccess extends CurrentLocationState {
  final CurrentLocationModel currentLocationModel;
  final bool isDistanceTooFarOrFirstTime;
  final double distance;

  CurrentLocationSuccess({
    required this.currentLocationModel,
    required this.isDistanceTooFarOrFirstTime,
    required this.distance,
  });
}

final class CurrentLocationFailure extends CurrentLocationState {
  final String message;
  CurrentLocationFailure({
    required this.message,
  });
}
