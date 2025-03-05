part of 'fnb_promo_bloc.dart';

@immutable
sealed class FnbPromoEvent {}

final class FnbPromoFetched extends FnbPromoEvent {
  final bool isRefreshed;
  final PlaceCategoryEnum placeCategoryEnum;

  FnbPromoFetched({
    this.isRefreshed = false,
    required this.placeCategoryEnum,
  });
}
