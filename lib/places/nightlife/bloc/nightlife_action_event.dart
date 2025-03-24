part of 'nightlife_action_bloc.dart';

@immutable
sealed class NightlifeActionEvent {}

final class NightlifeActionFetched extends NightlifeActionEvent {
  final Paging paging;
  final PagingEnum pagingEnum;
  final NightlifeActionEnum nightlifeActionEnum;
  final double latitude;
  final double longitude;

  NightlifeActionFetched({
    required this.paging,
    required this.pagingEnum,
    required this.nightlifeActionEnum,
    required this.latitude,
    required this.longitude,
  });
}
