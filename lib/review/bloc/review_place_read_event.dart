part of 'review_place_read_bloc.dart';

@immutable
sealed class ReviewPlaceOtherReadEvent {}

final class ReviewPlaceOtherReadFetched extends ReviewPlaceOtherReadEvent {
  final String placeId;

  ReviewPlaceOtherReadFetched({
    required this.placeId,
  });
}

final class ReviewPlaceOtherReadRefreshed extends ReviewPlaceOtherReadEvent {
  final String placeId;

  ReviewPlaceOtherReadRefreshed({
    required this.placeId,
  });
}
