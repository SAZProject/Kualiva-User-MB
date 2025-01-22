import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/screen/widget/search_list_item.dart';
import 'package:kualiva/common/screen/widget/search_media_item.dart';
import 'package:kualiva/common/widget/custom_app_bar.dart';
import 'package:kualiva/common/widget/custom_section_header.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _searchAppBar(context),
        body: SizedBox(
          width: double.maxFinite,
          height: Sizeutils.height,
          child: _body(context),
        ),
      ),
    );
  }

  PreferredSizeWidget _searchAppBar(BuildContext context) {
    return CustomAppBar(
      title: context.tr("search.title"),
      onBackPressed: () => Navigator.pop(context),
    );
  }

  Widget _body(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 5.h),
            _buildMediaList(),
            SizedBox(height: 5.h),
            _buildTrendList(context),
            SizedBox(height: 5.h),
            _buildRecentList(context),
            SizedBox(height: 5.h),
          ],
        ),
      ),
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
            padding: EdgeInsets.symmetric(horizontal: 6.h),
            child: SizedBox(
              width: double.maxFinite,
              child: ListView.builder(
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
            padding: EdgeInsets.symmetric(horizontal: 6.h),
            child: SizedBox(
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: 6,
                itemBuilder: (context, index) {
                  //TODO add waiting, empty, error state in future
                  return SearchListItem(
                    prefixIcon: Icons.access_time_filled,
                    suffixIcon: Icons.arrow_outward,
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
}
