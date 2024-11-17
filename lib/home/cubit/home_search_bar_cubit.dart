import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:like_it/data/search_bar/suggestion_repository.dart';

part 'home_search_bar_state.dart';

class HomeSearchBarCubit extends Cubit<HomeSearchBarState> {
  final SuggestionRepository _searchRepository;

  HomeSearchBarCubit(this._searchRepository) : super(HomeSearchBarInitial());

  void getSuggestion() async {
    debugPrint("getSuggestion");
    // emit(HomeSearchBarLoading());
    final homeSuggestion = await _searchRepository.getHomeSuggestion();
    emit(HomeSearchBarSuccess(homeSuggestion: homeSuggestion));
  }
}
