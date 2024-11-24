import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:like_it/data/search_bar/suggestion_repository.dart';

part 'fnb_search_bar_state.dart';

class FnbSearchBarCubit extends Cubit<FnbSearchBarState> {
  final SuggestionRepository _suggestionRepository;

  FnbSearchBarCubit(this._suggestionRepository) : super(FnbSearchBarInitial());

  void loadSuggestion() async {
    final fnbSuggestion = await _suggestionRepository.getFnbSuggestion();
    emit(FnbSearchBarSuccess(fnbSuggestion: fnbSuggestion));
  }
}
