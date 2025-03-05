part of 'nightlife_promo_bloc.dart';

@immutable
sealed class NightlifePromoEvent {}

final class NightlifePromoFetched extends NightlifePromoEvent {}

final class NightlifePromoRefreshed extends NightlifePromoEvent {}
