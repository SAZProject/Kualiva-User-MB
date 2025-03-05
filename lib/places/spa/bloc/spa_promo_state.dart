part of 'spa_promo_bloc.dart';

@immutable
sealed class SpaPromoState {}

final class SpaPromoInitial extends SpaPromoState {}

final class SpaPromoLoading extends SpaPromoState {}

final class SpaPromoSuccess extends SpaPromoState {
  final List<SpaPromoModel> spaPromoModels;

  SpaPromoSuccess({
    required this.spaPromoModels,
  });
}

final class SpaPromoFailure extends SpaPromoState {
  final Failure failure;

  SpaPromoFailure({required this.failure});
}
