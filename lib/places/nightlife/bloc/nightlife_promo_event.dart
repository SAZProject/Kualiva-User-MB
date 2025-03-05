part of 'nightlife_promo_bloc.dart';

@immutable
sealed class NightlifePromoEvent {}

final class NightlifePromoFetched extends NightlifePromoEvent {
  final bool isRefresh;
  final PlaceCategoryEnum placeCategoryEnum;

  NightlifePromoFetched({
    this.isRefresh = false,
    required this.placeCategoryEnum,
  });
}
