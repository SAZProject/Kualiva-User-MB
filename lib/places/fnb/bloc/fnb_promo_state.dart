part of 'fnb_promo_bloc.dart';

@immutable
sealed class FnbPromoState {}

final class FnbPromoInitial extends FnbPromoState {}

final class FnbPromoLoading extends FnbPromoState {}

final class FnbPromoSuccess extends FnbPromoState {
  final List<FnbPromoModel> fnbPromoModels;

  FnbPromoSuccess({
    required this.fnbPromoModels,
  });
}

final class FnbPromoFailure extends FnbPromoState {
  final Failure failure;

  FnbPromoFailure({required this.failure});
}
