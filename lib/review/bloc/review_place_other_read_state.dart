part of 'review_place_other_read_bloc.dart';

@immutable
sealed class ReviewPlaceOtherReadState {}

final class ReviewPlaceOtherReadInitial extends ReviewPlaceOtherReadState {}

final class ReviewPlaceOtherReadLoading extends ReviewPlaceOtherReadState {}

final class ReviewPlaceOtherReadSuccess extends ReviewPlaceOtherReadState {
  final List<ReviewPlaceModel> reviewsPlace;

  ReviewPlaceOtherReadSuccess({required this.reviewsPlace});
}

final class ReviewPlaceOtherReadFailure extends ReviewPlaceOtherReadState {}

final class ReviewPlaceOtherReadRefresh extends ReviewPlaceOtherReadState {}
