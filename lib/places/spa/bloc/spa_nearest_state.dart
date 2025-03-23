part of 'spa_nearest_bloc.dart';

@immutable
sealed class SpaNearestState {}

final class SpaNearestInitial extends SpaNearestState {}

final class SpaNearestLoading extends SpaNearestState {
  final SpaNearestPage? spaNearestPage;

  SpaNearestLoading({required this.spaNearestPage});
}

final class SpaNearestSuccess extends SpaNearestState {
  final SpaNearestPage spaNearestPage;

  SpaNearestSuccess({required this.spaNearestPage});
}

final class SpaNearestFailure extends SpaNearestState {}

final class SpaNearestRefresh extends SpaNearestState {}
