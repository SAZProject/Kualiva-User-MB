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
import 'package:kualiva/places/spa/bloc/spa_nearest_bloc.dart';
import 'package:kualiva/places/spa/model/spa_nearest_page.dart';
import 'package:kualiva/places/spa/widget/spa_nearest_item.dart';
import 'package:kualiva/router.dart';

class SpaNearestFeature extends StatelessWidget {
  const SpaNearestFeature({
    super.key,
    required this.childScrollController,
    required this.onSpaActionCallback,
  });

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
            label: context.tr("spa.nearest"),
            useIcon: true,
            onPressed: () async {
              await Navigator.pushNamed(
                context,
                AppRoutes.spaActionScreen,
                arguments: SpaActionArgument(
                  title: context.tr("spa.nearest"),
                  spaActionEnum: SpaActionEnum.nearest,
                ),
              );
              onSpaActionCallback(SpaActionEnum.nearest);
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
      scrollDirection: Axis.horizontal,
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
