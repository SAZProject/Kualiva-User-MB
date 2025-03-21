part of 'search_bar_cubit.dart';

@immutable
sealed class SearchBarState {}

final class SearchBarInitial extends SearchBarState {}

final class SearchBarSuccess extends SearchBarState {
  final List<String> recentSuggestion;

  SearchBarSuccess({
    required this.recentSuggestion,
  });
}
