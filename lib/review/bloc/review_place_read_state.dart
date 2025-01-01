part of 'review_place_read_bloc.dart';

@immutable
sealed class ReviewPlaceReadState {}

final class ReviewPlaceReadInitial extends ReviewPlaceReadState {}

final class ReviewPlaceReadLoading extends ReviewPlaceReadState {}

final class ReviewPlaceReadSuccess extends ReviewPlaceReadState {
  final List<ReviewPlaceModel> reviewPlaceRead;

  ReviewPlaceReadSuccess({required this.reviewPlaceRead});
}

final class ReviewPlaceReadFailure extends ReviewPlaceReadState {}

final class ReviewPlaceReadRefresh extends ReviewPlaceReadState {}
