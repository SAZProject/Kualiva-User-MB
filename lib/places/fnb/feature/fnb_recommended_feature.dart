import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/_data/enum/fnb_action_enum.dart';
import 'package:kualiva/common/utility/sized_utils.dart';
import 'package:kualiva/common/widget/custom_empty_state.dart';
import 'package:kualiva/common/widget/custom_error_state.dart';
import 'package:kualiva/common/widget/custom_section_header.dart';
import 'package:kualiva/places/argument/place_argument.dart';
import 'package:kualiva/places/fnb/argument/fnb_action_argument.dart';
import 'package:kualiva/places/fnb/bloc/fnb_recommended_bloc.dart';
import 'package:kualiva/places/fnb/model/fnb_recommended_page.dart';
import 'package:kualiva/places/fnb/widget/fnb_recommended_item.dart';
import 'package:kualiva/router.dart';

class FnbRecommendedFeature extends StatelessWidget {
  const FnbRecommendedFeature({
    super.key,
    required this.parentScrollController,
    required this.childScrollController,
    required this.onFnbActionCallback,
  });

  final ScrollController parentScrollController;
  final ScrollController childScrollController;
  final Function(FnbActionEnum) onFnbActionCallback;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSectionHeader(
            label: context.tr("f_n_b.recommended"),
            useIcon: true,
            onPressed: () async {
              await Navigator.pushNamed(
                context,
                AppRoutes.fnbActionScreen,
                arguments: FnbActionArgument(
                  title: context.tr("f_n_b.recommended"),
                  fnbActionEnum: FnbActionEnum.recommended,
                ),
              );
              onFnbActionCallback(FnbActionEnum.recommended);
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
    return BlocBuilder<FnbRecommendedBloc, FnbRecommendedState>(
      builder: (context, state) {
        if (state is FnbRecommendedFailure) {
          return CustomErrorState(
            errorMessage: context.tr("common.error_try_again"),
            onRetry: () {},
          );
        }

        if (state is FnbRecommendedLoading &&
            state.fnbRecommendedPage != null) {
          return _listBuilder(state.fnbRecommendedPage!);
        }

        if (state is! FnbRecommendedSuccess) {
          return Center(child: CircularProgressIndicator());
        }

        if (state.fnbRecommendedPage.data.isEmpty) {
          return CustomEmptyState();
        }

        return _listBuilder(state.fnbRecommendedPage);
      },
    );
  }

  Widget _listBuilder(FnbRecommendedPage fnbRecommendedPage) {
    final fnbRecommendedList = fnbRecommendedPage.data;
    print("LeRucco");
    print(fnbRecommendedList.length);
    for (int i = 0; i < fnbRecommendedList.length; i++) {
      print(fnbRecommendedList[i]);
    }
    return ListView.builder(
      controller: childScrollController,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: fnbRecommendedList.length,
      itemBuilder: (context, index) {
        return FnbRecommendedItem(
          place: fnbRecommendedList[index],
          onPressed: () {
            Navigator.pushNamed(
              context,
              AppRoutes.fnbDetailScreen,
              arguments: PlaceArgument(
                placeId: fnbRecommendedList[index].id,
                isMerchant: fnbRecommendedList[index].isMerchant,
                featuredImage: fnbRecommendedList[index].featuredImage,
              ),
            );
          },
        );
      },
    );
  }
}
