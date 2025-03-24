import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/_data/enum/fnb_action_enum.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/widget/custom_empty_state.dart';
import 'package:kualiva/common/widget/custom_error_state.dart';
import 'package:kualiva/common/widget/custom_section_header.dart';
import 'package:kualiva/places/argument/place_argument.dart';
import 'package:kualiva/places/fnb/argument/fnb_action_argument.dart';
import 'package:kualiva/places/fnb/bloc/fnb_promo_bloc.dart';
import 'package:kualiva/places/fnb/model/fnb_promo_page.dart';
import 'package:kualiva/places/fnb/widget/fnb_promo_item.dart';

class FnbPromoFeature extends StatelessWidget {
  const FnbPromoFeature({
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
            label: context.tr("f_n_b.promo"),
            useIcon: true,
            onPressed: () async {
              await Navigator.pushNamed(
                context,
                AppRoutes.fnbActionScreen,
                arguments: FnbActionArgument(
                  title: context.tr("f_n_b.promo"),
                  fnbActionEnum: FnbActionEnum.promo,
                ),
              );
              onFnbActionCallback(FnbActionEnum.promo);
            },
          ),
          SizedBox(height: 4.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.h),
            child: SizedBox(
              height: 225.h,
              width: double.maxFinite,
              child: _list(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _list() {
    return BlocBuilder<FnbPromoBloc, FnbPromoState>(
      builder: (context, state) {
        if (state is FnbPromoFailure) {
          return CustomErrorState(
            errorMessage: context.tr("common.error_try_again"),
            onRetry: () {}, // TODO: onRetry
          );
        }

        if (state is FnbPromoLoading && state.fnbPromoPage != null) {
          return _listBuilder(state.fnbPromoPage!);
        }

        if (state is! FnbPromoSuccess) {
          return Center(child: CircularProgressIndicator());
        }

        if (state.fnbPromoPage.data.isEmpty) {
          return CustomEmptyState();
        }

        return _listBuilder(state.fnbPromoPage);
      },
    );
  }

  Widget _listBuilder(FnbPromoPage fnbPromoPage) {
    final fnbPromoList = fnbPromoPage.data;

    return ListView.builder(
      controller: childScrollController,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: fnbPromoList.length,
      itemBuilder: (context, index) {
        return FnbPromoItem(
          merchant: fnbPromoList[index],
          onPressed: () {
            Navigator.pushNamed(
              context,
              AppRoutes.fnbDetailScreen,
              arguments: PlaceArgument(
                placeId: fnbPromoList[index].id,
                featuredImage: fnbPromoList[index].featuredImage,
                isMerchant: true,
              ),
            );
          },
        );
      },
    );
  }
}
