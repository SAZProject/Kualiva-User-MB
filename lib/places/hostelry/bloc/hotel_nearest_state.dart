part of 'hotel_nearest_bloc.dart';

@immutable
sealed class HotelNearestState {}

final class HotelNearestInitial extends HotelNearestState {
  final List<FnbNearestModel> nearest;

  HotelNearestInitial({this.nearest = const []});
}

final class HotelNearestLoading extends HotelNearestState {}

final class HotelNearestSuccess extends HotelNearestState {
  final List<FnbNearestModel> nearest;

  HotelNearestSuccess({required this.nearest});
}

final class HotelNearestFailure extends HotelNearestState {}

final class HotelNearestRefresh extends HotelNearestState {}
