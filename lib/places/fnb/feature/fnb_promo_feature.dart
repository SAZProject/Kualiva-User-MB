import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder;
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/widget/custom_error_state.dart';
import 'package:kualiva/common/widget/custom_section_header.dart';
import 'package:kualiva/places/argument/place_argument.dart';
import 'package:kualiva/places/fnb/bloc/fnb_promo_bloc.dart';
import 'package:kualiva/places/fnb/widget/fnb_promo_item.dart';

class FnbPromoFeature extends StatelessWidget {
  const FnbPromoFeature({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSectionHeader(
            label: context.tr("f_n_b.promo"),
            useIcon: false,
          ),
          SizedBox(height: 4.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.h),
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
              onRetry: () {});
        }
        if (state is! FnbPromoSuccess) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 6,
          itemBuilder: (context, index) {
            return FnbPromoItem(
              merchant: state.fnbPromoModels[index],
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.fnbDetailScreen,
                  arguments: PlaceArgument(
                    placeId: state.fnbPromoModels[index].id,
                    featuredImage: state.fnbPromoModels[index].featuredImage,
                    isMerchant: true,
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
