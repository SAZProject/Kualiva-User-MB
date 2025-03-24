part of 'nightlife_promo_bloc.dart';

@immutable
sealed class NightlifePromoState {}

final class NightlifePromoInitial extends NightlifePromoState {}

final class NightlifePromoLoading extends NightlifePromoState {
  final NightlifePromoPage? nightlifePromoPage;

  NightlifePromoLoading({required this.nightlifePromoPage});
}

final class NightlifePromoSuccess extends NightlifePromoState {
  final NightlifePromoPage nightlifePromoPage;

  NightlifePromoSuccess({required this.nightlifePromoPage});
}

final class NightlifePromoFailure extends NightlifePromoState {}
