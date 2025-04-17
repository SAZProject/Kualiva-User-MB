import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/_data/enum/nightlife_action_enum.dart';
import 'package:kualiva/common/utility/sized_utils.dart';
import 'package:kualiva/common/widget/custom_empty_state.dart';
import 'package:kualiva/common/widget/custom_error_state.dart';
import 'package:kualiva/common/widget/custom_section_header.dart';
import 'package:kualiva/places/argument/place_argument.dart';
import 'package:kualiva/places/nightlife/argument/nightlife_action_argument.dart';
import 'package:kualiva/places/nightlife/bloc/nightlife_recommended_bloc.dart';
import 'package:kualiva/places/nightlife/model/nightlife_recommended_page.dart';
import 'package:kualiva/places/nightlife/widget/nightlife_recommended_item.dart';
import 'package:kualiva/router.dart';

class NightlifeRecommendedFeature extends StatelessWidget {
  const NightlifeRecommendedFeature({
    super.key,
    required this.parentScrollController,
    required this.onNightlifeActionCallback,
  });

  final ScrollController parentScrollController;
  final Function(NightlifeActionEnum) onNightlifeActionCallback;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSectionHeader(
            label: context.tr("nightlife.recommended"),
            useIcon: true,
            onPressed: () async {
              await Navigator.pushNamed(
                context,
                AppRoutes.nightLifeActionScreen,
                arguments: NightlifeActionArgument(
                  title: context.tr("nightlife.recommended"),
                  nightlifeActionEnum: NightlifeActionEnum.recommended,
                ),
              );
              onNightlifeActionCallback(NightlifeActionEnum.recommended);
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.h),
            child: SizedBox(
              height: 450.h,
              width: double.maxFinite,
              child: NotificationListener(
                onNotification: (ScrollNotification notification) {
                  if (notification is ScrollUpdateNotification) {
                    if (notification.metrics.pixels ==
                        notification.metrics.maxScrollExtent) {
                      parentScrollController.animateTo(
                          parentScrollController.position.maxScrollExtent,
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeIn);
                    } else if (notification.metrics.pixels ==
                        notification.metrics.minScrollExtent) {
                      parentScrollController.animateTo(
                          parentScrollController.position.minScrollExtent,
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeIn);
                    }
                  }
                  return true;
                },
                child: _list(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _list() {
    return BlocBuilder<NightlifeRecommendedBloc, NightlifeRecommendedState>(
      builder: (context, state) {
        if (state is NightlifeRecommendedFailure) {
          return CustomErrorState(
            errorMessage: context.tr("common.error_try_again"),
            onRetry: () {},
          );
        }

        if (state is NightlifeRecommendedLoading &&
            state.nightlifeRecommendedPage != null) {
          return _listBuilder(state.nightlifeRecommendedPage!);
        }

        if (state is! NightlifeRecommendedSuccess) {
          return Center(child: CircularProgressIndicator());
        }

        if (state.nightlifeRecommendedPage.data.isEmpty) {
          return CustomEmptyState();
        }

        return _listBuilder(state.nightlifeRecommendedPage);
      },
    );
  }

  Widget _listBuilder(NightlifeRecommendedPage fnbRecommendedPage) {
    final nightlifebRecommendedList = fnbRecommendedPage.data;
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: nightlifebRecommendedList.length,
      itemBuilder: (context, index) {
        return NightlifeRecommendedItem(
          place: nightlifebRecommendedList[index],
          onPressed: () {
            Navigator.pushNamed(
              context,
              AppRoutes.nightLifeDetailScreen,
              arguments: PlaceArgument(
                placeId: nightlifebRecommendedList[index].id,
                isMerchant: nightlifebRecommendedList[index].isMerchant,
                featuredImage: nightlifebRecommendedList[index].featuredImage,
              ),
            );
          },
        );
      },
    );
  }
}
