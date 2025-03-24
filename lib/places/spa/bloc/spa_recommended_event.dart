part of 'spa_recommended_bloc.dart';

@immutable
sealed class SpaRecommendedEvent {}

final class SpaRecommendedFetched extends SpaRecommendedEvent {
  final Paging paging;
  final PagingEnum pagingEnum;
  final double latitude;
  final double longitude;

  SpaRecommendedFetched({
    required this.paging,
    required this.pagingEnum,
    required this.latitude,
    required this.longitude,
  });
}
