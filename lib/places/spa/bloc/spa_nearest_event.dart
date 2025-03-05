part of 'spa_nearest_bloc.dart';

@immutable
sealed class SpaNearestEvent {}

final class SpaNearestFetched extends SpaNearestEvent {
  final double latitude;
  final double longitude;

  SpaNearestFetched({
    required this.latitude,
    required this.longitude,
  });
}

final class SpaNearestRefreshed extends SpaNearestEvent {
  final double latitude;
  final double longitude;

  SpaNearestRefreshed({
    required this.latitude,
    required this.longitude,
  });
}
