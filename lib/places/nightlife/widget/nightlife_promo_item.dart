import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/places/nightlife/model/nightlife_promo_model.dart';

class NightlifePromoItem extends StatelessWidget {
  const NightlifePromoItem({
    super.key,
    required this.merchant,
    required this.onPressed,
  });

  final NightlifePromoModel merchant;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.h,
      margin: EdgeInsets.all(5.h),
      decoration: CustomDecoration(context).outlinePrmOnScd,
      child: InkWell(
        borderRadius: BorderRadiusStyle.roundedBorder10,
        onTap: onPressed,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 130.h,
              width: double.maxFinite,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CustomImageView(
                    alignment: Alignment.center,
                    imagePath: merchant.featuredImage ??
                        "${ImageConstant.fnb1Path}/A/2.jpg",
                    height: 130.h,
                    width: double.maxFinite,
                    radius: BorderRadius.vertical(
                      top: Radius.circular(10.h),
                    ),
                    boxFit: BoxFit.cover,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.h,
                      ),
                      decoration: CustomDecoration(context).outlinePrmPromo,
                      child: Text(
                        context.tr("nightlife.promo_value", args: [
                          merchant.promoPercentage.toString()
                        ]), // TODO: Percentage promo
                        style: theme(context).textTheme.labelLarge!.copyWith(
                              color: theme(context)
                                  .colorScheme
                                  .onSecondaryContainer,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.h),
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
                      merchant.name,
                      style: theme(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: theme(context).colorScheme.primary),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    merchant.averageRating.toString(),
                    style: theme(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: theme(context).colorScheme.primary),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.h),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      merchant.cityOrVillage,
                      style: theme(context).textTheme.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    merchant.distanceFromUser,
                    style: theme(context).textTheme.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(height: 5.h),
            _listTag(context),
            SizedBox(height: 5.h),
          ],
        ),
      ),
    );
  }

  Widget _listTag(BuildContext context) {
    final length =
        merchant.categories.length >= 2 ? 2 : merchant.categories.length;
    return SizedBox(
      height: 20.h,
      width: double.maxFinite,
      child: ListView.builder(
        itemCount: length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          if (index == 1) {
            return _tagView(
              context,
              context.tr(
                "nightlife.tags_more",
                args: [(length - 1).toString()],
              ),
            );
          }
          return _tagView(context, merchant.categories[index]);
        },
      ),
    );
  }

  Widget _tagView(BuildContext context, String label) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.h),
      padding: EdgeInsets.symmetric(horizontal: 5.h),
      decoration: CustomDecoration(context).fillPrimary.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder5,
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
}
