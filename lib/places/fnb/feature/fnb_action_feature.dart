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
  const FnbActionFeature({super.key});

  @override
  State<FnbActionFeature> createState() => _FnbActionFeatureState();
}

class _FnbActionFeatureState extends State<FnbActionFeature> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450.h,
      width: double.maxFinite,
      child: _listFnbAction(),
    );
  }

  Widget _listFnbAction() {
    final List<FnbActionModel> placeList = [
      const FnbActionModel(
        id: "0",
        name: "place 1",
        averageRating: 2.5,
        fullAddress: "Full Address",
        cityOrVillage: "City Or Village",
        categories: ["Categories 1", "Categories 2"],
        isMerchant: false,
        distanceFromUser: "5",
      ),
      const FnbActionModel(
        id: "1",
        name: "place 2",
        averageRating: 3.0,
        fullAddress: "Full Address",
        cityOrVillage: "City Or Village",
        categories: ["Categories 1", "Categories 2"],
        isMerchant: true,
        distanceFromUser: "10",
      ),
    ];
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
          for (int i = 0; i < fnbNearestList.length; i++) {
            placeList.add(FnbActionModel.fromNearestModel(fnbNearestList[i]));
          }
          return _listBuilder(placeList);
        }

        if (state is FnbActionLoadingPromo && state.fnbPromoPage != null) {
          final fnbPromoList = state.fnbPromoPage!.data;
          for (int i = 0; i < fnbPromoList.length; i++) {
            placeList.add(FnbActionModel.fromPromoModel(fnbPromoList[i]));
          }
          return _listBuilder(placeList);
        }

        if (state is FnbActionSuccessNearest) {
          final fnbNearestList = state.fnbNearestPage.data;
          if (fnbNearestList.isEmpty) return CustomEmptyState();
          for (int i = 0; i < fnbNearestList.length; i++) {
            placeList.add(FnbActionModel.fromNearestModel(fnbNearestList[i]));
          }
          return _listBuilder(placeList);
        }

        if (state is FnbActionSuccessPromo) {
          final fnbPromoList = state.fnbPromoPage.data;
          if (fnbPromoList.isEmpty) return CustomEmptyState();
          for (int i = 0; i < fnbPromoList.length; i++) {
            placeList.add(FnbActionModel.fromPromoModel(fnbPromoList[i]));
          }
          return _listBuilder(placeList);
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _listBuilder(List<FnbActionModel> placeList) {
    return ListView.builder(
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
