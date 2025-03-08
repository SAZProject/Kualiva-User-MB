import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:kualiva/_repository/review_repository.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/review/enum/review_order_enum.dart';
import 'package:kualiva/review/enum/review_selected_user_enum.dart';
import 'package:kualiva/review/model/review_filter_model.dart';

part 'review_filter_state.dart';

class ReviewFilterCubit extends Cubit<ReviewFilterState> {
  final ReviewRepository _reviewRepository;
  ReviewFilterCubit(this._reviewRepository) : super(ReviewFilterInitial());

  Future<ReviewFilterModel?> getOld() async {
    final reviewFilter = await _reviewRepository.getFilter();
    return reviewFilter;
  }

  Future<void> reset() async {
    await _reviewRepository.deleteFilter();
    filter();
  }

  void filter({
    ReviewSelectedUserEnum? selectedUser,
    bool? withMedia,
    int? rating,
    ReviewOrderEnum? order,
  }) async {
    final reviewFilterOld = await getOld();

    final reviewFilter = await _reviewRepository.addFilter(
      selectedUser: selectedUser ?? reviewFilterOld?.selectedUser,
      withMedia: withMedia ?? reviewFilterOld?.withMedia,
      rating: rating ?? reviewFilterOld?.rating,
      order: order ?? reviewFilterOld?.order,
    );

    final data = ReviewFilterSuccess(reviewFilter: reviewFilter);
    LeLog.bd(this, filter, data.toString());
    emit(data);
  }
}
