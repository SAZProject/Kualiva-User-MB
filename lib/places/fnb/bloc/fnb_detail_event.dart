part of 'fnb_detail_bloc.dart';

@immutable
sealed class FnbDetailEvent {}

final class FnbDetailFetched extends FnbDetailEvent {
  final String placeId;
  FnbDetailFetched({required this.placeId});
}
