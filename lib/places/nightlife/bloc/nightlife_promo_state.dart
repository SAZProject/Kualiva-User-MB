part of 'nightlife_promo_bloc.dart';

@immutable
sealed class NightlifePromoState {}

final class NightlifePromoInitial extends NightlifePromoState {}

final class NightlifePromoLoading extends NightlifePromoState {}

final class NightlifePromoSuccess extends NightlifePromoState {
  final List<NightlifePromoModel> promo;

  NightlifePromoSuccess({required this.promo});
}

final class NightlifePromoFailure extends NightlifePromoState {}

final class NightlifePromoRefresh extends NightlifePromoState {}
