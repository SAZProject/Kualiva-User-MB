import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/_data/enum/suggestion_enum.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/_repository/suggestion_repository.dart';

part 'review_search_bar_state.dart';

class ReviewSearchBarCubit extends Cubit<ReviewSearchBarState> {
  final SuggestionRepository _suggestionRepository;

  ReviewSearchBarCubit(this._suggestionRepository)
      : super(ReviewSearchBarInitial());

  void loadSuggestion() async {
    final reviewSuggestion =
        await _suggestionRepository.get(SuggestionEnum.review);
    LeLog.bd(this, loadSuggestion, reviewSuggestion.toString());
    emit(ReviewSearchBarSuccess(reviewSuggestion: reviewSuggestion));
  }
}
