part of 'review_like_bloc.dart';

@immutable
sealed class ReviewLikeEvent {}

final class ReviewLikeAdded extends ReviewLikeEvent {
  final int reviewId;

  ReviewLikeAdded({
    required this.reviewId,
  });
}

final class ReviewLikeRemoved extends ReviewLikeEvent {
  final int reviewId;

  ReviewLikeRemoved({
    required this.reviewId,
  });
}
