part of 'nightlife_recommended_bloc.dart';

@immutable
sealed class NightlifeRecommendedEvent {}

final class NightlifeRecommendedFetched extends NightlifeRecommendedEvent {
  final Paging paging;
  final PagingEnum pagingEnum;
  final double latitude;
  final double longitude;

  NightlifeRecommendedFetched({
    required this.paging,
    required this.pagingEnum,
    required this.latitude,
    required this.longitude,
  });
}
