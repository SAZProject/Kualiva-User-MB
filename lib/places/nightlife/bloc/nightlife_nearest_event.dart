part of 'nightlife_nearest_bloc.dart';

@immutable
sealed class NightlifeNearestEvent {}

final class NightlifeNearestFetched extends NightlifeNearestEvent {
  final double latitude;
  final double longitude;

  NightlifeNearestFetched({
    required this.latitude,
    required this.longitude,
  });
}

final class NightlifeNearestRefreshed extends NightlifeNearestEvent {
  final double latitude;
  final double longitude;

  NightlifeNearestRefreshed({
    required this.latitude,
    required this.longitude,
  });
}
