import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/_data/enum/fnb_action_enum.dart';
import 'package:kualiva/_data/enum/recent_suggestion_enum.dart';
import 'package:kualiva/common/cubit/search_bar_cubit.dart';
import 'package:kualiva/common/feature/search_bar/my_fixed_search_bar_widget.dart';
import 'package:kualiva/common/feature/search_bar/my_sliver_search_bar_widget.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/screen/widget/search_list_item.dart';
import 'package:kualiva/common/screen/widget/search_media_item.dart';
import 'package:kualiva/common/widget/custom_section_header.dart';
import 'package:kualiva/places/fnb/argument/fnb_action_argument.dart';

class FnbMainSearchBarFeature extends StatelessWidget {
  const FnbMainSearchBarFeature({
    super.key,
    required this.recentSuggestionEnum,
    this.isSliverSearchBar = true,
  });

  final RecentSuggestionEnum recentSuggestionEnum;
  final bool isSliverSearchBar;

  @override
  Widget build(BuildContext context) {
    context
        .read<SearchBarCubit>()
        .loadSuggestion(recentSuggestEnum: recentSuggestionEnum);

    final List<Widget> listSearchSuggest = [
      SizedBox(height: 5.h),
      _buildMediaList(),
      SizedBox(height: 5.h),
      _buildTrendList(context),
      SizedBox(height: 5.h),
      _buildRecentList(context),
      SizedBox(height: 5.h),
    ];

    if (isSliverSearchBar) {
      return MySliverSearchBarWidget(
        viewOnSubmitted: (value) {
          Navigator.pushReplacementNamed(context, AppRoutes.fnbActionScreen,
              arguments: FnbActionArgument(
                title: value,
                fnbActionEnum: FnbActionEnum.nearest,
                searchName: value,
              ));
        },
        suggestionsBuilder: (context, searchController) async {
          return listSearchSuggest;
        },
      );
    }

    return MyFixedSearchBarWidget(
      viewOnSubmitted: (value) {
        Navigator.pushReplacementNamed(context, AppRoutes.fnbActionScreen,
            arguments: FnbActionArgument(
              title: value,
              fnbActionEnum: FnbActionEnum.nearest,
              searchName: value,
            ));
      },
      suggestionsBuilder: (context, searchController) async {
        return listSearchSuggest;
      },
    );
  }

  Widget _buildMediaList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.h),
          child: SizedBox(
            height: 150.h,
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              itemBuilder: (context, index) {
                //TODO add waiting, empty, error state in future
                return SearchMediaItem(
                  image:
                      Faker().image.loremPicsum(random: Random().nextInt(300)),
                  label: Faker().food.dish(),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTrendList(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSectionHeader(
            label: context.tr("search.trending"),
            useIcon: false,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.h),
            child: SizedBox(
              width: double.maxFinite,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: 3,
                itemBuilder: (context, index) {
                  //TODO add waiting, empty, error state in future
                  return SearchListItem(
                    prefixIcon: Icons.trending_up,
                    label: Faker().food.dish(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentList(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSectionHeader(
            label: context.tr("search.recent"),
            useIcon: false,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.h),
            child: SizedBox(
              width: double.maxFinite,
              child: BlocBuilder<SearchBarCubit, SearchBarState>(
                  builder: (context, state) {
                if (state is! SearchBarSuccess) {
                  return SizedBox();
                }
                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: state.recentSuggestion.length,
                  itemBuilder: (context, index) {
                    return SearchListItem(
                      prefixIcon: Icons.access_time_filled,
                      suffixIcon: Icons.arrow_outward,
                      label: state.recentSuggestion[index],
                    );
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
