import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:kualiva/_data/enum/recent_suggestion_enum.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/_repository/common/recent_suggestion_repository.dart';

part 'search_bar_state.dart';

class SearchBarCubit extends Cubit<SearchBarState> {
  final RecentSuggestionRepository _suggestionRepository;

  SearchBarCubit(this._suggestionRepository) : super(SearchBarInitial());

  void addSuggestion(
      String recentSearch, RecentSuggestionEnum recentSuggestEnum) {}

  void loadSuggestion({required RecentSuggestionEnum recentSuggestEnum}) async {
    final recentSuggestion = await _suggestionRepository.get(recentSuggestEnum);
    LeLog.bd(this, loadSuggestion, recentSuggestion.toString());
    emit(SearchBarSuccess(recentSuggestion: recentSuggestion));
  }
}
