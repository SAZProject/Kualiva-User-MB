part of 'fnb_promo_bloc.dart';

@immutable
sealed class FnbPromoEvent {}

final class FnbPromoFetched extends FnbPromoEvent {
  final bool isRefresh;
  final PlaceCategoryEnum placeCategoryEnum;

  FnbPromoFetched({
    this.isRefresh = false,
    required this.placeCategoryEnum,
  });
}
