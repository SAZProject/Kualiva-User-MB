import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:like_it/data/search_bar/suggestion_repository.dart';

part 'home_search_bar_state.dart';

class HomeSearchBarCubit extends Cubit<HomeSearchBarState> {
  final SuggestionRepository _suggestionRepository;

  HomeSearchBarCubit(this._suggestionRepository)
      : super(HomeSearchBarInitial());

  void loadSuggestion() async {
    debugPrint("getSuggestion");
    final homeSuggestion = await _suggestionRepository.getHomeSuggestion();
    emit(HomeSearchBarSuccess(homeSuggestion: homeSuggestion));
  }
}
