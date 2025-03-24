part of 'nightlife_action_bloc.dart';

@immutable
sealed class NightlifeActionState {}

final class NightlifeActionInitial extends NightlifeActionState {}

final class NightlifeActionFailure extends NightlifeActionState {
  final NightlifeActionEnum nightlifeActionEnum;

  NightlifeActionFailure({required this.nightlifeActionEnum});
}

/// Nearest
final class NightlifeActionLoadingNearest extends NightlifeActionState {
  final NightlifeNearestPage? nightlifeNearestPage;

  NightlifeActionLoadingNearest({required this.nightlifeNearestPage});
}

final class NightlifeActionSuccessNearest extends NightlifeActionState {
  final NightlifeNearestPage nightlifeNearestPage;

  NightlifeActionSuccessNearest({required this.nightlifeNearestPage});
}

/// Promo
final class NightlifeActionLoadingPromo extends NightlifeActionState {
  final NightlifePromoPage? nightlifePromoPage;

  NightlifeActionLoadingPromo({required this.nightlifePromoPage});
}

final class NightlifeActionSuccessPromo extends NightlifeActionState {
  final NightlifePromoPage nightlifePromoPage;

  NightlifeActionSuccessPromo({required this.nightlifePromoPage});
}

/// Recommended
final class NightlifeActionLoadingRecommended extends NightlifeActionState {
  final NightlifeRecommendedPage? nightlifeRecommendedPage;

  NightlifeActionLoadingRecommended({required this.nightlifeRecommendedPage});
}

final class NightlifeActionSuccessRecommended extends NightlifeActionState {
  final NightlifeRecommendedPage nightlifeRecommendedPage;

  NightlifeActionSuccessRecommended({required this.nightlifeRecommendedPage});
}
