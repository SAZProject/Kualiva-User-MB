part of 'fnb_search_bar_cubit.dart';

@immutable
sealed class FnbSearchBarState {}

final class FnbSearchBarInitial extends FnbSearchBarState {}

final class FnbSearchBarSuccess extends FnbSearchBarState {
  final List<String> fnbSuggestion;

  FnbSearchBarSuccess({
    required this.fnbSuggestion,
  });
}
