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
import 'package:kualiva/places/nightlife/bloc/nightlife_promo_bloc.dart';
import 'package:kualiva/places/nightlife/model/nightlife_promo_page.dart';
import 'package:kualiva/places/nightlife/widget/nightlife_promo_item.dart';
import 'package:kualiva/router.dart';

class NightlifePromoFeature extends StatelessWidget {
  const NightlifePromoFeature({
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
            label: context.tr("nightlife.promo"),
            useIcon: true,
            onPressed: () async {
              await Navigator.pushNamed(
                context,
                AppRoutes.nightLifeActionScreen,
                arguments: NightlifeActionArgument(
                  title: context.tr("nightlife.promo"),
                  nightlifeActionEnum: NightlifeActionEnum.promo,
                ),
              );
              onNightlifeActionCallback(NightlifeActionEnum.promo);
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
    return BlocBuilder<NightlifePromoBloc, NightlifePromoState>(
      builder: (context, state) {
        if (state is NightlifePromoFailure) {
          return CustomErrorState(
            errorMessage: context.tr("common.error_try_again"),
            onRetry: () {}, // TODO: onRetry
          );
        }

        if (state is NightlifePromoLoading &&
            state.nightlifePromoPage != null) {
          return _listBuilder(state.nightlifePromoPage!);
        }

        if (state is! NightlifePromoSuccess) {
          return Center(child: CircularProgressIndicator());
        }

        if (state.nightlifePromoPage.data.isEmpty) {
          return CustomEmptyState();
        }

        return _listBuilder(state.nightlifePromoPage);
      },
    );
  }

  Widget _listBuilder(NightlifePromoPage nightLifePromoPage) {
    final nightlifePromoList = nightLifePromoPage.data;

    return ListView.builder(
      controller: childScrollController,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: nightlifePromoList.length,
      itemBuilder: (context, index) {
        return NightlifePromoItem(
          merchant: nightlifePromoList[index],
          onPressed: () {
            Navigator.pushNamed(
              context,
              AppRoutes.nightLifeDetailScreen,
              arguments: PlaceArgument(
                placeId: nightlifePromoList[index].id,
                featuredImage: nightlifePromoList[index].featuredImage,
                isMerchant: true,
              ),
            );
          },
        );
      },
    );
  }
}
