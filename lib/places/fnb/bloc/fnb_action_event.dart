part of 'fnb_action_bloc.dart';

@immutable
sealed class FnbActionEvent {}

final class FnbActionFetched extends FnbActionEvent {
  final Paging paging;
  final PagingEnum pagingEnum;
  final FnbActionEnum fnbActionEnum;
  final double latitude;
  final double longitude;

  FnbActionFetched({
    required this.paging,
    required this.pagingEnum,
    required this.fnbActionEnum,
    required this.latitude,
    required this.longitude,
  });
}
