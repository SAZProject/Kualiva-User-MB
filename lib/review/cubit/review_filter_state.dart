part of 'review_filter_cubit.dart';

@immutable
sealed class ReviewFilterState {}

final class ReviewFilterInitial extends ReviewFilterState {}

final class ReviewFilterSuccess extends ReviewFilterState {
  final ReviewFilterModel reviewFilter;

  ReviewFilterSuccess({
    required this.reviewFilter,
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
