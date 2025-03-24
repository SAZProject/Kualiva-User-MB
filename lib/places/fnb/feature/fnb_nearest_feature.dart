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
import 'package:kualiva/places/fnb/bloc/fnb_nearest_bloc.dart';
import 'package:kualiva/places/fnb/model/fnb_nearest_page.dart';
import 'package:kualiva/places/fnb/widget/fnb_nearest_item.dart';
import 'package:kualiva/router.dart';

class FnbNearestFeature extends StatelessWidget {
  const FnbNearestFeature({
    super.key,
    required this.childScrollController,
    required this.onFnbActionCallback,
  });

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
            label: context.tr("f_n_b.nearest"),
            useIcon: true,
            onPressed: () async {
              await Navigator.pushNamed(
                context,
                AppRoutes.fnbActionScreen,
                arguments: FnbActionArgument(
                  title: context.tr("f_n_b.nearest"),
                  fnbActionEnum: FnbActionEnum.nearest,
                ),
              );
              onFnbActionCallback(FnbActionEnum.nearest);
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
    return BlocBuilder<FnbNearestBloc, FnbNearestState>(
      builder: (context, state) {
        if (state is FnbNearestFailure) {
          return CustomErrorState(
            errorMessage: context.tr("common.error_try_again"),
            onRetry: () {}, // TODO: onRetry
          );
        }

        if (state is FnbNearestLoading && state.fnbNearestPage != null) {
          return _listBuilder(state.fnbNearestPage!);
        }

        if (state is! FnbNearestSuccess) {
          return Center(child: CircularProgressIndicator());
        }

        if (state.fnbNearestPage.data.isEmpty) {
          return CustomEmptyState();
        }

        return _listBuilder(state.fnbNearestPage);
      },
    );
  }

  Widget _listBuilder(FnbNearestPage fnbNearesPage) {
    final fnbNearestList = fnbNearesPage.data;
    return ListView.builder(
      controller: childScrollController,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: fnbNearestList.length,
      itemBuilder: (context, index) {
        return FnbNearestItem(
          merchant: fnbNearestList[index],
          onPressed: () {
            Navigator.pushNamed(
              context,
              AppRoutes.fnbDetailScreen,
              arguments: PlaceArgument(
                placeId: fnbNearestList[index].id,
                isMerchant: fnbNearestList[index].isMerchant,
                featuredImage: fnbNearestList[index].featuredImage,
              ),
            );
          },
        );
      },
    );
  }
}
