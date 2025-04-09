part of 'spa_action_bloc.dart';

@immutable
sealed class SpaActionEvent {}

final class SpaActionFetched extends SpaActionEvent {
  final Paging paging;
  final PagingEnum pagingEnum;
  final SpaActionEnum spaActionEnum;
  final double latitude;
  final double longitude;
  final String? name;

  SpaActionFetched({
    required this.paging,
    required this.pagingEnum,
    required this.spaActionEnum,
    required this.latitude,
    required this.longitude,
    this.name,
  });
}
