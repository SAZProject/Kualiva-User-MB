part of 'spa_promo_bloc.dart';

@immutable
sealed class SpaPromoState {}

final class SpaPromoInitial extends SpaPromoState {}

final class SpaPromoLoading extends SpaPromoState {
  final SpaPromoPage? spaPromoPage;

  SpaPromoLoading({required this.spaPromoPage});
}

final class SpaPromoSuccess extends SpaPromoState {
  final SpaPromoPage spaPromoPage;

  SpaPromoSuccess({required this.spaPromoPage});
}

final class SpaPromoFailure extends SpaPromoState {}
