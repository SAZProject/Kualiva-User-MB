import 'package:flutter/material.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/places/fnb/model/fnb_action_model.dart';
import 'package:kualiva/places/fnb/widget/fnb_action_item.dart';

class FnbActionFeature extends StatefulWidget {
  const FnbActionFeature({super.key, required this.listPlace});

  final List<FnbActionModel> listPlace;

  @override
  State<FnbActionFeature> createState() => _FnbActionFeatureState();
}

class _FnbActionFeatureState extends State<FnbActionFeature> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _body(context),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.h),
      child: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: widget.listPlace.length,
          itemBuilder: (context, index) {
            return FnbActionItem(
              place: widget.listPlace[index],
              onPressed: () {
                // TODO kalo udh pakai data asli dinyalain
                // Navigator.pushNamed(
                //   context,
                //   AppRoutes.fnbDetailScreen,
                //   arguments: PlaceArgument(
                //     placeId: fnbNearestList[index].id,
                //     isMerchant: fnbNearestList[index].isMerchant,
                //     featuredImage: fnbNearestList[index].featuredImage,
                //   ),
                // );
              },
            );
          },
        ),
      ),
    );
  }
}
