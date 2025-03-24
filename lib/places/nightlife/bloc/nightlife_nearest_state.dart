part of 'nightlife_nearest_bloc.dart';

@immutable
sealed class NightlifeNearestState {}

final class NightlifeNearestInitial extends NightlifeNearestState {}

final class NightlifeNearestLoading extends NightlifeNearestState {
  final NightlifeNearestPage? nightlifeNearestPage;

  NightlifeNearestLoading({required this.nightlifeNearestPage});
}

final class NightlifeNearestSuccess extends NightlifeNearestState {
  final NightlifeNearestPage nightlifeNearestPage;

  NightlifeNearestSuccess({required this.nightlifeNearestPage});
}

final class NightlifeNearestFailure extends NightlifeNearestState {}
