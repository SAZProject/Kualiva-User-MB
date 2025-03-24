part of 'fnb_promo_bloc.dart';

@immutable
sealed class FnbPromoState {}

final class FnbPromoInitial extends FnbPromoState {}

final class FnbPromoLoading extends FnbPromoState {
  final FnbPromoPage? fnbPromoPage;

  FnbPromoLoading({required this.fnbPromoPage});
}

final class FnbPromoSuccess extends FnbPromoState {
  final FnbPromoPage fnbPromoPage;

  FnbPromoSuccess({required this.fnbPromoPage});
}

final class FnbPromoFailure extends FnbPromoState {}
