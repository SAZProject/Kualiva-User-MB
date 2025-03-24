part of 'fnb_recommended_bloc.dart';

@immutable
sealed class FnbRecommendedState {}

final class FnbRecommendedInitial extends FnbRecommendedState {}

final class FnbRecommendedLoading extends FnbRecommendedState {
  final FnbRecommendedPage? fnbRecommendedPage;

  FnbRecommendedLoading({required this.fnbRecommendedPage});
}

final class FnbRecommendedSuccess extends FnbRecommendedState {
  final FnbRecommendedPage fnbRecommendedPage;

  FnbRecommendedSuccess({required this.fnbRecommendedPage});
}

final class FnbRecommendedFailure extends FnbRecommendedState {}
