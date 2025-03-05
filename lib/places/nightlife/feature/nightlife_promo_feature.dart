import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/common/utility/sized_utils.dart';
import 'package:kualiva/common/widget/custom_error_state.dart';
import 'package:kualiva/common/widget/custom_section_header.dart';
import 'package:kualiva/places/argument/place_argument.dart';
import 'package:kualiva/places/nightlife/bloc/nightlife_promo_bloc.dart';
import 'package:kualiva/places/nightlife/widget/nightlife_promo_item.dart';
import 'package:kualiva/router.dart';

class NightlifePromoFeature extends StatelessWidget {
  const NightlifePromoFeature({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSectionHeader(
            label: context.tr("nightlife.promo"),
            useIcon: false,
          ),
          SizedBox(height: 4.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.h),
            child: SizedBox(
              height: 225.h,
              width: double.maxFinite,
              child: _promoList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _promoList() {
    return BlocBuilder<NightlifePromoBloc, NightlifePromoState>(
      builder: (context, state) {
        if (state is NightlifePromoFailure) {
          return CustomErrorState(
            errorMessage: context.tr("common.error_try_again"),
            onRetry: () {},
          );
        }
        if (state is! NightlifePromoSuccess) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 6,
          itemBuilder: (context, index) {
            return NightlifePromoItem(
              merchant: state.promo[index],
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.nightLifeDetailScreen,
                  arguments: PlaceArgument(
                    placeId: state.promo[index].id,
                    isMerchant: state.promo[index].isMerchant,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
