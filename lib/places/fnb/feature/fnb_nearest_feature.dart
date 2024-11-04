import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_it/common/app_export.dart';
import 'package:like_it/common/dataset/f_n_b_dataset.dart';
import 'package:like_it/common/widget/custom_section_header.dart';
import 'package:like_it/data/model/f_n_b_model.dart';
import 'package:like_it/data/model/merchant/merchant_nearby_model.dart';
import 'package:like_it/places/fnb/bloc/fnb_nearest_bloc.dart';
import 'package:like_it/places/fnb/fnb_detail_nearby_screen.dart';
import 'package:like_it/places/fnb/widget/fnb_place_item_nearby.dart';

class FnbNearestFeature extends StatelessWidget {
  const FnbNearestFeature({
    super.key,
    required this.parentContext,
    required this.parentScrollController,
    required this.childScrollController,
  });

  final BuildContext parentContext;
  final ScrollController parentScrollController;
  final ScrollController childScrollController;

  @override
  Widget build(BuildContext context) {
    // BlocProvider.of<FnbNearestBloc>(context).add(FnbNearestStarted());
    context.read<FnbNearestBloc>().add(FnbNearestStarted());
    final List<FNBModel> featuredListItems = FNBDataset().featuredItemsDataset;
    final List<MerchantNearby> merchantNearby = [];
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSectionHeader(
            label: context.tr("f_n_b.nearest"),
            // onPressed: () {},
            useIcon: false,
          ),
          SizedBox(height: 4.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.h),
            child: SizedBox(
              height: 450.h,
              width: double.maxFinite,
              child: NotificationListener(
                onNotification: (ScrollNotification notification) {
                  if (notification is ScrollUpdateNotification) {
                    if (notification.metrics.pixels ==
                        notification.metrics.maxScrollExtent) {
                      debugPrint('Reached the bottom');
                      parentScrollController.animateTo(
                          parentScrollController.position.maxScrollExtent,
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeIn);
                    } else if (notification.metrics.pixels ==
                        notification.metrics.minScrollExtent) {
                      debugPrint('Reached the top');
                      parentScrollController.animateTo(
                          parentScrollController.position.minScrollExtent,
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeIn);
                    }
                  }
                  return true;
                },
                child: _list(featuredListItems, merchantNearby),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _list(
    List<FNBModel> featuredListItems,
    List<MerchantNearby> merchantNearby,
  ) {
    return BlocBuilder<FnbNearestBloc, FnbNearestState>(
      builder: (context, state) {
        if (state is FnbNearestFailure) {
          return Text('ERROR MASZEEHHH'); // TODO Winky Help UI
        }
        if (state is! FnbNearestSuccess) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          controller: childScrollController,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: state.nearest.length,
          itemBuilder: (context, index) {
            return FnbPlaceItemNearby(
              merchant: state.nearest[index],
              onPressed: () {
                Navigator.push(
                    context,
                    DialogRoute(
                      context: context,
                      builder: (context) {
                        return FnbDetailNearbyScreen(
                          fnbModel: featuredListItems[index],
                          placeId: merchantNearby[index].placeId,
                        );
                      },
                    ));
              },
            );
          },
        );
      },
    );
  }
}
