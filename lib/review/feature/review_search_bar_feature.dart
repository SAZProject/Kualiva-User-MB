import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/_data/feature/search_bar/my_fixed_search_bar_widget.dart';
import 'package:kualiva/review/cubit/review_filter_cubit.dart';
import 'package:kualiva/review/cubit/review_search_bar_cubit.dart';

class ReviewSearchBarFeature extends StatelessWidget {
  const ReviewSearchBarFeature({super.key});

  void onSubmitted(BuildContext context, String value) {
    context.read<ReviewFilterCubit>().filter(description: value);
    context.read<ReviewSearchBarCubit>().add(suggestion: value);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewSearchBarCubit, ReviewSearchBarState>(
      builder: (context, state) {
        List<String> reviewSuggestionList = [
          "le",
          "makan",
          "Apple",
          "Banana",
          "Orange",
          "Mango",
          "Grapes"
        ];

        if (state is ReviewSearchBarSuccess) {
          reviewSuggestionList = state.reviewSuggestion;
        }
        return MyFixedSearchBarWidget(
          onSubmitted: onSubmitted,
          suggestionsBuilder: (context, searchController) async {
            return reviewSuggestionList.map((suggest) {
              return ListTile(
                title: Text(suggest),
                onTap: () {
                  onSubmitted(context, suggest);
                  searchController.closeView(suggest);
                },
              );
            }).toList();
          },
        );
      },
    );
  }
}
