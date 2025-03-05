part of 'fnb_promo_bloc.dart';

@immutable
sealed class FnbPromoState {}

final class FnbPromoInitial extends FnbPromoState {}

final class FnbPromoLoading extends FnbPromoState {}

final class FnbPromoSuccess extends FnbPromoState {
  final List<FnbPromoModel> promo;

  FnbPromoSuccess({required this.promo});
}

final class FnbPromoFailure extends FnbPromoState {}

final class FnbPromoRefresh extends FnbPromoState {}
