import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/_data/enum/nightlife_action_enum.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/widget/custom_empty_state.dart';
import 'package:kualiva/common/widget/custom_error_state.dart';
import 'package:kualiva/common/widget/custom_section_header.dart';
import 'package:kualiva/places/argument/place_argument.dart';
import 'package:kualiva/places/nightlife/argument/nightlife_action_argument.dart';
import 'package:kualiva/places/nightlife/bloc/nightlife_nearest_bloc.dart';
import 'package:kualiva/places/nightlife/model/nightlife_nearest_page.dart';
import 'package:kualiva/places/nightlife/widget/nightlife_nearest_item.dart';

class NightlifeNearestFeature extends StatelessWidget {
  const NightlifeNearestFeature({
    super.key,
    required this.childScrollController,
    required this.onNightlifeActionCallback,
  });

  final ScrollController childScrollController;
  final Function(NightlifeActionEnum) onNightlifeActionCallback;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSectionHeader(
            label: context.tr("nightlife.nearest"),
            useIcon: true,
            onPressed: () async {
              await Navigator.pushNamed(
                context,
                AppRoutes.nightLifeActionScreen,
                arguments: NightlifeActionArgument(
                  title: context.tr("nightlife.nearest"),
                  nightlifeActionEnum: NightlifeActionEnum.nearest,
                ),
              );
              onNightlifeActionCallback(NightlifeActionEnum.nearest);
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.h),
            child: SizedBox(
              height: 220.h,
              width: double.maxFinite,
              child: _list(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _list() {
    return BlocBuilder<NightlifeNearestBloc, NightlifeNearestState>(
      builder: (context, state) {
        if (state is NightlifeNearestFailure) {
          return CustomErrorState(
            errorMessage: context.tr("common.error_try_again"),
            onRetry: () {}, // TODO: onRetry
          );
        }

        if (state is NightlifeNearestLoading &&
            state.nightlifeNearestPage != null) {
          return _listBuilder(state.nightlifeNearestPage!);
        }

        if (state is! NightlifeNearestSuccess) {
          return Center(child: CircularProgressIndicator());
        }

        if (state.nightlifeNearestPage.data.isEmpty) {
          return CustomEmptyState();
        }

        return _listBuilder(state.nightlifeNearestPage);
      },
    );
  }

  Widget _listBuilder(NightlifeNearestPage nightlifeNearestPage) {
    final nightlifeNearestList = nightlifeNearestPage.data;
    return ListView.builder(
      controller: childScrollController,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: nightlifeNearestList.length,
      itemBuilder: (context, index) {
        return NightlifeNearestItem(
          merchant: nightlifeNearestList[index],
          onPressed: () {
            Navigator.pushNamed(
              context,
              AppRoutes.nightLifeDetailScreen,
              arguments: PlaceArgument(
                placeId: nightlifeNearestList[index].id,
                isMerchant: nightlifeNearestList[index].isMerchant,
                featuredImage: nightlifeNearestList[index].featuredImage,
              ),
            );
          },
        );
      },
    );
  }
}
