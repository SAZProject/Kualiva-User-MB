part of 'nightlife_nearest_bloc.dart';

@immutable
sealed class NightlifeNearestState {}

final class NightlifeNearestInitial extends NightlifeNearestState {}

final class NightlifeNearestLoading extends NightlifeNearestState {}

final class NightlifeNearestSuccess extends NightlifeNearestState {
  final List<NightlifeNearestModel> nearest;

  NightlifeNearestSuccess({required this.nearest});
}

final class NightlifeNearestFailure extends NightlifeNearestState {}

final class NightlifeNearestRefresh extends NightlifeNearestState {}
