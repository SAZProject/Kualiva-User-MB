part of 'spa_nearest_bloc.dart';

@immutable
sealed class SpaNearestEvent {}

final class SpaNearestFetched extends SpaNearestEvent {
  final Paging paging;
  final PagingEnum pagingEnum;
  final double latitude;
  final double longitude;

  SpaNearestFetched({
    required this.paging,
    required this.pagingEnum,
    required this.latitude,
    required this.longitude,
  });
}
