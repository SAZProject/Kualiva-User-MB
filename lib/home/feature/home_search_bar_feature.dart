import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/common/feature/search_bar/my_sliver_search_bar_widget.dart';
import 'package:kualiva/home/cubit/home_search_bar_cubit.dart';

class HomeSearchBarFeature extends StatelessWidget {
  const HomeSearchBarFeature({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<HomeSearchBarCubit>().loadSuggestion();

    return BlocBuilder<HomeSearchBarCubit, HomeSearchBarState>(
      builder: (context, state) {
        if (state is! HomeSearchBarSuccess) {
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
