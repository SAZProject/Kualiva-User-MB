import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/places/nightlife/model/nightlife_promo_model.dart';

class NightlifePromoItem extends StatelessWidget {
  const NightlifePromoItem({
    super.key,
    required this.nightlifePromoModel,
    required this.onPressed,
  });

  final NightlifePromoModel nightlifePromoModel;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.h,
      margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 5.h),
      decoration: CustomDecoration(context)
          .outlineOnSecondaryContainer
          .copyWith(borderRadius: BorderRadiusStyle.roundedBorder10),
      child: InkWell(
        borderRadius: BorderRadiusStyle.roundedBorder10,
        onTap: onPressed,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 100.h,
              width: double.maxFinite,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CustomImageView(
                    alignment: Alignment.center,
                    imagePath: nightlifePromoModel.featuredImage ??
                        "${ImageConstant.fnb1Path}/A/2.jpg",
                    height: 100.h,
                    width: double.maxFinite,
                    radius: BorderRadius.vertical(
                      top: Radius.circular(10.h),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      height: 20.h,
                      width: 50.h,
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.h,
                        vertical: 2.h,
                      ),
                      decoration:
                          CustomDecoration(context).orange60Color.copyWith(
                                borderRadius: BorderRadiusStyle.roundedBorder10,
                              ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Icon(
                              Icons.star,
                              size: 12.h,
                            ),
                          ),
                          SizedBox(width: 4.h),
                          Text(
                            '${nightlifePromoModel.averageRating}',
                            style: theme(context).textTheme.labelMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.h,
                      ),
                      decoration: CustomDecoration(context)
                          .gradientPrimaryContainerToRedA,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.discount,
                            size: 15.h,
                          ),
                          SizedBox(width: 4.h),
                          Text(
                            context.tr("f_n_b.promo_value", args: [
                              (Random().nextInt(50) + 20).toString()
                            ]), // TODO: Percentage promo
                            style: theme(context).textTheme.labelLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 4.h),
              child: Row(
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.appLogo2,
                    height: 20.h,
                    width: 20.h,
                    boxFit: BoxFit.cover,
                  ),
                  Expanded(
                    child: Text(
                      nightlifePromoModel.name,
                      style: theme(context).textTheme.titleSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 4.h),
              child: Text(
                nightlifePromoModel.cityOrVillage,
                style: theme(context).textTheme.bodySmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 5.h),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _firstTagRow(context),
                SizedBox(height: 4.h),
                nightlifePromoModel.categories.length > 2
                    ? _secondTagRow(context)
                    : const SizedBox(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _firstTagRow(BuildContext context) {
    return SizedBox(
      height: 20.h,
      width: double.maxFinite,
      child: ListView.builder(
        itemCount: nightlifePromoModel.categories.length >= 2
            ? 2
            : nightlifePromoModel.categories.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return _tagView(context, nightlifePromoModel.categories[index]);
        },
      ),
    );
  }

  Widget _secondTagRow(BuildContext context) {
    return SizedBox(
      height: 20.h,
      width: double.maxFinite,
      child: ListView.builder(
        itemCount: nightlifePromoModel.categories.length > 4 ? 2 : 1,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          if (index == 1) {
            if (nightlifePromoModel.categories.length > 4) {
              return _tagView(
                context,
                context.tr(
                  "home_screen.tags_more",
                  args: [
                    (nightlifePromoModel.categories.length - 3).toString()
                  ],
                ),
              );
            } else {
              return _tagView(
                  context, nightlifePromoModel.categories[index + 2]);
            }
          }
          return _tagView(context, nightlifePromoModel.categories[index + 2]);
        },
      ),
    );
  }

  Widget _tagView(BuildContext context, String label) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.h),
      padding: EdgeInsets.symmetric(horizontal: 4.h),
      decoration: CustomDecoration(context).fillPrimary.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder5,
          ),
      child: Center(
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: CustomTextStyles(context).bodySmall10,
        ),
      ),
    );
  }
}
