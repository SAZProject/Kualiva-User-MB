part of 'review_place_create_bloc.dart';

@immutable
sealed class ReviewPlaceCreateState {}

final class ReviewPlaceCreateInitial extends ReviewPlaceCreateState {}

final class ReviewPlaceCreateLoading extends ReviewPlaceCreateState {}

final class ReviewPlaceCreateSuccess extends ReviewPlaceCreateState {
  final String placeId;

  ReviewPlaceCreateSuccess({required this.placeId});
}

final class ReviewPlaceCreateFailure extends ReviewPlaceCreateState {}
