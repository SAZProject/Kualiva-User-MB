import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/common/utility/sized_utils.dart';
import 'package:kualiva/common/widget/custom_empty_state.dart';
import 'package:kualiva/common/widget/custom_error_state.dart';
import 'package:kualiva/places/argument/place_argument.dart';
import 'package:kualiva/places/fnb/bloc/fnb_action_bloc.dart';
import 'package:kualiva/places/fnb/model/fnb_action_model.dart';
import 'package:kualiva/places/fnb/widget/fnb_action_item.dart';
import 'package:kualiva/router.dart';

class FnbActionFeature extends StatefulWidget {
  const FnbActionFeature({super.key, required this.scrollController});

  final ScrollController scrollController;

  @override
  State<FnbActionFeature> createState() => _FnbActionFeatureState();
}

class _FnbActionFeatureState extends State<FnbActionFeature> {
  ScrollController get scrollController => widget.scrollController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450.h,
      width: double.maxFinite,
      child: _listFnbAction(),
    );
  }

  Widget _listFnbAction() {
    return BlocBuilder<FnbActionBloc, FnbActionState>(
      builder: (context, state) {
        /// TODO: Clean Code Later, terlalu banyak boilerplate

        if (state is FnbActionFailure) {
          return CustomErrorState(
            errorMessage: context.tr('common.error_try_again'),
            onRetry: () {},
          );
        }

        if (state is FnbActionLoadingNearest && state.fnbNearestPage != null) {
          final fnbNearestList = state.fnbNearestPage!.data;
          return _listBuilder(fnbNearestList.map((e) {
            return FnbActionModel.fromNearestModel(e);
          }).toList());
        }

        if (state is FnbActionLoadingPromo && state.fnbPromoPage != null) {
          final fnbPromoList = state.fnbPromoPage!.data;
          return _listBuilder(fnbPromoList.map((e) {
            return FnbActionModel.fromPromoModel(e);
          }).toList());
        }

        if (state is FnbActionLoadingRecommended &&
            state.fnbRecommendedPage != null) {
          final fnbRecommendedList = state.fnbRecommendedPage!.data;
          return _listBuilder(fnbRecommendedList.map((e) {
            return FnbActionModel.fromRecommendedModel(e);
          }).toList());
        }

        if (state is FnbActionSuccessNearest) {
          final fnbNearestList = state.fnbNearestPage.data;
          if (fnbNearestList.isEmpty) return CustomEmptyState();
          return _listBuilder(fnbNearestList.map((e) {
            return FnbActionModel.fromNearestModel(e);
          }).toList());
        }

        if (state is FnbActionSuccessPromo) {
          final fnbPromoList = state.fnbPromoPage.data;
          if (fnbPromoList.isEmpty) return CustomEmptyState();
          return _listBuilder(fnbPromoList.map((e) {
            return FnbActionModel.fromPromoModel(e);
          }).toList());
        }

        if (state is FnbActionSuccessRecommended) {
          final fnbRecommendedList = state.fnbRecommendedPage.data;
          if (fnbRecommendedList.isEmpty) return CustomEmptyState();
          return _listBuilder(fnbRecommendedList.map((e) {
            return FnbActionModel.fromRecommendedModel(e);
          }).toList());
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _listBuilder(List<FnbActionModel> placeList) {
    return ListView.builder(
      controller: scrollController,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: placeList.length,
      itemBuilder: (context, index) {
        return FnbActionItem(
          place: placeList[index],
          onPressed: () {
            Navigator.pushNamed(
              context,
              AppRoutes.fnbDetailScreen,
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
