import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/_data/enum/spa_action_enum.dart';
import 'package:kualiva/common/utility/sized_utils.dart';
import 'package:kualiva/common/widget/custom_empty_state.dart';
import 'package:kualiva/common/widget/custom_error_state.dart';
import 'package:kualiva/common/widget/custom_section_header.dart';
import 'package:kualiva/places/argument/place_argument.dart';
import 'package:kualiva/places/spa/argument/spa_action_argument.dart';
import 'package:kualiva/places/spa/bloc/spa_recommended_bloc.dart';
import 'package:kualiva/places/spa/model/spa_recommended_page.dart';
import 'package:kualiva/places/spa/widget/spa_recommended_item.dart';
import 'package:kualiva/router.dart';

class SpaRecommendedFeature extends StatelessWidget {
  const SpaRecommendedFeature({
    super.key,
    required this.parentScrollController,
    required this.childScrollController,
    required this.onSpaActionCallback,
  });

  final ScrollController parentScrollController;
  final ScrollController childScrollController;
  final Function(SpaActionEnum) onSpaActionCallback;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSectionHeader(
            label: context.tr("spa.recommended"),
            useIcon: true,
            onPressed: () async {
              await Navigator.pushNamed(
                context,
                AppRoutes.spaActionScreen,
                arguments: SpaActionArgument(
                  title: context.tr("spa.recommended"),
                  spaActionEnum: SpaActionEnum.recommended,
                ),
              );
              onSpaActionCallback(SpaActionEnum.recommended);
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
    return BlocBuilder<SpaRecommendedBloc, SpaRecommendedState>(
      builder: (context, state) {
        if (state is SpaRecommendedFailure) {
          return CustomErrorState(
            errorMessage: context.tr("common.error_try_again"),
            onRetry: () {},
          );
        }

        if (state is SpaRecommendedLoading &&
            state.spaRecommendedPage != null) {
          return _listBuilder(state.spaRecommendedPage!);
        }

        if (state is! SpaRecommendedSuccess) {
          return Center(child: CircularProgressIndicator());
        }

        if (state.spaRecommendedPage.data.isEmpty) {
          return CustomEmptyState();
        }

        return _listBuilder(state.spaRecommendedPage);
      },
    );
  }

  Widget _listBuilder(SpaRecommendedPage spaRecommendedPage) {
    final spaRecommendedList = spaRecommendedPage.data;
    return ListView.builder(
      controller: childScrollController,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: spaRecommendedList.length,
      itemBuilder: (context, index) {
        return SpaRecommendedItem(
          place: spaRecommendedList[index],
          onPressed: () {
            Navigator.pushNamed(
              context,
              AppRoutes.spaDetailScreen,
              arguments: PlaceArgument(
                placeId: spaRecommendedList[index].id,
                isMerchant: spaRecommendedList[index].isMerchant,
                featuredImage: spaRecommendedList[index].featuredImage,
              ),
            );
          },
        );
      },
    );
  }
}
