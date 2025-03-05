part of 'spa_detail_bloc.dart';

@immutable
sealed class SpaDetailEvent {}

final class SpaDetailFetched extends SpaDetailEvent {
  final String placeId;
  SpaDetailFetched({required this.placeId});
}
