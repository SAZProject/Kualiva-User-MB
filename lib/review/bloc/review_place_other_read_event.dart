part of 'review_place_other_read_bloc.dart';

@immutable
sealed class ReviewPlaceOtherReadEvent {}

final class ReviewPlaceOtherReadFetched extends ReviewPlaceOtherReadEvent {
  final Paging paging;
  final bool isNextPaging;
  final bool isRefreshed;
  final String placeId;
  final String? description;
  final bool? withMedia;
  final int? rating;
  final ReviewSelectedUserEnum? selectedUser;
  final ReviewOrderEnum? order;

  ReviewPlaceOtherReadFetched({
    this.paging = const Paging(),
    required this.isNextPaging,
    required this.isRefreshed,
    required this.placeId,
    this.description,
    this.withMedia,
    this.rating,
    this.selectedUser,
    this.order,
  });
}
