import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/common/widget/custom_empty_state.dart';
import 'package:kualiva/common/widget/custom_error_state.dart';
import 'package:kualiva/places/argument/place_argument.dart';
import 'package:kualiva/places/spa/bloc/spa_action_bloc.dart';
import 'package:kualiva/places/spa/model/spa_action_model.dart';
import 'package:kualiva/places/spa/widget/spa_action_item.dart';
import 'package:kualiva/router.dart';

class SpaActionFeature extends StatelessWidget {
  const SpaActionFeature({
    super.key,
    required this.onRetry,
  });

  final void Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: _listSpaAction(),
    );
  }

  Widget _listSpaAction() {
    return BlocBuilder<SpaActionBloc, SpaActionState>(
      builder: (context, state) {
        /// TODO: Clean Code Later, terlalu banyak boilerplate

        if (state is SpaActionFailure) {
          return CustomErrorState(
            errorMessage: context.tr('common.error_try_again'),
            onRetry: onRetry,
          );
        }

        /// Nearest
        if (state is SpaActionLoadingNearest && state.spaNearestPage != null) {
          final spaNearestList = state.spaNearestPage!.data;
          return _listBuilder(spaNearestList.map((e) {
            return SpaActionModel.fromNearestModel(e);
          }).toList());
        }

        if (state is SpaActionSuccessNearest) {
          final spaNearestList = state.spaNearestPage.data;
          if (spaNearestList.isEmpty) return CustomEmptyState();
          return _listBuilder(spaNearestList.map((e) {
            return SpaActionModel.fromNearestModel(e);
          }).toList());
        }

        /// Promo
        if (state is SpaActionLoadingPromo && state.spaPromoPage != null) {
          final spaPromoList = state.spaPromoPage!.data;
          return _listBuilder(spaPromoList.map((e) {
            return SpaActionModel.fromPromoModel(e);
          }).toList());
        }

        if (state is SpaActionSuccessPromo) {
          final spaPromoList = state.spaPromoPage.data;
          if (spaPromoList.isEmpty) return CustomEmptyState();
          return _listBuilder(spaPromoList.map((e) {
            return SpaActionModel.fromPromoModel(e);
          }).toList());
        }

        /// Recommended
        if (state is SpaActionLoadingRecommended &&
            state.spaRecommendedPage != null) {
          final spaRecommendedList = state.spaRecommendedPage!.data;
          return _listBuilder(spaRecommendedList.map((e) {
            return SpaActionModel.fromRecommendedModel(e);
          }).toList());
        }

        if (state is SpaActionSuccessRecommended) {
          final spaRecommendedList = state.spaRecommendedPage.data;
          if (spaRecommendedList.isEmpty) return CustomEmptyState();
          return _listBuilder(spaRecommendedList.map((e) {
            return SpaActionModel.fromRecommendedModel(e);
          }).toList());
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _listBuilder(List<SpaActionModel> placeList) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: placeList.length,
      itemBuilder: (context, index) {
        return SpaActionItem(
          place: placeList[index],
          onPressed: () {
            Navigator.pushNamed(
              context,
              AppRoutes.spaDetailScreen,
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
