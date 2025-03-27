import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/common/widget/custom_empty_state.dart';
import 'package:kualiva/common/widget/custom_error_state.dart';
import 'package:kualiva/places/argument/place_argument.dart';
import 'package:kualiva/places/nightlife/bloc/nightlife_action_bloc.dart';
import 'package:kualiva/places/nightlife/model/nightlife_action_model.dart';
import 'package:kualiva/places/nightlife/widget/nightlife_action_item.dart';
import 'package:kualiva/router.dart';

class NightlifeActionFeature extends StatefulWidget {
  const NightlifeActionFeature({super.key});

  @override
  State<NightlifeActionFeature> createState() => _NightlifeActionFeatureState();
}

class _NightlifeActionFeatureState extends State<NightlifeActionFeature> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: _listNightlifeAction(),
    );
  }

  Widget _listNightlifeAction() {
    return BlocBuilder<NightlifeActionBloc, NightlifeActionState>(
      builder: (context, state) {
        /// TODO: Clean Code Later, terlalu banyak boilerplate

        if (state is NightlifeActionFailure) {
          return CustomErrorState(
            errorMessage: context.tr('common.error_try_again'),
            onRetry: () {},
          );
        }

        /// Nearest
        if (state is NightlifeActionLoadingNearest &&
            state.nightlifeNearestPage != null) {
          final nightlifeNearestList = state.nightlifeNearestPage!.data;
          return _listBuilder(nightlifeNearestList.map((e) {
            return NightlifeActionModel.fromNearestModel(e);
          }).toList());
        }

        if (state is NightlifeActionSuccessNearest) {
          final nightlifeNearestList = state.nightlifeNearestPage.data;
          if (nightlifeNearestList.isEmpty) return CustomEmptyState();
          return _listBuilder(nightlifeNearestList.map((e) {
            return NightlifeActionModel.fromNearestModel(e);
          }).toList());
        }

        /// Promo
        if (state is NightlifeActionLoadingPromo &&
            state.nightlifePromoPage != null) {
          final nightlifePromoList = state.nightlifePromoPage!.data;
          return _listBuilder(nightlifePromoList.map((e) {
            return NightlifeActionModel.fromPromoModel(e);
          }).toList());
        }

        if (state is NightlifeActionSuccessPromo) {
          final nightlifePromoList = state.nightlifePromoPage.data;
          if (nightlifePromoList.isEmpty) return CustomEmptyState();
          return _listBuilder(nightlifePromoList.map((e) {
            return NightlifeActionModel.fromPromoModel(e);
          }).toList());
        }

        /// Recommended
        if (state is NightlifeActionLoadingRecommended &&
            state.nightlifeRecommendedPage != null) {
          final nightlifeRecommendedList = state.nightlifeRecommendedPage!.data;
          return _listBuilder(nightlifeRecommendedList.map((e) {
            return NightlifeActionModel.fromRecommendedModel(e);
          }).toList());
        }

        if (state is NightlifeActionSuccessRecommended) {
          final nightlifeRecommendedList = state.nightlifeRecommendedPage.data;
          if (nightlifeRecommendedList.isEmpty) return CustomEmptyState();
          return _listBuilder(nightlifeRecommendedList.map((e) {
            return NightlifeActionModel.fromRecommendedModel(e);
          }).toList());
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _listBuilder(List<NightlifeActionModel> placeList) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: placeList.length,
      itemBuilder: (context, index) {
        return NightlifeActionItem(
          place: placeList[index],
          onPressed: () {
            Navigator.pushNamed(
              context,
              AppRoutes.nightLifeDetailScreen,
              arguments: PlaceArgument(
                placeId: placeList[index].id,
                isMerchant: placeList[index].isMerchant,
                featuredImage: placeList[index].featuredImage,
              ),
            );
          },
        );
      },
    );
  }
}
