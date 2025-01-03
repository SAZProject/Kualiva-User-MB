part of 'review_place_my_read_bloc.dart';

@immutable
sealed class ReviewPlaceMyReadEvent {}

final class ReviewPlaceMyReadFetched extends ReviewPlaceMyReadEvent {
  final String placeId;

  ReviewPlaceMyReadFetched({
    required this.placeId,
  });
}

final class ReviewPlaceMyReadRefreshed extends ReviewPlaceMyReadEvent {
  final String placeId;

  ReviewPlaceMyReadRefreshed({
    required this.placeId,
  });
}
