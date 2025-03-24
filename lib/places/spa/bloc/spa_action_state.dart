part of 'spa_action_bloc.dart';

@immutable
sealed class SpaActionState {}

final class SpaActionInitial extends SpaActionState {}

final class SpaActionFailure extends SpaActionState {
  final SpaActionEnum spaActionEnum;

  SpaActionFailure({required this.spaActionEnum});
}

/// Nearest
final class SpaActionLoadingNearest extends SpaActionState {
  final SpaNearestPage? spaNearestPage;

  SpaActionLoadingNearest({required this.spaNearestPage});
}

final class SpaActionSuccessNearest extends SpaActionState {
  final SpaNearestPage spaNearestPage;

  SpaActionSuccessNearest({required this.spaNearestPage});
}

/// Promo
final class SpaActionLoadingPromo extends SpaActionState {
  final SpaPromoPage? spaPromoPage;

  SpaActionLoadingPromo({required this.spaPromoPage});
}

final class SpaActionSuccessPromo extends SpaActionState {
  final SpaPromoPage spaPromoPage;

  SpaActionSuccessPromo({required this.spaPromoPage});
}

/// Recommended
final class SpaActionLoadingRecommended extends SpaActionState {
  final SpaRecommendedPage? spaRecommendedPage;

  SpaActionLoadingRecommended({required this.spaRecommendedPage});
}

final class SpaActionSuccessRecommended extends SpaActionState {
  final SpaRecommendedPage spaRecommendedPage;

  SpaActionSuccessRecommended({required this.spaRecommendedPage});
}
