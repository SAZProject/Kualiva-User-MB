part of 'review_place_other_read_bloc.dart';

@immutable
sealed class ReviewPlaceOtherReadState {}

final class ReviewPlaceOtherReadInitial extends ReviewPlaceOtherReadState {}

final class ReviewPlaceOtherReadLoading extends ReviewPlaceOtherReadState {
  final ReviewPlacePage? reviewPlacePage;

  ReviewPlaceOtherReadLoading({required this.reviewPlacePage});
}

final class ReviewPlaceOtherReadSuccess extends ReviewPlaceOtherReadState {
  final ReviewPlacePage reviewPlacePage;

  ReviewPlaceOtherReadSuccess({required this.reviewPlacePage});
}

final class ReviewPlaceOtherReadFailure extends ReviewPlaceOtherReadState {}

final class ReviewPlaceOtherReadRefresh extends ReviewPlaceOtherReadState {}
