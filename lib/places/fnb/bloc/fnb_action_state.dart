part of 'fnb_action_bloc.dart';

@immutable
sealed class FnbActionState {}

final class FnbActionInitial extends FnbActionState {}

// final class FnbActionLoading extends FnbActionState {
//   final FnbActionEnum fnbActionEnum;

//   FnbActionLoading({required this.fnbActionEnum});
// }

// final class FnbActionSuccess extends FnbActionState {
//   final FnbActionEnum fnbActionEnum;

//   FnbActionSuccess({required this.fnbActionEnum});
// }

final class FnbActionFailure extends FnbActionState {
  final FnbActionEnum fnbActionEnum;

  FnbActionFailure({required this.fnbActionEnum});
}

/// Nearest
final class FnbActionLoadingNearest extends FnbActionState {
  final FnbNearestPage? fnbNearestPage;

  FnbActionLoadingNearest({required this.fnbNearestPage});
}

final class FnbActionSuccessNearest extends FnbActionState {
  final FnbNearestPage fnbNearestPage;

  FnbActionSuccessNearest({required this.fnbNearestPage});
}

/// Promo
final class FnbActionLoadingPromo extends FnbActionState {
  final FnbPromoPage? fnbPromoPage;

  FnbActionLoadingPromo({required this.fnbPromoPage});
}

final class FnbActionSuccessPromo extends FnbActionState {
  final FnbPromoPage fnbPromoPage;

  FnbActionSuccessPromo({required this.fnbPromoPage});
}

/// Recommended
final class FnbActionLoadingRecommended extends FnbActionState {
  final FnbRecommendedPage? fnbRecommendedPage;

  FnbActionLoadingRecommended({required this.fnbRecommendedPage});
}

final class FnbActionSuccessRecommended extends FnbActionState {
  final FnbRecommendedPage fnbRecommendedPage;

  FnbActionSuccessRecommended({required this.fnbRecommendedPage});
}
