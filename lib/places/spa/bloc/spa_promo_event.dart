part of 'spa_promo_bloc.dart';

@immutable
sealed class SpaPromoEvent {}

final class SpaPromoFetched extends SpaPromoEvent {
  final bool isRefresh;
  final PlaceCategoryEnum placeCategoryEnum;

  SpaPromoFetched({
    this.isRefresh = false,
    required this.placeCategoryEnum,
  });
}
