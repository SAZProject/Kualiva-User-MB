import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_it/data/search_bar/my_search_bar_widget.dart';
import 'package:like_it/home/cubit/home_search_bar_cubit.dart';

class HomeSearchBarFeature extends StatelessWidget {
  const HomeSearchBarFeature({super.key});

  @override
  Widget build(BuildContext context) {
    /// TODO initState HomeScreen ?
    context.read<HomeSearchBarCubit>().getSuggestion();

    return BlocBuilder<HomeSearchBarCubit, HomeSearchBarState>(
      builder: (context, state) {
        if (state is! HomeSearchBarSuccess) {
          return MySearchBarWidget(
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

        return MySearchBarWidget(
          suggestionsBuilder: (context, searchController) async {
            // return [];
            return state.homeSuggestion.map((suggest) {
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
