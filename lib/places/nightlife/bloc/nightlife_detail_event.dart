part of 'nightlife_detail_bloc.dart';

@immutable
sealed class NightlifeDetailEvent {}

final class NightlifeDetailFetched extends NightlifeDetailEvent {
  final String placeId;
  NightlifeDetailFetched({required this.placeId});
}
