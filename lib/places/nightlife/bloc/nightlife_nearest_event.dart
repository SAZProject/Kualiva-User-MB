part of 'nightlife_nearest_bloc.dart';

@immutable
sealed class NightlifeNearestEvent {}

final class NightlifeNearestFetched extends NightlifeNearestEvent {
  final Paging paging;
  final PagingEnum pagingEnum;
  final double latitude;
  final double longitude;

  NightlifeNearestFetched({
    required this.paging,
    required this.pagingEnum,
    required this.latitude,
    required this.longitude,
  });
}
