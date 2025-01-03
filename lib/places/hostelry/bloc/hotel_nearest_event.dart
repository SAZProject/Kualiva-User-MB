part of 'hotel_nearest_bloc.dart';

@immutable
sealed class HotelNearestEvent {}

final class HotelNearestStarted extends HotelNearestEvent {}

final class HotelNearestFetched extends HotelNearestEvent {
  final double latitude;
  final double longitude;

  HotelNearestFetched({
    required this.latitude,
    required this.longitude,
  });
}

final class HotelNearestRefreshed extends HotelNearestEvent {
  final double latitude;
  final double longitude;

  HotelNearestRefreshed({
    required this.latitude,
    required this.longitude,
  });
}
