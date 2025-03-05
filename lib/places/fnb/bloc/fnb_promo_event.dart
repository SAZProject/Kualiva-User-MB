part of 'fnb_promo_bloc.dart';

@immutable
sealed class FnbPromoEvent {}

final class FnbPromoFetched extends FnbPromoEvent {}

final class FnbPromoRefreshed extends FnbPromoEvent {}
