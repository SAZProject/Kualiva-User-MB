part of 'review_place_create_bloc.dart';

@immutable
sealed class ReviewPlaceCreateState {}

final class ReviewPlaceCreateInitial extends ReviewPlaceCreateState {
  final List<ReviewPlaceModel> reviewPlaceCreate;

  ReviewPlaceCreateInitial({this.reviewPlaceCreate = const []});
}

final class ReviewPlaceCreateLoading extends ReviewPlaceCreateState {}

final class ReviewPlaceCreateSuccess extends ReviewPlaceCreateState {}

final class ReviewPlaceCreateFailure extends ReviewPlaceCreateState {}

final class ReviewPlaceCreateRefresh extends ReviewPlaceCreateState {}
