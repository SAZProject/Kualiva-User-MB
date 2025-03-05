part of 'fnb_promo_bloc.dart';

@immutable
sealed class FnbPromoEvent {}

final class FnbPromoFetched extends FnbPromoEvent {
  final PlaceCategoryEnum placeCategoryEnum;
  final bool isRefresh;

  FnbPromoFetched({
    this.isRefresh = false,
    required this.placeCategoryEnum,
  });
}
