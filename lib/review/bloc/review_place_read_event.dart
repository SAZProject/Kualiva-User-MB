part of 'review_place_read_bloc.dart';

@immutable
sealed class ReviewPlaceReadEvent {}

final class ReviewPlaceReadStarted extends ReviewPlaceReadEvent {}

final class ReviewPlaceReadFetched extends ReviewPlaceReadEvent {
  final String placeId;

  ReviewPlaceReadFetched({
    required this.placeId,
  });
}

final class ReviewPlaceReadRefreshed extends ReviewPlaceReadEvent {
  final String placeId;

  ReviewPlaceReadRefreshed({
    required this.placeId,
  });
}
