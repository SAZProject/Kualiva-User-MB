part of 'review_like_bloc.dart';

@immutable
sealed class ReviewLikeState {}

final class ReviewLikeInitial extends ReviewLikeState {}

final class ReviewLikeLoading extends ReviewLikeState {}

final class ReviewLikeSuccess extends ReviewLikeState {}

final class ReviewLikeFailure extends ReviewLikeState {}
