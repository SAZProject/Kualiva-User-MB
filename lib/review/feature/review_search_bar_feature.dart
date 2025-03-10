import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/_data/feature/search_bar/my_fixed_search_bar_widget.dart';
import 'package:kualiva/_data/feature/search_bar/search_bar_apalah.dart';
import 'package:kualiva/review/cubit/review_filter_cubit.dart';
import 'package:kualiva/review/cubit/review_search_bar_cubit.dart';

class ReviewSearchBarFeature extends StatelessWidget {
  const ReviewSearchBarFeature({super.key});

  void onSubmitted(BuildContext context, String value) {
    print("DRucco");
    print("ReviewSearchBarFeature.onSubmitted");
    print(value);
    // TODO: ini perihal Flutter doang ini,
    // context.read<ReviewFilterCubit>().filter(description: value);
  }

  @override
  Widget build(BuildContext context) {
    context.read<ReviewSearchBarCubit>().loadSuggestion();
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

        return SearchBarApalah();

        // TODO GOD HELP ME ....
        // TODO WINKY HELP UI

        // if (state is ReviewSearchBarSuccess) {
        //   reviewSuggestionList = state.reviewSuggestion;
        // }
        // return MyFixedSearchBarWidget(
        //   onSubmitted: onSubmitted,
        //   suggestionsBuilder: (context, searchController) async {
        //     return reviewSuggestionList.map((suggest) {
        //       return ListTile(
        //         title: Text(suggest),
        //         onTap: () {
        //           print('DRucco');
        //           print('onTap');
        //           print(suggest);
        //           searchController.closeView(suggest);
        //         },
        //       );
        //     }).toList();
        //   },
        // );
      },
    );
  }
}
