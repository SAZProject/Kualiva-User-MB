part of 'review_place_other_read_bloc.dart';

@immutable
sealed class ReviewPlaceOtherReadEvent {}

final class ReviewPlaceOtherReadFetched extends ReviewPlaceOtherReadEvent {
  final Paging paging;
  final PagingEnum pagingEnum;
  final String placeId;
  final String? description;
  final bool? withMedia;
  final int? rating;
  final ReviewSelectedUserEnum? selectedUser;
  final ReviewOrderEnum? order;

  ReviewPlaceOtherReadFetched({
    required this.paging,
    required this.pagingEnum,
    required this.placeId,
    this.description,
    this.withMedia,
    this.rating,
    this.selectedUser,
    this.order,
  });
}
