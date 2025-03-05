part of 'spa_nearest_bloc.dart';

@immutable
sealed class SpaNearestState {}

final class SpaNearestInitial extends SpaNearestState {}

final class SpaNearestLoading extends SpaNearestState {}

final class SpaNearestSuccess extends SpaNearestState {
  final List<SpaNearestModel> nearest;

  SpaNearestSuccess({required this.nearest});
}

final class SpaNearestFailure extends SpaNearestState {}

final class SpaNearestRefresh extends SpaNearestState {}
