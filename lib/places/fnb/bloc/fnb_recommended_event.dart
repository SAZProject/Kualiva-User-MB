part of 'fnb_recommended_bloc.dart';

@immutable
sealed class FnbRecommendedEvent {}

final class FnbRecommendedFetched extends FnbRecommendedEvent {
  final Paging paging;
  final PagingEnum pagingEnum;
  final double latitude;
  final double longitude;

  FnbRecommendedFetched({
    required this.paging,
    required this.pagingEnum,
    required this.latitude,
    required this.longitude,
  });
}
