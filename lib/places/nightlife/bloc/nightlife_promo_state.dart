part of 'nightlife_promo_bloc.dart';

@immutable
sealed class NightlifePromoState {}

final class NightlifePromoInitial extends NightlifePromoState {}

final class NightlifePromoLoading extends NightlifePromoState {}

final class NightlifePromoSuccess extends NightlifePromoState {
  final List<NightlifePromoModel> nightlifePromoModels;

  NightlifePromoSuccess({
    required this.nightlifePromoModels,
  });
}

final class NightlifePromoFailure extends NightlifePromoState {
  final Failure failure;

  NightlifePromoFailure({required this.failure});
}
