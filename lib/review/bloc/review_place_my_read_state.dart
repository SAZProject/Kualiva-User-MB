part of 'review_place_my_read_bloc.dart';

@immutable
sealed class ReviewPlaceMyReadState {}

final class ReviewPlaceMyReadInitial extends ReviewPlaceMyReadState {}

final class ReviewPlaceMyReadLoading extends ReviewPlaceMyReadState {}

final class ReviewPlaceMyReadSuccess extends ReviewPlaceMyReadState {
  final List<ReviewPlaceModel> reviewsPlace;

  ReviewPlaceMyReadSuccess({required this.reviewsPlace});
}

final class ReviewPlaceMyReadFailure extends ReviewPlaceMyReadState {}

final class ReviewPlaceMyReadRefresh extends ReviewPlaceMyReadState {}
