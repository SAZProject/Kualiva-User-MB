import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:kualiva/_data/enum/suggestion_enum.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/_repository/suggestion_repository.dart';

part 'home_search_bar_state.dart';

class HomeSearchBarCubit extends Cubit<HomeSearchBarState> {
  final SuggestionRepository _suggestionRepository;

  HomeSearchBarCubit(this._suggestionRepository)
      : super(HomeSearchBarInitial());

  void loadSuggestion() async {
    final homeSuggestion = await _suggestionRepository.get(SuggestionEnum.home);
    LeLog.bd(this, loadSuggestion, homeSuggestion.toString());
    emit(HomeSearchBarSuccess(homeSuggestion: homeSuggestion));
  }
}
