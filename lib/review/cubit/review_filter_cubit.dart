import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:kualiva/_data/enum/suggestion_enum.dart';
import 'package:kualiva/_repository/review_repository.dart';
import 'package:kualiva/_repository/suggestion_repository.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/review/enum/review_order_enum.dart';
import 'package:kualiva/review/enum/review_selected_user_enum.dart';
import 'package:kualiva/review/model/review_filter_model.dart';

part 'review_filter_state.dart';

class ReviewFilterCubit extends Cubit<ReviewFilterState> {
  final ReviewRepository _reviewRepository;
  final SuggestionRepository _suggestionRepository;
  ReviewFilterCubit(
    this._reviewRepository,
    this._suggestionRepository,
  ) : super(ReviewFilterInitial());

  Future<ReviewFilterModel?> getOld() async {
    final reviewFilter = await _reviewRepository.getFilter();
    return reviewFilter;
  }

  Future<void> reset() async {
    await _reviewRepository.deleteFilter();
    filter();
  }

  void filter({
    String? description,
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

    if (reviewFilter.description != null) {
      _suggestionRepository.add(
        SuggestionEnum.review,
        reviewFilter.description!,
      );
    }

    final data = ReviewFilterSuccess(reviewFilter: reviewFilter);
    LeLog.bd(this, filter, data.toString());
    debugPrint(data.toString());
    emit(data);
  }
}
