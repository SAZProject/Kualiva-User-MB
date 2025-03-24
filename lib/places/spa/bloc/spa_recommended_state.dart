part of 'spa_recommended_bloc.dart';

@immutable
sealed class SpaRecommendedState {}

final class SpaRecommendedInitial extends SpaRecommendedState {}

final class SpaRecommendedLoading extends SpaRecommendedState {
  final SpaRecommendedPage? spaRecommendedPage;

  SpaRecommendedLoading({required this.spaRecommendedPage});
}

final class SpaRecommendedSuccess extends SpaRecommendedState {
  final SpaRecommendedPage spaRecommendedPage;

  SpaRecommendedSuccess({required this.spaRecommendedPage});
}

final class SpaRecommendedFailure extends SpaRecommendedState {}
