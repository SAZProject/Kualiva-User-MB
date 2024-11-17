part of 'home_search_bar_cubit.dart';

@immutable
sealed class HomeSearchBarState {}

final class HomeSearchBarInitial extends HomeSearchBarState {}

final class HomeSearchBarSuccess extends HomeSearchBarState {
  final List<String> homeSuggestion;

  HomeSearchBarSuccess({
    required this.homeSuggestion,
  });
}
