import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/widget/custom_empty_state.dart';
import 'package:kualiva/common/widget/custom_error_state.dart';
import 'package:kualiva/common/widget/custom_section_header.dart';
import 'package:kualiva/places/argument/place_argument.dart';
import 'package:kualiva/places/spa/bloc/spa_nearest_bloc.dart';
import 'package:kualiva/places/spa/model/spa_nearest_page.dart';
import 'package:kualiva/places/spa/widget/spa_nearest_item.dart';

class SpaNearestFeature extends StatelessWidget {
  const SpaNearestFeature({
    super.key,
    required this.parentScrollController,
    required this.childScrollController,
  });

  final ScrollController parentScrollController;
  final ScrollController childScrollController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSectionHeader(
            label: context.tr("spa.nearest"),
            // onPressed: () {},
            useIcon: false,
          ),
          SizedBox(height: 4.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.h),
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
    return BlocBuilder<SpaNearestBloc, SpaNearestState>(
      builder: (context, state) {
        if (state is SpaNearestFailure) {
          return CustomErrorState(
            errorMessage: context.tr("common.error_try_again"),
            onRetry: () {}, // TODO: onRetry
          );
        }

        if (state is SpaNearestLoading && state.spaNearestPage != null) {
          return _listBuilder(state.spaNearestPage!);
        }

        if (state is! SpaNearestSuccess) {
          return Center(child: CircularProgressIndicator());
        }

        if (state.spaNearestPage.data.isEmpty) {
          return CustomEmptyState();
        }

        return _listBuilder(state.spaNearestPage);
      },
    );
  }

  Widget _listBuilder(SpaNearestPage spaNearestPage) {
    final spaNearestList = spaNearestPage.data;
    return ListView.builder(
      controller: childScrollController,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: spaNearestList.length,
      itemBuilder: (context, index) {
        return SpaNearestItem(
          merchant: spaNearestList[index],
          onPressed: () {
            Navigator.pushNamed(
              context,
              AppRoutes.spaDetailScreen,
              arguments: PlaceArgument(
                placeId: spaNearestList[index].id,
                isMerchant: spaNearestList[index].isMerchant,
                featuredImage: spaNearestList[index].featuredImage,
              ),
            );
          },
        );
      },
    );
  }
}
