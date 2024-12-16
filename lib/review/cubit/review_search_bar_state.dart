part of 'review_search_bar_cubit.dart';

@immutable
sealed class ReviewSearchBarState {}

final class ReviewSearchBarInitial extends ReviewSearchBarState {}

final class ReviewSearchBarSuccess extends ReviewSearchBarState {
  final List<String> reviewSuggestion;

  ReviewSearchBarSuccess({
    required this.reviewSuggestion,
  });
}
