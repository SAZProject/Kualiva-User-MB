part of 'review_place_other_read_bloc.dart';

@immutable
sealed class ReviewPlaceOtherReadEvent {}

final class ReviewPlaceOtherReadFetched extends ReviewPlaceOtherReadEvent {
  final bool isRefreshed;
  final String placeId;
  final bool? withMedia;
  final int? rating;
  final ReviewSelectedUserEnum? selectedUser;
  final ReviewOrderEnum? order;

  ReviewPlaceOtherReadFetched({
    this.isRefreshed = false,
    required this.placeId,
    this.withMedia,
    this.rating,
    this.selectedUser,
    this.order,
  });
}
