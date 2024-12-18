import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/data/search_bar/my_fixed_search_bar_widget.dart';
import 'package:kualiva/review/cubit/review_search_bar_cubit.dart';

class ReviewSearchBarFeature extends StatelessWidget {
  const ReviewSearchBarFeature({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ReviewSearchBarCubit>().loadSuggestion();

    return BlocBuilder<ReviewSearchBarCubit, ReviewSearchBarState>(
      builder: (context, state) {
        if (state is! ReviewSearchBarSuccess) {
          return MyFixedSearchBarWidget(
            suggestionsBuilder: (context, searchController) async {
              return [].map((suggest) {
                return ListTile(
                  title: Text(suggest),
                  onTap: () {
                    searchController.closeView(suggest);
                  },
                );
              }).toList();
            },
          );
        }

        return MyFixedSearchBarWidget(
          suggestionsBuilder: (context, searchController) async {
            return state.reviewSuggestion.map((suggest) {
              return ListTile(
                title: Text(suggest),
                onTap: () {
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
