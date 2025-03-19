part of 'review_filter_cubit.dart';

@immutable
sealed class ReviewFilterState {}

final class ReviewFilterInitial extends ReviewFilterState {}

final class ReviewFilterSuccess extends ReviewFilterState {
  final Paging paging;
  final ReviewFilterModel reviewFilter;
  final bool isRefreshed;
  final bool isNextPaging;

  ReviewFilterSuccess({
    required this.paging,
    required this.reviewFilter,
    required this.isRefreshed,
    required this.isNextPaging,
  });
  // final ReviewSelectedUserEnum? selectedUser;
  // final bool? withMedia;
  // final int? rating;
  // final ReviewOrderEnum? order;

  // ReviewFilterSuccess({
  //   required this.selectedUser,
  //   required this.withMedia,
  //   required this.rating,
  //   required this.order,
  // });
}
