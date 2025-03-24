import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/_data/enum/spa_action_enum.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/widget/custom_empty_state.dart';
import 'package:kualiva/common/widget/custom_error_state.dart';
import 'package:kualiva/common/widget/custom_section_header.dart';
import 'package:kualiva/places/argument/place_argument.dart';
import 'package:kualiva/places/spa/argument/spa_action_argument.dart';
import 'package:kualiva/places/spa/bloc/spa_promo_bloc.dart';
import 'package:kualiva/places/spa/model/spa_promo_page.dart';
import 'package:kualiva/places/spa/widget/spa_promo_item.dart';

class SpaPromoFeature extends StatelessWidget {
  const SpaPromoFeature({
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
            label: context.tr("spa.promo"),
            useIcon: true,
            onPressed: () async {
              await Navigator.pushNamed(
                context,
                AppRoutes.spaActionScreen,
                arguments: SpaActionArgument(
                  title: context.tr("spa.promo"),
                  spaActionEnum: SpaActionEnum.promo,
                ),
              );
              onSpaActionCallback(SpaActionEnum.promo);
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
    return BlocBuilder<SpaPromoBloc, SpaPromoState>(
      builder: (context, state) {
        if (state is SpaPromoFailure) {
          return CustomErrorState(
            errorMessage: context.tr("common.error_try_again"),
            onRetry: () {}, // TODO: onRetry
          );
        }

        if (state is SpaPromoLoading && state.spaPromoPage != null) {
          return _listBuilder(state.spaPromoPage!);
        }

        if (state is! SpaPromoSuccess) {
          return Center(child: CircularProgressIndicator());
        }

        if (state.spaPromoPage.data.isEmpty) {
          return CustomEmptyState();
        }

        return _listBuilder(state.spaPromoPage);
      },
    );
  }

  Widget _listBuilder(SpaPromoPage spaPromoPage) {
    final spaPromoList = spaPromoPage.data;

    return ListView.builder(
      controller: childScrollController,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: spaPromoList.length,
      itemBuilder: (context, index) {
        return SpaPromoItem(
          merchant: spaPromoList[index],
          onPressed: () {
            Navigator.pushNamed(
              context,
              AppRoutes.spaDetailScreen,
              arguments: PlaceArgument(
                placeId: spaPromoList[index].id,
                featuredImage: spaPromoList[index].featuredImage,
                isMerchant: true,
              ),
            );
          },
        );
      },
    );
  }
}
