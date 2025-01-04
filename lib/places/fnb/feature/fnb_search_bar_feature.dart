import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/common/feature/search_bar/my_sliver_search_bar_widget.dart';
import 'package:kualiva/places/fnb/cubit/fnb_search_bar_cubit.dart';

class FnbSearchBarFeature extends StatelessWidget {
  const FnbSearchBarFeature({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<FnbSearchBarCubit>().loadSuggestion();

    return BlocBuilder<FnbSearchBarCubit, FnbSearchBarState>(
      builder: (context, state) {
        if (state is! FnbSearchBarSuccess) {
          return MySliverSearchBarWidget(
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

        return MySliverSearchBarWidget(
          suggestionsBuilder: (context, searchController) async {
            return state.fnbSuggestion.map((suggest) {
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
