part of 'nightlife_recommended_bloc.dart';

@immutable
sealed class NightlifeRecommendedState {}

final class NightlifeRecommendedInitial extends NightlifeRecommendedState {}

final class NightlifeRecommendedLoading extends NightlifeRecommendedState {
  final NightlifeRecommendedPage? nightlifeRecommendedPage;

  NightlifeRecommendedLoading({required this.nightlifeRecommendedPage});
}

final class NightlifeRecommendedSuccess extends NightlifeRecommendedState {
  final NightlifeRecommendedPage nightlifeRecommendedPage;

  NightlifeRecommendedSuccess({required this.nightlifeRecommendedPage});
}

final class NightlifeRecommendedFailure extends NightlifeRecommendedState {}
