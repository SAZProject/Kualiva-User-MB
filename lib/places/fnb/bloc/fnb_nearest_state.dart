part of 'fnb_nearest_bloc.dart';

@immutable
sealed class FnbNearestState {}

final class FnbNearestInitial extends FnbNearestState {}

final class FnbNearestLoading extends FnbNearestState {
  final FnbNearestPage? fnbNearestPage;

  FnbNearestLoading({required this.fnbNearestPage});
}

final class FnbNearestSuccess extends FnbNearestState {
  final FnbNearestPage fnbNearestPage;

  FnbNearestSuccess({required this.fnbNearestPage});
}

final class FnbNearestFailure extends FnbNearestState {}

final class FnbNearestRefresh extends FnbNearestState {}
