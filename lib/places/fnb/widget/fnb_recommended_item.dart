import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/places/fnb/model/fnb_recommended_model.dart';

class FnbRecommendedItem extends StatelessWidget {
  const FnbRecommendedItem({
    super.key,
    required this.place,
    required this.onPressed,
  });

  final FnbRecommendedModel place;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.h),
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.h),
      decoration: place.isMerchant
          ? CustomDecoration(context).outlinePrmOnScd
          : CustomDecoration(context)
              .outlineOnSecondaryContainer
              .copyWith(borderRadius: BorderRadiusStyle.roundedBorder10),
      child: InkWell(
        borderRadius: BorderRadiusStyle.roundedBorder10,
        onTap: onPressed,
        child: Row(
          children: [
            CustomImageView(
              width: 120.h,
              height: 120.h,
              imagePath:
                  place.featuredImage ?? "${ImageConstant.fnb1Path}/A/2.jpg",
              radius: BorderRadius.all(Radius.circular(10.h)),
              boxFit: BoxFit.cover,
            ),
            SizedBox(width: 5.h),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Visibility(
                        visible: place.isMerchant,
                        child: CustomImageView(
                          margin: EdgeInsets.only(right: 5.h),
                          imagePath: ImageConstant.appLogo2,
                          height: 20.h,
                          width: 20.h,
                          boxFit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          place.name,
                          style: theme(context).textTheme.bodySmall!.copyWith(
                              color: theme(context).colorScheme.primary,
                              fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.h),
                        child: Text(
                          place.averageRating.toString(),
                          style: theme(context).textTheme.bodySmall!.copyWith(
                              color: theme(context).colorScheme.primary,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.h),
                        child: Text(
                          "(${Random().nextInt(999) + 1})",
                          style: theme(context).textTheme.bodySmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  SizedBox(
                    height: 20.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(5, (index) {
                        return Icon(
                          Icons.attach_money,
                          size: 12.h,
                          color: index <= (place.averageRating.floor() - 1)
                              ? theme(context).colorScheme.primary
                              : null,
                        );
                      }),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          place.cityOrVillage,
                          style: CustomTextStyles(context).bodySmall10,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        " - ",
                        style: CustomTextStyles(context).bodySmall10,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        place.distanceFromUser,
                        style: CustomTextStyles(context).bodySmall10,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  _categoryTagList(context),
                  SizedBox(height: 5.h),
                  _isMerchantTagList(context),
                  SizedBox(height: 5.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _categoryTagList(BuildContext context) {
    return Visibility(
      visible: place.categories.first == "" ? false : true,
      child: SizedBox(
        height: 20.h,
        width: double.maxFinite,
        child: ListView.builder(
          itemCount: place.categories.length > 4 ? 4 : place.categories.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            if (index == 3) {
              if (place.categories.length > 4) {
                return _categoryTagView(
                  context,
                  context.tr(
                    "f_n_b.tags_more",
                    args: [(place.categories.length - 3).toString()],
                  ),
                );
              } else {
                return _categoryTagView(context, place.categories[index]);
              }
            }
            return _categoryTagView(context, place.categories[index]);
          },
        ),
      ),
    );
  }

  Widget _categoryTagView(BuildContext context, String label) {
    return Container(
      margin: EdgeInsets.only(right: 2.5),
      padding: EdgeInsets.symmetric(horizontal: 5.h),
      decoration: CustomDecoration(context).fillPrimary.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder50,
          ),
      child: Center(
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: CustomTextStyles(context).bodySmall10.copyWith(
                color: theme(context).colorScheme.onSecondaryContainer,
              ),
        ),
      ),
    );
  }

  Widget _isMerchantTagList(BuildContext context) {
    return Visibility(
      visible: place.isMerchant,
      child: SizedBox(
        height: 20.h,
        width: double.maxFinite,
        child: ListView.builder(
          itemCount: 2,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return _isMerchantTagView(
              context,
              index,
              ["f_n_b.is_merchant_tag_1", "f_n_b.is_merchant_tag_2"][index],
            );
          },
        ),
      ),
    );
  }

  Widget _isMerchantTagView(BuildContext context, int index, String label) {
    return Container(
      margin: EdgeInsets.only(right: 2.5),
      padding: EdgeInsets.symmetric(horizontal: 5.h),
      decoration: index == 0
          ? CustomDecoration(context).fillOrange300.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder50,
              )
          : CustomDecoration(context).fillOrange300_05.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder50,
              ),
      child: Center(
        child: Text(
          context.tr(label),
          textAlign: TextAlign.center,
          style: index == 0
              ? CustomTextStyles(context).bodySmall10.copyWith(
                  color: theme(context).colorScheme.onSecondaryContainer)
              : CustomTextStyles(context)
                  .bodySmall10
                  .copyWith(color: theme(context).colorScheme.primary),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
