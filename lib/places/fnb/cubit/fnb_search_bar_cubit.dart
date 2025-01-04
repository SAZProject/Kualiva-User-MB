import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/_repository/suggestion_repository.dart';

part 'fnb_search_bar_state.dart';

class FnbSearchBarCubit extends Cubit<FnbSearchBarState> {
  final SuggestionRepository _suggestionRepository;

  FnbSearchBarCubit(this._suggestionRepository) : super(FnbSearchBarInitial());

  void loadSuggestion() async {
    final fnbSuggestion = await _suggestionRepository.getFnbSuggestion();
    LeLog.bd(this, loadSuggestion, fnbSuggestion.toString());
    emit(FnbSearchBarSuccess(fnbSuggestion: fnbSuggestion));
  }
}
