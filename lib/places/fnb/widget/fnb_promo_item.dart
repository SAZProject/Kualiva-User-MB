import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/places/fnb/model/fnb_promo_model.dart';

class FnbPromoItem extends StatelessWidget {
  const FnbPromoItem({
    super.key,
    required this.merchant,
    required this.onPressed,
  });

  final FnbPromoModel merchant;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.h,
      margin: EdgeInsets.all(5.h),
      decoration: CustomDecoration(context).outlinePrmOnScd,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        borderRadius: BorderRadiusStyle.roundedBorder10,
        onTap: onPressed,
        child: ClipRRect(
          borderRadius: BorderRadiusStyle.roundedBorder9,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  CustomImageView(
                    imagePath: merchant.featuredImage ??
                        "${ImageConstant.fnb1Path}/A/2.jpg",
                    height: 130.h,
                    width: double.maxFinite,
                    boxFit: BoxFit.cover,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.h,
                      ),
                      decoration: CustomDecoration(context).outlinePrmPromo,
                      child: Text(
                        context.tr("f_n_b.promo_value", args: [
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
              SizedBox(height: 5.h),
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
                        style: theme(context).textTheme.bodySmall!.copyWith(
                            color: theme(context).colorScheme.primary,
                            fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      merchant.averageRating.toString(),
                      style: theme(context).textTheme.bodySmall!.copyWith(
                          color: theme(context).colorScheme.primary,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.h),
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        merchant.cityOrVillage,
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
                      merchant.distanceFromUser,
                      style: CustomTextStyles(context).bodySmall10,
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
                "f_n_b.tags_more",
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
      child: Center(
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: CustomTextStyles(context).bodySmall10.copyWith(
                color: theme(context).colorScheme.onPrimaryContainer,
              ),
        ),
      ),
    );
  }
}
