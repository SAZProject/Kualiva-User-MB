part of 'fnb_nearest_bloc.dart';

@immutable
sealed class FnbNearestEvent {}

final class FnbNearestFetched extends FnbNearestEvent {
  final Paging paging;
  final PagingEnum pagingEnum;
  final double latitude;
  final double longitude;

  FnbNearestFetched({
    required this.paging,
    required this.pagingEnum,
    required this.latitude,
    required this.longitude,
  });
}

final class FnbNearestRefreshed extends FnbNearestEvent {
  final double latitude;
  final double longitude;

  FnbNearestRefreshed({
    required this.latitude,
    required this.longitude,
  });
}
